import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';

class AllServicesResponse {
  AllServicesResponse({
    bool? success,
    List<ServiceName>? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  AllServicesResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ServiceName.fromJson(v));
      });
    }
    _message = json['message'];
  }

  bool? _success;
  List<ServiceName>? _data;
  String? _message;

  AllServicesResponse copyWith({
    bool? success,
    List<ServiceName>? data,
    String? message,
  }) =>
      AllServicesResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  List<ServiceName>? get data => _data;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }
}
