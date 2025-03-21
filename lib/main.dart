import 'package:multibusiness_business_app_flutter/Appointment/Provider/appointments_provider.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Provider/auth_provider.dart';
import 'package:multibusiness_business_app_flutter/Authentication/sign_in_screen.dart';
import 'package:multibusiness_business_app_flutter/Clients/Provider/clients_provider.dart';
import 'package:multibusiness_business_app_flutter/Home/Provider/employee_provider.dart';
import 'package:multibusiness_business_app_flutter/Home/Provider/notification_provider.dart';
import 'package:multibusiness_business_app_flutter/Localization/language_localization.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/business_provider.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/gallery_provider.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/profile_provider.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/review_provider.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/service_provider.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/statistics_provider.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((local) => {
          setState(() {
            this._locale = local;
          })
        });
    super.didChangeDependencies();
  }
  Future<void> checkFor24HourSwitchValue() async {
    SharedPreferences sharedPref = await SharedPreferenceHelper.instance;
    if (!sharedPref.containsKey(PreferencesNames.timeFormat24)) {
      sharedPref.setBool(PreferencesNames.timeFormat24, false);
    }
  }
  
  Future<void> checkForDarkMode() async {
    SharedPreferences sharedPref = await SharedPreferenceHelper.instance;
    if (!sharedPref.containsKey(PreferencesNames.darkMode)) {
      sharedPref.setBool(PreferencesNames.darkMode, false);
    }
  }
  @override
  Widget build(BuildContext context) {
    checkFor24HourSwitchValue();
    checkForDarkMode();
    if (_locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<EmployeeProvider>(
            create: (context) => EmployeeProvider(),
          ),
          ChangeNotifierProvider<AppointmentsProvider>(
            create: (context) => AppointmentsProvider(),
          ),
          ChangeNotifierProvider<ClientsProvider>(
            create: (context) => ClientsProvider(),
          ),
          ChangeNotifierProvider<ProfileProvider>(
            create: (context) => ProfileProvider(),
          ),
          ChangeNotifierProvider<StatisticsProvider>(
            create: (context) => StatisticsProvider(),
          ),
          ChangeNotifierProvider<ReviewProvider>(
            create: (context) => ReviewProvider(),
          ),
          ChangeNotifierProvider<GalleryProvider>(
            create: (context) => GalleryProvider(),
          ),
          ChangeNotifierProvider<ServiceProvider>(
            create: (context) => ServiceProvider(),
          ),
          ChangeNotifierProvider<NotificationProvider>(
            create: (context) => NotificationProvider(),
          ),
          ChangeNotifierProvider<BusinessProvider>(
            create: (context) => BusinessProvider(),
          ),
        ],
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: MaterialApp(
            title: "Multi Business - Business",
            debugShowCheckedModeBanner: false,
            theme: SharedPreferenceHelper.getBoolean(PreferencesNames.darkMode)
                ? CustomTheme.darkTheme
                : CustomTheme.lightTheme,
            locale: _locale,
            supportedLocales: [
              Locale(ENGLISH, 'US'),
              Locale(ARABIC, 'AE'),
            ],
            localizationsDelegates: [
              LanguageLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              SfGlobalLocalizations.delegate
            ],
            localeResolutionCallback: (deviceLocal, supportedLocales) {
              for (var local in supportedLocales) {
                if (local.languageCode == deviceLocal!.languageCode && local.countryCode == deviceLocal.countryCode) {
                  return deviceLocal;
                }
              }
              return supportedLocales.first;
            },
            navigatorKey: NavigationService.navigatorKey,
            home: SharedPreferenceHelper.getBoolean(PreferencesNames.isLogin) == false ? SignInScreen() : DashBoardScreen(),
          ),
        ),
      );
    }
  }
}
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}