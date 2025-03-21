import 'package:intl/intl.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class TimeAgoT {
  static String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime notificationDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateString);
    final date2 = DateTime.now();
    final diff = date2.difference(notificationDate);
    if (diff.inDays > 365) return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.year).toString()}" : "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.years.toString())}"} ${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.ago).toString()}";
    if (diff.inDays > 30) return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.month).toString()}" : "${getTranslated(NavigationService.navigatorKey.currentState!.context,LangConst.months).toString()}"} ${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.ago).toString()}";
    if (diff.inDays > 7) return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.week).toString()}" : "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.weeks).toString()}"} ${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.ago).toString()}";
    if (diff.inDays > 0) return "${diff.inDays} ${diff.inDays == 1 ? "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.day).toString()}" : "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.days).toString()}"} ${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.ago).toString()}";
    if (diff.inHours > 0) return "${diff.inHours} ${diff.inHours == 1 ? "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.hour)}" : "${getTranslated(NavigationService.navigatorKey.currentState!.context,LangConst.hours).toString()}"} ${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.ago).toString()}";
    if (diff.inMinutes > 0) return "${diff.inMinutes} ${diff.inMinutes == 1 ? "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.minute).toString()}" : "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.minutes)}"} ${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.ago).toString()}";
    return getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.justNow).toString();
  }
}