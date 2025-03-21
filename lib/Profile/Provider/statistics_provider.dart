import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/statistics_response.dart';
import 'package:flutter/material.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class StatisticsProvider extends ChangeNotifier {
  bool statisticsLoader = false;

  StatisticsData? data;

  Future<BaseModel<StatisticsResponse>> callGetStatistics() async {
    StatisticsResponse response;
    try {
      statisticsLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callStatistic();
      if (response.success == true) {
        data = response.data;
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      statisticsLoader = false;
      notifyListeners();
    } catch (error) {
      statisticsLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
