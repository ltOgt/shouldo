enum Ordering {
  DUE_DATE_CLOSEST_FIRST,
  //DUE_DATE_FURTHEST_FIRST, // TODO consider for future, but right now 1 and 4 focus
  //START_DATE_NEWEST_FIRST,
  START_DATE_OLDEST_FIRST,
}

extension OrderingExtension on Ordering {
  Ordering next() {
    int nextIndex = this.index + 1;
    return Ordering.values[nextIndex % Ordering.values.length];
  }

  String toReadable() {
    //
    if (this == Ordering.DUE_DATE_CLOSEST_FIRST) {
      return "Order by remaining time, descending";
    }
    //
    else if (this == Ordering.START_DATE_OLDEST_FIRST) {
      return "Order by elapsed time, descending";
    }
    // : Seal
    else {
      throw ("Ordering; Unmapped value: <$this>");
    }
  }
}
