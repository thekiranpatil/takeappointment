import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppBarBack extends StatelessWidget {
  const AppBarBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: SharedPreferenceHelper.getString(PreferencesNames.currentLanguageCode) == "en" || SharedPreferenceHelper.getString(PreferencesNames.currentLanguageCode) == "N/A"
            ? EdgeInsets.only(
                left: 8,
                top: 8,
                bottom: 8,
                right: 5,
              )
            : EdgeInsets.only(left: 5, top: 8, bottom: 8, right: 8),
        padding: SharedPreferenceHelper.getString(PreferencesNames.currentLanguageCode) == "en" || SharedPreferenceHelper.getString(PreferencesNames.currentLanguageCode) == "N/A"
            ? EdgeInsets.only(top: 8, bottom: 8, left: 11, right: 5)
            : EdgeInsets.only(top: 8, bottom: 8, left: 5, right: 11),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadius.k10,
          color: Theme.of(context).brightness == Brightness.light ? AppColors.neutral100 : AppColors.backgroundDark,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: AppColors.gray50,
        ),
      ),
    );
  }
}
