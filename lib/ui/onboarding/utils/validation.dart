String? startYearValidation({required String value}) {
  if (value.isEmpty) {
    return null;
  }
  try {
    final int year = int.parse(value);
    if (year != DateTime.now().year) {
      return '연도를 정확히 입력해주세요';
    }
    return null;
  } on Exception {
    return '숫자만 입력해주세요';
  }
}

String? endYearValidation({required String value}) {
  if (value.isEmpty) {
    return null;
  }
  try {
    final int year = int.parse(value);
    if (year < DateTime.now().year) {
      return '연도를 정확히 입력해주세요';
    }
    return null;
  } on Exception {
    return '숫자만 입력해주세요';
  }
}

String? birthYearValidation({required String value}) {
  if (value.isEmpty) {
    return null;
  }
  try {
    final int year = int.parse(value);
    if (year >= DateTime.now().year) {
      return '태어난 연도를 정확히 입력해주세요';
    }
    return null;
  } on Exception {
    return '숫자만 입력해주세요';
  }
}

String? monthValidation({required String value}) {
  if (value.isEmpty) {
    return null;
  }
  try {
    final int month = int.parse(value);
    if (month < 1 || month > 12) {
      return '월을 정확히 입력해주세요';
    }
    return null;
  } on Exception {
    return '숫자만 입력해주세요';
  }
}

String? hourValidation({required String value}) {
  if (value.isEmpty) {
    return null;
  }
  try {
    final int hour = int.parse(value);
    if (hour < 1 || hour > 12) {
      return '시간을 정확히 입력해주세요';
    }
    return null;
  } on Exception {
    return '숫자만 입력해주세요';
  }
}

String? minuteValidation({required String value}) {
  if (value.isEmpty) {
    return null;
  }
  try {
    final int minute = int.parse(value);
    if (minute < 0 || minute > 59) {
      return '분을 정확히 입력해주세요';
    }
    return null;
  } on Exception {
    return '숫자만 입력해주세요';
  }
}

bool isValidDate(String year, String month, String day) {
  if (year.isEmpty || month.isEmpty || day.isEmpty) {
    return true;
  }

  try {
    final int y = int.parse(year);
    final int m = int.parse(month);
    final int d = int.parse(day);

    final DateTime date = DateTime(y, m, d);
    return date.year == y && date.month == m && date.day == d;
  } on Exception {
    return false;
  }
}

String? startDayValidation({
  required String day,
  required String month,
  required String year,
  bool isBirthday = false,
}) {
  if (day.isEmpty || month.isEmpty || year.isEmpty) {
    return null;
  }

  try {
    int.parse(day);
  } on Exception {
    return '숫자만 입력해주세요';
  }

  final int intDay = int.parse(day);
  if (intDay < 1 || intDay > 31) {
    return '일을 정확히 입력해주세요';
  }

  if (!isValidDate(year, month, day)) {
    return '유효하지 않은 날짜입니다';
  }

  if (!isBirthday && year.isNotEmpty && month.isNotEmpty) {
    try {
      final DateTime inputDate = DateTime(
        int.parse(year),
        int.parse(month),
        int.parse(day),
      );
      final DateTime today = DateTime.now();
      if (inputDate.isBefore(DateTime(today.year, today.month, today.day))) {
        return '오늘보다 이전 날짜는 선택할 수 없습니다';
      }
    } on Exception {
      //
    }
  }

  return null;
}

String? endDayValidation({
  required String endDay,
  required String endMonth,
  required String endYear,
  required String startDay,
  required String startMonth,
  required String startYear,
}) {
  if (endDay.isEmpty) {
    return null;
  }

  try {
    int.parse(endDay);
  } on Exception {
    return '숫자만 입력해주세요';
  }

  final int intDay = int.parse(endDay);
  if (intDay < 1 || intDay > 31) {
    return '일을 정확히 입력해주세요';
  }

  if (!isValidDate(endYear, endMonth, endDay)) {
    return '유효하지 않은 날짜입니다';
  }

  if (startYear.isNotEmpty &&
      startMonth.isNotEmpty &&
      startDay.isNotEmpty &&
      endYear.isNotEmpty &&
      endMonth.isNotEmpty) {
    try {
      final DateTime startDate = DateTime(
        int.parse(startYear),
        int.parse(startMonth),
        int.parse(startDay),
      );
      final DateTime endDate = DateTime(
        int.parse(endYear),
        int.parse(endMonth),
        int.parse(endDay),
      );

      if (endDate.isBefore(startDate)) {
        return '종료일이 시작일보다 빠를 수 없습니다';
      }

      final int difference = endDate.difference(startDate).inDays;
      if (difference < 14) {
        return '기간은 최소 14일 이상이어야 합니다';
      }
    } on Exception {
      //
    }
  }

  return null;
}
