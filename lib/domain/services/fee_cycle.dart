/// Calendar-month fee arithmetic for Mr. Gym.
///
/// Rule: same day-of-month when that day exists, otherwise the last valid
/// day of the target month. January 31 → February 28/29. Never add 30 days.
class FeeCycle {
  const FeeCycle();

  DateTime dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);

  int lastDayOfMonth(int year, int month) => DateTime(year, month + 1, 0).day;

  int clampDay(int year, int month, int day) {
    final last = lastDayOfMonth(year, month);
    return day > last ? last : day;
  }

  DateTime addCalendarMonths(DateTime date, int months) {
    final rawMonth = date.month + months;
    final year = date.year + ((rawMonth - 1) ~/ 12);
    var month = rawMonth % 12;
    if (month <= 0) month += 12;
    final day = clampDay(year, month, date.day);
    return DateTime(year, month, day);
  }

  /// Next fee date on or after [today] using the member's joining/fee day.
  DateTime nextFeeDate({required DateTime joinedAt, required DateTime today}) {
    final join = dateOnly(joinedAt);
    final now = dateOnly(today);
    if (now.isBefore(join)) return join;
    final thisMonth = DateTime(
      now.year,
      now.month,
      clampDay(now.year, now.month, join.day),
    );
    if (!thisMonth.isBefore(now)) return thisMonth;
    return addCalendarMonths(thisMonth, 1);
  }

  /// The fee date that just applied or applies today.
  DateTime currentCycleDate({
    required DateTime joinedAt,
    required DateTime today,
  }) {
    final next = nextFeeDate(joinedAt: joinedAt, today: today);
    if (_sameDay(next, dateOnly(today))) return next;
    return addCalendarMonths(next, -1);
  }

  DateTime membershipEndFromStart(DateTime startAt) =>
      addCalendarMonths(dateOnly(startAt), 1);

  bool isDueToday({required DateTime feeDate, required DateTime today}) =>
      _sameDay(dateOnly(feeDate), dateOnly(today));

  bool isDueInDays({
    required DateTime feeDate,
    required DateTime today,
    required int days,
  }) {
    return _sameDay(
      dateOnly(feeDate),
      dateOnly(today).add(Duration(days: days)),
    );
  }

  bool isOverdue({required DateTime feeDate, required DateTime today}) =>
      dateOnly(today).isAfter(dateOnly(feeDate));

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
