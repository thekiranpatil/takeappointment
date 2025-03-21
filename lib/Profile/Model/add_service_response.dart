import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';

class AddServiceResponse {
  AddServiceResponse({
    bool? success,
    ServiceName? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  AddServiceResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? ServiceName.fromJson(json['data']) : null;
    _message = json['message'];
  }

  bool? _success;
  ServiceName? _data;
  String? _message;

  AddServiceResponse copyWith({
    bool? success,
    ServiceName? data,
    String? message,
  }) =>
      AddServiceResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  ServiceName? get data => _data;

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
