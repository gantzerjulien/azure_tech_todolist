enum MonthEnum {
  january(1, "Janvier"),
  february(2, "Février"),
  march(3, "Mars"),
  april(4, "Avril"),
  may(5, "Mai"),
  june(6, "Juin"),
  july(7, "July"),
  august(8, "August"),
  september(9, "Septembre"),
  october(10, "Octobre"),
  november(11, "Novembre"),
  december(12, "Décembre");

  const MonthEnum(this.intValue, this.stringValue);

  int getNumberOfDays(int year) {
    switch (this) {
      case january:
      case march:
      case may:
      case july:
      case august:
      case october:
      case december:
        return 31;
      case april:
      case june:
      case september:
      case november:
        return 30;
      case february:
        return year % 4 == 0 ? 30 : 28;
    }
  }

  final int intValue;
  final String stringValue;
}