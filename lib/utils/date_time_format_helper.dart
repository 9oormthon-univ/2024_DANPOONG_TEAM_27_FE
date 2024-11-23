import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String getTimeString(DateTime dateTime) {
    final bool isAfternoon = dateTime.hour > 12;

    final String minuteString = dateTime.minute.toString().padLeft(2, '0');

    return isAfternoon
        ? '오후 ${dateTime.hour - 12}시 $minuteString분'
        : '오전 ${dateTime.hour}시 $minuteString분';
  }

  static String getSimpleTimeString(DateTime dateTime) {
    final String formattedTime =
        '${_twoDigitFormat(dateTime.hour)}:${_twoDigitFormat(dateTime.minute)}';
    return formattedTime;
  }

  static String getFormattedDateTimeString(DateTime dateTime) {
    final String formattedDateTime =
        // ignore:lines_longer_than_80_chars
        '${dateTime.year % 100}.${_twoDigitFormat(dateTime.month)}.${_twoDigitFormat(dateTime.day)}\n${_twoDigitFormat(dateTime.hour)}:${_twoDigitFormat(dateTime.minute)}';
    return formattedDateTime;
  }

  static String getInputDateTimeString(DateTime dateTime) {
    final String formattedDateTime =
        // ignore:lines_longer_than_80_chars
        '${dateTime.year}${_twoDigitFormat(dateTime.month)}${_twoDigitFormat(dateTime.day)}';
    return formattedDateTime;
  }

  static String getTimeDifference(DateTime dateTime) {
    final DateTime now = DateTime.now();

    final Duration difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return '오늘';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (dateTime.year == now.year) {
      // ignore:lines_longer_than_80_chars
      return '${_twoDigitFormat(dateTime.month)}.${_twoDigitFormat(dateTime.day)}';
    } else {
      final int year = dateTime.year % 100;
      // ignore:lines_longer_than_80_chars
      return '${_twoDigitFormat(year)}.${_twoDigitFormat(dateTime.month)}.${_twoDigitFormat(dateTime.day)}';
    }
  }

  static String getDate(DateTime dateTime) {
    final String formattedDate = DateFormat('MM월 dd일').format(dateTime);
    return formattedDate;
  }

  static String getDayOfWeek(DateTime date) {
    final List<String> weekdays = <String>['월', '화', '수', '목', '금', '토', '일'];
    return weekdays[date.weekday - 1];
  }

  // dateTime에 가장 가까운 경매일을 구하는 함수
  static DateTime getNearestPrevAuctionDate(DateTime dateTime) {
    // weekday:요일 => 1:월 ~ 7:일
    final int weekday = dateTime.weekday;

    final DateTime nearestPrevDate;

    if (weekday == DateTime.wednesday ||
        weekday == DateTime.friday ||
        weekday == DateTime.sunday) {
      nearestPrevDate = dateTime.subtract(const Duration(days: 2));
    } else if (weekday == DateTime.monday) {
      nearestPrevDate = dateTime.subtract(const Duration(days: 3));
    } else {
      nearestPrevDate = dateTime.subtract(const Duration(days: 1));
    }

    return nearestPrevDate;
  }

  static String getDateAndTime(DateTime dateTime) => '${<String>[
        dateTime.year.toString().substring(2, 4),
        _twoDigitFormat(dateTime.month),
        _twoDigitFormat(dateTime.day)
      ].join('.')} ${getSimpleTimeString(dateTime)}';

  static String _twoDigitFormat(int number) =>
      number.toString().padLeft(2, '0');

  static int getWeekOfMonth({required DateTime date}) {
    // 입력된 날짜의 연도와 월 정보를 사용하여 해당 월의 첫 번째 날을 계산합니다.
    final DateTime firstDayOfMonth = DateTime(date.year, date.month);

    // 첫 번째 날의 요일을 구합니다.
    final int firstDay = firstDayOfMonth.weekday;

    // 첫 번째 월요일의 날짜를 계산합니다.
    final int offset = (firstDay - DateTime.monday + 7) % 7;
    final DateTime firstMonday =
        firstDayOfMonth.subtract(Duration(days: offset));

    // 입력된 날짜와 첫 번째 월요일 사이의 일수 차이를 구합니다.
    final int difference = date.difference(firstMonday).inDays;

    // 일수 차이를 주 단위로 변환하여 해당 주차를 계산합니다.
    return (difference ~/ 7) + 1;
  }
}
