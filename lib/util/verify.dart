bool verifyBirthDay(String input) {
  if (input.length != 8) {
    return false;
  }

  int year, month, day;
  try {
    year = int.parse(input.substring(0, 4));
    month = int.parse(input.substring(4, 6));
    day = int.parse(input.substring(6, 8));
  } catch (e) {
    return false;
  }

  if (year < 1900 || month < 1 || month > 12 || day < 1 || day > 31) {
    return false;
  }

  bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  List<int> daysInMonth = [
    31,
    isLeapYear ? 29 : 28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31,
  ];

  if (day > daysInMonth[month - 1]) {
    return false;
  }

  DateTime currentDate = DateTime.now();
  DateTime inputDate = DateTime(year, month, day);
  if (inputDate.isAfter(currentDate)) {
    return false;
  }

  return true;
}
