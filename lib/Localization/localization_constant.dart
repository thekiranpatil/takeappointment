import 'package:multibusiness_business_app_flutter/Localization/language_localization.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String? getTranslated(BuildContext context, String key) {
  return LanguageLocalization.of(context)!.getTranslateValue(key);
}

const String ENGLISH = "en";
const String ARABIC = "ar";

Future<Locale> setLocale(String languageCode) async {
  SharedPreferenceHelper.setString(PreferencesNames.currentLanguageCode, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      break;
    case ARABIC:
      _temp = Locale(languageCode, 'AE');
      break;
    default:
      _temp = Locale(ENGLISH, 'US');
  }
  return _temp;
}

Future<Locale> getLocale() async {
  String? languageCode = SharedPreferenceHelper.getString(PreferencesNames.currentLanguageCode);
  return _locale(languageCode);
}
