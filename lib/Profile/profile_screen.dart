import 'package:multibusiness_business_app_flutter/Authentication/sign_in_screen.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/change_password_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/statistics_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/edit_business_profile_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/edit_user_profile_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/employees_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/photo_gallery_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/reviews_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/services_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/profile_provider.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/main.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileProvider profileProvider;
  int? value;
  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      profileProvider.callProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(
      context,
    );
    return ModalProgressHUD(
      inAsyncCall: profileProvider.profileLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeightBox(60),

              ///profile photo
              Align(
                alignment: Alignment.center,
                child: ExtendedImage.network(
                  SharedPreferenceHelper.getString(
                    PreferencesNames.imageUrl,
                  ),
                  fit: BoxFit.cover,
                  height: 90,
                  width: 90,
                  shape: BoxShape.circle,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return SpinKitThreeBounce(
                          color: AppColors.primarySwatch,
                          size: 20.0,
                        );
                      case LoadState.completed:
                        return ExtendedImage.network(
                          SharedPreferenceHelper.getString(
                            PreferencesNames.imageUrl,
                          ),
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                          shape: BoxShape.circle,
                        );
                      case LoadState.failed:
                        return CircleAvatar(
                          radius: 44,
                          backgroundImage: AssetImage("assets/app/profile.png"),
                        );
                    }
                  },
                ),
              ),
              HeightBox(8),

              ///user name
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${SharedPreferenceHelper.getString(
                    PreferencesNames.userName,
                  )}",
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographySemibold.textThemeLight.titleLarge
                      : TypographySemibold.textThemeDark.titleLarge,
                ),
              ),
              HeightBox(40),

              ///dashboard
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StatisticsScreen(),
                    ),
                  );
                },
                minLeadingWidth: 30,
                contentPadding: EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                leading: Icon(
                  Icons.dashboard_outlined,
                  color: AppColors.gray50,
                  size: 20,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.gray50,
                ),
                title: Text(
                  getTranslated(context, LangConst.statisticsLabel).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              ///employee
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EmployeesScreen(),
                    ),
                  );
                },
                minLeadingWidth: 30,
                contentPadding: EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                leading: Icon(
                  CupertinoIcons.person_3,
                  color: AppColors.gray50,
                  size: 20,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.gray50,
                ),
                title: Text(
                  getTranslated(context, LangConst.employeesLabel).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              ///Service
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ServicesScreen(),
                    ),
                  );
                },
                minLeadingWidth: 30,
                contentPadding: EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                leading: Transform.rotate(
                  angle: 90 * math.pi / 180,
                  child: Icon(
                    CupertinoIcons.scissors_alt,
                    color: AppColors.gray50,
                    size: 20,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.gray50,
                ),
                title: Text(
                  getTranslated(context, LangConst.servicesLabel).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              ///Photo Gallery
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PhotoGalleryScreen(),
                    ),
                  );
                },
                minLeadingWidth: 30,
                contentPadding: EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                leading: Icon(
                  Icons.photo_library_outlined,
                  color: AppColors.gray50,
                  size: 20,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.gray50,
                ),
                title: Text(
                  getTranslated(context, LangConst.photoGalleryLabel).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              ///Reviews
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReviewSScreen(),
                    ),
                  );
                },
                minLeadingWidth: 30,
                contentPadding: EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                leading: Icon(
                  Icons.star_border_rounded,
                  color: AppColors.gray50,
                  size: 20,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.gray50,
                ),
                title: Text(
                  getTranslated(context, LangConst.reviewsLabel).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              ///Business Profile
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditBusinessProfileScreen(),
                    ),
                  );
                },
                minLeadingWidth: 30,
                contentPadding: EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                leading: Icon(
                  Icons.store_outlined,
                  color: AppColors.gray50,
                  size: 20,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.gray50,
                ),
                title: Text(
                  getTranslated(context, LangConst.businessProfileLabel).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              ///Edit User Profile
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditUserProfileScreen(),
                    ),
                  );
                },
                minLeadingWidth: 30,
                contentPadding: EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                leading: Icon(
                  Icons.person_outline_sharp,
                  color: AppColors.gray50,
                  size: 20,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.gray50,
                ),
                title: Text(
                  getTranslated(context, LangConst.editUserProfileLabel).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              ///Change password
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordScreen(),
                    ),
                  );
                },
                minLeadingWidth: 30,
                contentPadding: EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                leading: Icon(
                  Icons.lock_outline,
                  color: AppColors.gray50,
                  size: 20,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.gray50,
                ),
                title: Text(
                  getTranslated(context, LangConst.changePassword).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              ///Language
              ListTile(
                minLeadingWidth: 30,
                onTap: () {
                  showLanguageModelBottomSheet();
                },
                contentPadding: EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                leading: Icon(
                  Icons.translate_outlined,
                  color: AppColors.gray50,
                  size: 20,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.gray50,
                ),
                title: Text(
                  getTranslated(context, LangConst.language).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              ///Push Notification
              SwitchListTile(
                inactiveTrackColor: AppColors.gray50,
                contentPadding: EdgeInsets.only(
                  left: 9,
                  right: 5,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                secondary: SizedBox(
                  width: 40,
                  child: Icon(
                    Icons.notifications_none,
                    color: AppColors.gray50,
                    size: 20,
                  ),
                ),
                title: Text(
                  getTranslated(context, LangConst.pushNotification).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
                value: profileProvider.isNotification,
                onChanged: (value) {
                  setState(() {
                    profileProvider.isNotification = value;
                  });
                  Map<String, dynamic> body = {"notification": profileProvider.isNotification == true ? 1 : 0};
                  profileProvider.callUpdateNotification(body);
                },
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              ///Email Notification
              SwitchListTile(
                contentPadding: EdgeInsets.only(
                  left: 9,
                  right: 5,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                secondary: SizedBox(
                  width: 40,
                  child: Icon(
                    Icons.email_outlined,
                    color: AppColors.gray50,
                    size: 20,
                  ),
                ),
                inactiveTrackColor: AppColors.gray50,
                title: Text(
                  getTranslated(context, LangConst.emailNotification).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
                value: profileProvider.isEmail,
                onChanged: (value) {
                  setState(() {
                    profileProvider.isEmail = value;
                  });
                  Map<String, dynamic> body = {"mail": profileProvider.isEmail == true ? 1 : 0};
                  profileProvider.callUpdateEmail(body);
                },
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              /// Switch for Time Format
              SwitchListTile(
                value: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24),
                onChanged: (value) {
                  setState(() {
                    SharedPreferenceHelper.setBoolean(PreferencesNames.timeFormat24, value);
                  });
                },
                title: Text(
                  getTranslated(context, LangConst.timeFormat24Hours).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
                secondary: SizedBox(
                  width: 40,
                  child: Icon(
                    Icons.access_time,
                    size: 20,
                    color: AppColors.gray50,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  left: 9,
                  right: 5,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                inactiveTrackColor: AppColors.gray50,
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),

              /// Switch for Dark Mode
              SwitchListTile(
                value: SharedPreferenceHelper.getBoolean(PreferencesNames.darkMode),
                onChanged: (value) {
                  setState(() {
                    SharedPreferenceHelper.setBoolean(PreferencesNames.darkMode, value);
                  });
                  DeviceUtils.toastMessage(getTranslated(context, LangConst.restartAppToSeeTheChanges).toString());
                },
                title: Text(
                  getTranslated(context, LangConst.darkMode).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyMedium.textThemeLight.titleMedium
                      : TypographyMedium.textThemeDark.titleMedium,
                ),
                secondary: SizedBox(
                  width: 40,
                  child: Icon(
                    Icons.dark_mode_outlined,
                    size: 20,
                    color: AppColors.gray50,
                  ),
                ),
                contentPadding: EdgeInsets.only(
                  left: 9,
                  right: 5,
                ),
                visualDensity: VisualDensity(
                  vertical: -4,
                  horizontal: -4,
                ),
                inactiveTrackColor: AppColors.gray50,
              ),
              Divider(
                indent: 0,
                endIndent: 0,
              ),


              ///logout
              ListTile(
                onTap: () {
                  showSignOut(context);
                },
                contentPadding: EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                visualDensity: VisualDensity(
                  horizontal: -4,
                  vertical: -4,
                ),
                title: Text(
                  getTranslated(context, LangConst.logout).toString(),
                  style: TypographyMedium.textThemeLight.titleMedium!.copyWith(
                    color: AppColors.danger500,
                  ),
                ),
                leading: Icon(
                  Icons.logout,
                  size: 20,
                  color: AppColors.danger500,
                ),
                minLeadingWidth: 30,
              ),
              HeightBox(
                Amount.screenMargin,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showSignOut(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.only(
              right: 16,
              bottom: 16,
              left: 16,
            ),
            title: Text(
              getTranslated(context, LangConst.logout).toString(),
            ),
            content: Text(
              getTranslated(context, LangConst.areYouSureToLogoutThisAccount).toString(),
              maxLines: 2,
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  getTranslated(context, LangConst.cancelLabel).toString(),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.transparent,
                    foregroundColor:
                        Theme.of(context).brightness == Brightness.light ? AppColors.gray700 : AppColors.gray50
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  SharedPreferenceHelper.remove(PreferencesNames.authToken);
                  SharedPreferenceHelper.remove(PreferencesNames.isLogin);
                  SharedPreferenceHelper.remove(PreferencesNames.email);
                  SharedPreferenceHelper.remove(PreferencesNames.userName);
                  SharedPreferenceHelper.remove(PreferencesNames.phoneNo);
                  SharedPreferenceHelper.remove(PreferencesNames.imageUrl);
                  SharedPreferenceHelper.remove(PreferencesNames.phoneCode);
                  SharedPreferenceHelper.remove(PreferencesNames.totalPoints);
                  SharedPreferenceHelper.remove(PreferencesNames.remainPoints);
                  SharedPreferenceHelper.remove(PreferencesNames.userId);
                  SharedPreferenceHelper.remove(PreferencesNames.currencySymbol);
                  SharedPreferenceHelper.remove(PreferencesNames.onesignalPushToken);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  getTranslated(context, LangConst.logout).toString(),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger500,
                ),
              ),
            ],
          );
        });
  }

  showLanguageModelBottomSheet() {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: Amount.screenMargin,
                    top: Amount.screenMargin,
                    bottom: Amount.screenMargin,
                    right: Amount.screenMargin,
                  ),
                  child: Text(
                    getTranslated(context, LangConst.selectLanguage).toString(),
                    style: Theme.of(context).brightness == Brightness.light
                        ? TypographySemibold.textThemeLight.titleLarge
                        : TypographySemibold.textThemeDark.titleLarge,
                  ),
                ),
                ListView.builder(
                    itemCount: Language.languageList().length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: Amount.screenMargin, right: Amount.screenMargin),
                    itemBuilder: (context, index) {
                      value = 0;
                      value = Language.languageList()[index].languageCode == SharedPreferenceHelper.getString(PreferencesNames.currentLanguageCode) ? index : null;
                      if (SharedPreferenceHelper.getString(PreferencesNames.currentLanguageCode) == 'N/A') {
                        value = 0;
                      }
                      return ListTile(
                        onTap: () async {
                          Locale local = await setLocale(Language.languageList()[index].languageCode);
                          setState(() {
                            MyApp.setLocale(context, local);
                            SharedPreferenceHelper.setString(PreferencesNames.currentLanguageCode, Language.languageList()[index].languageCode);
                            Navigator.of(context).pop();
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                        title: Text(
                          index == 0 ? "English (US)" : "Arabic",
                          style: Theme.of(context).brightness == Brightness.light
                              ? TypographySemibold.textThemeLight.labelLarge
                              : TypographySemibold.textThemeDark.labelLarge,
                        ),
                        trailing: Icon(
                          SharedPreferenceHelper.getString(PreferencesNames.currentLanguageCode) == 'N/A' && index == 0 || SharedPreferenceHelper.getString(PreferencesNames.currentLanguageCode) == Language.languageList()[index].languageCode
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: AppColors.primarySwatch,
                        ),
                      );
                    }),
                HeightBox(15),
              ],
            );
          });
        });
  }
}

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.id, this.name, this.flag, this.languageCode);

  static List<Language> languageList() {
    return <Language>[Language(1, 'English', '🇺🇸', 'en'), Language(2, 'Arabic', 'AE', 'ar')];
  }
}
