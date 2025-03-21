import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:dio/dio.dart';

class ApiHeader {
  Dio dioData() {
    final dio = Dio();
    dio.options.headers["Accept"] = "application/json"; // Config your dio headers globally
    dio.options.headers["Authorization"] = "Bearer " + SharedPreferenceHelper.getString(PreferencesNames.authToken);
    dio.options.followRedirects = false;
    dio.options.connectTimeout = Duration(seconds: 30); //5ss
    dio.options.receiveTimeout = Duration(seconds: 30);
    return dio;
  }
}
