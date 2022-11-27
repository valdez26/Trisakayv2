import 'package:intl/intl.dart';

class DateFormatClass {
  DateTime? _date;
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  DateFormatClass();

  DateFormatClass.getDateTime(DateTime date) {
    _date = date;
  }

  String getTodayDateToString() {
    return "${getMonthToName(_date!.month)} ${_date!.day} ${_date!.year}";
  }

  String getMonthToName(int month) {
    return months[month - 1];
  }

  String getCurrentTimeToString() {
    int hour = 0;
    int minute = 0;
    String timeAbbreviation = '';

    hour = _date!.hour > 12 ? _date!.hour - 12 : _date!.hour;
    minute = _date!.minute;
    timeAbbreviation = _date!.hour >= 12 ? "PM" : "AM";

    return "$hour:$minute $timeAbbreviation";
  }

  String getDateWithFormat() {
    //Get day of week example return value: Monday
    return DateFormat('EEEE').format(_date!);
  }

  DateTime convertFirebaseDateStringToLocalDate(String firebaseDate) {
    //Convert Custom Format date for firebase
    //Convert Custom Date from firebase to Date
    int month = 1;
    int day = 1;
    int year = 2020;
    int hour = 1;
    int minute = 1;
    String extensionName = "AM";

    // M/D/YTH:M:S AM
    var dateAndTime = firebaseDate.split('T');
    // month/day/year
    var date = dateAndTime[0].split('/');
    var separrateAbbreviation = dateAndTime[1].split(' ');
    var time = separrateAbbreviation[0].split(":");

    month = int.parse(date[0]);
    day = int.parse(date[1]);
    year = int.parse(date[2]);

    hour = int.parse(time[0]);
    minute = int.parse(time[1]);

    extensionName = separrateAbbreviation[1];

    if (!extensionName.contains("AM")) {
      hour += 12;
    }

    return DateTime(year, month, day, hour, minute);
  }

  String getDateTimeConvertedToFirebaseDate() {
    //Convert Custom Format date for firebase
    //Firebase save date with utc 7 [bug]
    DateTime date = DateTime.now();

    int month = date.month;
    int day = date.day;
    int year = date.year;
    int hour = 1;
    int minute = date.minute;
    String extensionName = "AM";

    if (date.hour > 12) {
      hour = date.hour - 12;
      extensionName = "PM";
    }

    return "$month/$day/${year}T$hour:$minute $extensionName";
  }
}
