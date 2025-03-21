import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/review_report_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/reviews_response.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class ReviewProvider extends ChangeNotifier {
  bool reviewLoader = false;
  List<ReviewData> reviews = [];

  Future<BaseModel<ReviewsResponse>> callGetReview() async {
    ReviewsResponse response;
    try {
      reviewLoader = true;
      reviews.clear();
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetReview();
      if (response.success == true) {
        reviews = response.data!;
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      reviewLoader = false;
      notifyListeners();
    } catch (error) {
      reviewLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<ReviewReportResponse>> callReviewReport(Map<String, dynamic> body, int index) async {
    ReviewReportResponse response;
    try {
      reviewLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callReviewReport(body);
      if (response.success == true) {
        reviews[index].report = response.data!.report!;
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      reviewLoader = false;
      notifyListeners();
    } catch (error) {
      reviewLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
