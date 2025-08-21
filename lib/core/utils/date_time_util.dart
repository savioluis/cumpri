class DateTimeUtil {
  static const List<String> _months = [
    "janeiro",
    "fevereiro",
    "março",
    "abril",
    "maio",
    "junho",
    "julho",
    "agosto",
    "setembro",
    "outubro",
    "novembro",
    "dezembro",
  ];

  static String getMonthName(int month) {
    return _months[month - 1];
  }
}
