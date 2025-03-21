import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';

class CalendarAppointmentsResponse {
  CalendarAppointmentsResponse({
    bool? success,
    List<AppointmentObject>? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  CalendarAppointmentsResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AppointmentObject.fromJson(v));
      });
    }
    _message = json['message'];
  }

  bool? _success;
  List<AppointmentObject>? _data;
  String? _message;

  CalendarAppointmentsResponse copyWith({
    bool? success,
    List<AppointmentObject>? data,
    String? message,
  }) =>
      CalendarAppointmentsResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  List<AppointmentObject>? get data => _data;

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
