class DateHelper {
  /// Returns the difference between two dates while ignoring the time
  ///
  /// This "fixes" the following unwanted behaviour:
  /// ```dart
  /// DateTime now = DateTime.now();
  /// DateTime nowSub = now.subtract(Duration(days: 1)).add(Duration(seconds: 1));
  ///
  /// print(now.difference(nowSub));
  /// /// // => 23:59:59.000000
  ///
  /// print(now.difference(nowSub).inDays);
  /// // => 0
  /// ```
  static int daysBetween(DateTime first, DateTime other) {
    return (first == null || other == null)
        ? null
        : DateTime(first.year, first.month, first.day)
            .difference(DateTime(other.year, other.month, other.day))
            .inDays;
  }

  static bool isToday(DateTime date) {
    return date == null
        ? null
        : DateHelper.daysBetween(date, DateTime.now()) == 0;
  }

  static int daysAgo(DateTime date) {
    return DateHelper.daysBetween(DateTime.now(), date);
  }

  static String dayAgoString(DateTime date) {
    int _d = DateHelper.daysBetween(DateTime.now(), date);
    return "$_d day${_d == 1 ? "" : "s"} ago";
  }

  /// Print dates as e.g. July 13th, 2020
  static String dateString(DateTime date) {
    return date == null
        ? null
        : "${monthString(date)} ${dayOrdinalString(date)}, ${date.year}";
  }

  static String dayOrdinalString(DateTime date) {
    String _s = date.day.toString();
    if (_s.length == 2) return _s + "th";
    switch (_s[_s.length - 1]) {
      case "1":
        return _s + "st";
      case "2":
        return _s + "nd";
      case "3":
        return _s + "rd";
      default:
        return _s + "th";
    }
  }

  static String weekdayString(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        throw ("Weekday above 7");
    }
  }

  static String monthString(DateTime date) {
    switch (date.month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        throw ("Month above 12");
    }
  }
}
