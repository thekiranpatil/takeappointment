import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';

class AddClientResponse {
  AddClientResponse({
    bool? success,
    UserDetails? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  AddClientResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? UserDetails.fromJson(json['data']) : null;
    _message = json['message'];
  }

  bool? _success;
  UserDetails? _data;
  String? _message;

  AddClientResponse copyWith({
    bool? success,
    UserDetails? data,
    String? message,
  }) =>
      AddClientResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  UserDetails? get data => _data;

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
