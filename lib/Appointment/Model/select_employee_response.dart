import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';

class SelectEmployeeResponse {
  SelectEmployeeResponse({
    String? msg,
    List<EmployeeData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  SelectEmployeeResponse.fromJson(dynamic json) {
    _msg = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(EmployeeData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  String? _msg;
  List<EmployeeData>? _data;
  bool? _success;

  String? get msg => _msg;

  List<EmployeeData>? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }
}
