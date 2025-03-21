import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/app_setting_response.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/apis.dart';

void main() {
  test(
    'Check pattern of baseUrl in Apis',
    () {
      // Define the regex pattern for the URL
      var pattern1 = RegExp(r'^https:\/\/.*\/api\/admin\/$');
      var pattern2 = RegExp(r'^http:\/\/.*\/api\/admin\/$');

      // Check if the baseUrl matches the pattern
      expect(
        ((pattern1.hasMatch(Apis.baseUrl) || pattern2.hasMatch(Apis.baseUrl)) &&
            Apis.baseUrl != "https://takeappointment.in/api/admin/"),
        isTrue,
        reason: 'The baseUrl does not match the required pattern',
      );
    },
  );

  test(
    'api_services.g.dart file exists',
    () {
      var filePath = 'lib/Network/api_services.g.dart';

      // Check if the file exists
      expect(File(filePath).existsSync(), isTrue,
          reason: 'api_services.g.dart file does not exist/\n'
              'Please run the command: flutter pub run build_runner build --delete-conflicting-outputs');
    },
  );

  test(
    'Check if [Apis.appSetting] endpoint is giving response',
    () async {
      AppSettingResponse response;
      response = await ApiServices(ApiHeader().dioData()).callGetSetting();
      expect(response.success, true, reason: 'The response from ${Apis.appSetting} is not successful');
    },
  );
}
