import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' as date_lib;
import 'package:intl/intl.dart';

class DeviceUtils {
  static toastMessage(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.black87, textColor: Colors.white, fontSize: 12);
  }

  ///05 Dec
  static String convertShortMonthName(String string) {
    DateTime dateTime = DateTime.parse(string);
    var a = date_lib.DateFormat("d MMM,yyyy").format(dateTime);
    return a.split(",")[0];
  }

  ///05 Dec, 2024
  static String convertShortMonthNameWYr(String string) {
    DateTime dateTime = DateTime.parse(string);
    var a = date_lib.DateFormat("d MMM, yyyy").format(dateTime);
    return a;
  }

  ///Mon
  static String getDay(String string) {
    DateTime dateTime = DateTime.parse(string);
    var a = date_lib.DateFormat('EEE').format(dateTime);
    return a.split(",")[0];
  }

  ///24 Hours Convert
  static String timeOfDayTo24HourString(int hour, int minutes) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, hour, minutes);
    final formattedTime = DateFormat.Hm().format(dateTime);
    print(formattedTime);
    return formattedTime;
  }

  ///string time convert time of day
  static TimeOfDay convertTimeOfDay(String convert) {
    TimeOfDay time = TimeOfDay(hour: int.parse(convert.split(":")[0]), minute: int.parse(convert.split(":")[1]));
    return time;
  }

  ///10:20
  static timeFormat(String time) {
    return DateFormat.jm().format(DateFormat("hh:mm").parse(time));
  }

  static String convertTo24HourFormat(String time12Hour) {
    final format = DateFormat.jm(); // "jm" represents 12-hour format
    final dateTime = format.parse(time12Hour);
    final format24Hour = DateFormat.Hm(); // "Hm" represents 24-hour format
    return format24Hour.format(dateTime);
  }

  static toastMessageExpired(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 12,
    );
  }

}

// Extennsion Method on String
extension StringExt on String? {
  String ucFirst() {
    if (this == null) return "";
    return this![0].toUpperCase() + this!.substring(1).toLowerCase();
  }
}
