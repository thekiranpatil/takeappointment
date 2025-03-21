import 'package:flutter_test/flutter_test.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/app_setting_response.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';

void main() {
  
  test(
    'Check if [Apis.appSetting] has Google Map Key Added',
    () async {
      AppSettingResponse response;
      response = await ApiServices(ApiHeader().dioData()).callGetSetting();
      bool success = (response.data!.mapkey as String).isNotEmpty;
      expect(success, true, reason: 'Google Map key is not entered in the admin panel yet');
    },
  );
}
