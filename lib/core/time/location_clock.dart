import 'package:timezone/timezone.dart' as tz;

/// Converts UTC timestamps to a location IANA timezone for analytics/UI.
class LocationClock {
  const LocationClock();

  tz.Location location(String timezoneId) {
    try {
      return tz.getLocation(timezoneId);
    } catch (_) {
      return tz.UTC;
    }
  }

  DateTime toLocation(DateTime utc, String timezoneId) {
    return tz.TZDateTime.from(utc.toUtc(), location(timezoneId));
  }

  DateTime nowIn(String timezoneId) {
    return tz.TZDateTime.now(location(timezoneId));
  }

  DateTime startOfDayUtc(DateTime utcNow, String timezoneId) {
    final local = toLocation(utcNow, timezoneId);
    final startLocal = tz.TZDateTime(
      location(timezoneId),
      local.year,
      local.month,
      local.day,
    );
    return startLocal.toUtc();
  }

  bool isClosureDay(DateTime utc, String timezoneId, Set<String> yyyyMmDd) {
    final local = toLocation(utc, timezoneId);
    final key =
        '${local.year.toString().padLeft(4, '0')}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
    return yyyyMmDd.contains(key);
  }
}
