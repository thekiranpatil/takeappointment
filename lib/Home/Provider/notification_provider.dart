import 'package:multibusiness_business_app_flutter/Home/Model/notification_response.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:flutter/material.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class NotificationProvider extends ChangeNotifier {
  bool notificationLoader = false;
  List<NotificationData> notifications = [];

  Future<BaseModel<NotificationResponse>> callGetNotification() async {
    NotificationResponse response;
    try {
      notificationLoader = true;
      notifications.clear();
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetNotification();
      if (response.success == true) {
        notifications.addAll(response.data!.reversed);
        notifyListeners();
      }
      else if(response.success==false){
        if(response.msg!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.msg!).toString());
      }
      notificationLoader = false;
      notifyListeners();
    } catch (error) {
      notificationLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
