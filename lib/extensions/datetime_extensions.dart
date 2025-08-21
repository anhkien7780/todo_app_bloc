extension DatetimeExtensions on DateTime {
  DateTime withTimeOf(DateTime other) {
    return DateTime(
      year,
      month,
      day,
      other.hour,
      other.minute,
      other.second,
      other.millisecond,
      other.microsecond,
    );
  }
}
