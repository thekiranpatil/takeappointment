import 'package:multibusiness_business_app_flutter/Profile/Model/reviews_response.dart';

class ReviewReportResponse {
  ReviewReportResponse({
    bool? success,
    ReviewData? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  ReviewReportResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? ReviewData.fromJson(json['data']) : null;
    _message = json['message'];
  }

  bool? _success;
  ReviewData? _data;
  String? _message;

  ReviewReportResponse copyWith({
    bool? success,
    ReviewData? data,
    String? message,
  }) =>
      ReviewReportResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  ReviewData? get data => _data;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    return map;
  }
}
