import 'package:flutter_test/flutter_test.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/app_setting_response.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Utils/const_string.dart';

void main() {
  test(
    'Check if OneSignal App ID is not entered in the admin panel & in code locally',
    () async {
      AppSettingResponse response;
      response = await ApiServices(ApiHeader().dioData()).callGetSetting();
      bool isAppIDComingFromBackend = (response.data!.appId as String).isNotEmpty;
      bool isAppIDaddedLocallyInConst =
          ConstString.oneSignalAppID.isNotEmpty && ConstString.oneSignalAppID != "__Enter_Your_OneSignal_App_ID_Here__";

      bool success = isAppIDComingFromBackend && isAppIDaddedLocallyInConst;
      expect(success, true, reason: 'OneSignal App ID is not entered in the admin panel yet');
    },
  );
}
