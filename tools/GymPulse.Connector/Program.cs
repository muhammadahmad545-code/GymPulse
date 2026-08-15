using System.Globalization;
using System.Text;
using System.Text.Json;

namespace GymPulse.Connector;

/// Offline export normalizer. Reads official CSV/JSON drops and writes a
/// GymPulse attendance file. No vendor APIs, no cloud relay.
internal static class Program
{
    private static readonly string[] EventIdHeaders = ["external_event_id", "event_id", "id"];
    private static readonly string[] MemberHeaders = ["external_member_id", "member_id", "memberid", "user_id"];
    private static readonly string[] TimeHeaders = ["occurred_at", "timestamp", "time", "datetime", "date"];
    private static readonly string[] TypeHeaders = ["event_type", "type"];

    public static int Main(string[] args)
    {
        var input = Arg(args, "--in") ?? "in";
        var output = Arg(args, "--out") ?? Path.Combine("out", "gympulse-attendance.csv");
        Directory.CreateDirectory(Path.GetDirectoryName(Path.GetFullPath(output)) ?? "out");

        if (!Directory.Exists(input))
        {
            Console.Error.WriteLine($"Input folder not found: {input}");
            Console.Error.WriteLine("Usage: GymPulse.Connector --in <folder> --out <file.csv>");
            return 2;
        }

        var events = new List<NormalizedEvent>();
        foreach (var file in Directory.EnumerateFiles(input).OrderBy(f => f, StringComparer.OrdinalIgnoreCase))
        {
            var ext = Path.GetExtension(file).ToLowerInvariant();
            if (ext is ".csv" or ".txt")
            {
                events.AddRange(ParseCsv(File.ReadAllText(file), Path.GetFileName(file)));
            }
            else if (ext == ".json")
            {
                events.AddRange(ParseJson(File.ReadAllText(file), Path.GetFileName(file)));
            }
        }

        var seen = new HashSet<string>(StringComparer.Ordinal);
        var unique = new List<NormalizedEvent>();
        foreach (var item in events)
        {
            var key = $"{item.ExternalEventId}|{item.ExternalMemberId}|{item.OccurredAt:o}|{item.EventType}";
            if (seen.Add(key)) unique.Add(item);
        }

        var sb = new StringBuilder();
        sb.AppendLine("external_event_id,external_member_id,occurred_at,event_type");
        foreach (var item in unique)
        {
            sb.Append(Csv(item.ExternalEventId)).Append(',')
              .Append(Csv(item.ExternalMemberId)).Append(',')
              .Append(item.OccurredAt.ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ", CultureInfo.InvariantCulture)).Append(',')
              .AppendLine(Csv(item.EventType));
        }
        File.WriteAllText(output, sb.ToString(), new UTF8Encoding(encoderShouldEmitUTF8Identifier: false));
        Console.WriteLine($"Wrote {unique.Count} event(s) to {output}");
        return 0;
    }

    private static string? Arg(string[] args, string name)
    {
        for (var i = 0; i < args.Length - 1; i++)
        {
            if (string.Equals(args[i], name, StringComparison.OrdinalIgnoreCase))
            {
                return args[i + 1];
            }
        }
        return null;
    }

    private static IEnumerable<NormalizedEvent> ParseCsv(string text, string fileName)
    {
        var lines = text.Replace("\r\n", "\n").Replace('\r', '\n')
            .Split('\n', StringSplitOptions.RemoveEmptyEntries);
        if (lines.Length == 0) yield break;
        var header = lines[0].Split(',').Select(NormalizeHeader).ToArray();
        var eventIdx = IndexOf(header, EventIdHeaders);
        var memberIdx = IndexOf(header, MemberHeaders);
        var timeIdx = IndexOf(header, TimeHeaders);
        var typeIdx = IndexOf(header, TypeHeaders);
        if (memberIdx is null || timeIdx is null) yield break;
        for (var i = 1; i < lines.Length; i++)
        {
            var cols = lines[i].Split(',');
            var member = Cell(cols, memberIdx.Value);
            var occurredRaw = Cell(cols, timeIdx.Value);
            if (string.IsNullOrWhiteSpace(member) || !DateTime.TryParse(occurredRaw, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out var occurred))
            {
                continue;
            }
            var eventId = eventIdx is null ? $"csv-{fileName}-{i}-{member}" : Cell(cols, eventIdx.Value);
            yield return new NormalizedEvent(
                string.IsNullOrWhiteSpace(eventId) ? $"csv-{fileName}-{i}-{member}" : eventId,
                member,
                occurred,
                typeIdx is null || string.IsNullOrWhiteSpace(Cell(cols, typeIdx.Value)) ? "check_in" : Cell(cols, typeIdx.Value));
        }
    }

    private static IEnumerable<NormalizedEvent> ParseJson(string text, string fileName)
    {
        using var doc = JsonDocument.Parse(text);
        var root = doc.RootElement;
        var rows = new List<JsonElement>();
        if (root.ValueKind == JsonValueKind.Array)
        {
            rows.AddRange(root.EnumerateArray());
        }
        else if (root.ValueKind == JsonValueKind.Object)
        {
            if (root.TryGetProperty("events", out var events) ||
                root.TryGetProperty("attendance", out events) ||
                root.TryGetProperty("data", out events))
            {
                if (events.ValueKind == JsonValueKind.Array) rows.AddRange(events.EnumerateArray());
            }
            else
            {
                rows.Add(root);
            }
        }

        for (var i = 0; i < rows.Count; i++)
        {
            var row = rows[i];
            if (row.ValueKind != JsonValueKind.Object) continue;
            var member = First(row, "externalMemberId", "external_member_id", "member_id", "memberId", "user_id");
            var occurredRaw = First(row, "occurredAt", "occurred_at", "timestamp", "time", "datetime", "date");
            if (string.IsNullOrWhiteSpace(member) || !DateTime.TryParse(occurredRaw, CultureInfo.InvariantCulture, DateTimeStyles.RoundtripKind, out var occurred))
            {
                continue;
            }
            var eventId = First(row, "externalEventId", "external_event_id", "event_id", "id");
            var type = First(row, "eventType", "event_type", "type");
            yield return new NormalizedEvent(
                string.IsNullOrWhiteSpace(eventId) ? $"json-{fileName}-{i}-{member}" : eventId,
                member,
                occurred,
                string.IsNullOrWhiteSpace(type) ? "check_in" : type);
        }
    }

    private static string NormalizeHeader(string value) => value.Trim().ToLowerInvariant().Replace(' ', '_');

    private static int? IndexOf(string[] header, string[] aliases)
    {
        foreach (var alias in aliases)
        {
            var idx = Array.IndexOf(header, alias);
            if (idx >= 0) return idx;
        }
        return null;
    }

    private static string Cell(string[] cols, int index) => index < cols.Length ? cols[index].Trim() : "";

    private static string First(JsonElement row, params string[] keys)
    {
        foreach (var key in keys)
        {
            if (row.TryGetProperty(key, out var value) && value.ValueKind != JsonValueKind.Null)
            {
                var text = value.ToString().Trim();
                if (!string.IsNullOrWhiteSpace(text)) return text;
            }
        }
        return "";
    }

    private static string Csv(string value) =>
        value.Contains(',') || value.Contains('"') || value.Contains('\n')
            ? $"\"{value.Replace("\"", "\"\"")}\""
            : value;

    private sealed record NormalizedEvent(
        string ExternalEventId,
        string ExternalMemberId,
        DateTime OccurredAt,
        string EventType);
}
