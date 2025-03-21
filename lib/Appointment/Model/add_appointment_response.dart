import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';

class AddAppointmentResponse {
  AddAppointmentResponse({
    String? msg,
    AppointmentObject? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  AddAppointmentResponse.fromJson(dynamic json) {
    _msg = json['message'];
    _data = json['data'] != null ? AppointmentObject.fromJson(json['data']) : null;
    _success = json['success'];
  }

  String? _msg;
  AppointmentObject? _data;
  bool? _success;

  String? get msg => _msg;

  AppointmentObject? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _msg;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    return map;
  }
}
