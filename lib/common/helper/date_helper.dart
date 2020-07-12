class DateHelper {
  static int daysBetween(DateTime a, DateTime b) {
    return (a == null || b == null) ? null : a.day - b.day;
  }
}
