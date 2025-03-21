import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';

class ClientsResponse {
  ClientsResponse({
    bool? success,
    List<UserDetails>? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  ClientsResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UserDetails.fromJson(v));
      });
    }
    _message = json['message'];
  }

  bool? _success;
  List<UserDetails>? _data;
  String? _message;

  ClientsResponse copyWith({
    bool? success,
    List<UserDetails>? data,
    String? message,
  }) =>
      ClientsResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  List<UserDetails>? get data => _data;

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
