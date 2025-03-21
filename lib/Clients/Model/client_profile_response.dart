import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';

class ClientProfileResponse {
  ClientProfileResponse({
    bool? success,
    ClientProfileData? data,
  }) {
    _success = success;
    _data = data;
  }

  ClientProfileResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? ClientProfileData.fromJson(json['data']) : null;
  }

  bool? _success;
  ClientProfileData? _data;

  ClientProfileResponse copyWith({
    bool? success,
    ClientProfileData? data,
  }) =>
      ClientProfileResponse(
        success: success ?? _success,
        data: data ?? _data,
      );

  bool? get success => _success;

  ClientProfileData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class ClientProfileData {
  ClientProfileData({
    UserDetails? user,
    List<AppointmentObject>? allBooking,
    num? pending,
    num? completed,
    num? cancel,
    num? approved,
    num? totalSales,
    num? outstanding,
  }) {
    _user = user;
    _allBooking = allBooking;
    _pending = pending;
    _completed = completed;
    _cancel = cancel;
    _approved = approved;
    _totalSales = totalSales;
    _outstanding = outstanding;
  }

  ClientProfileData.fromJson(dynamic json) {
    _user = json['user'] != null ? UserDetails.fromJson(json['user']) : null;
    if (json['all_booking'] != null) {
      _allBooking = [];
      json['all_booking'].forEach((v) {
        _allBooking?.add(AppointmentObject.fromJson(v));
      });
    }
    _pending = json['pending'];
    _completed = json['completed'];
    _cancel = json['cancel'];
    _approved = json['approved'];
    _totalSales = json['total_sales'];
    _outstanding = json['outstanding'];
  }

  UserDetails? _user;
  List<AppointmentObject>? _allBooking;
  num? _pending;
  num? _completed;
  num? _cancel;
  num? _approved;
  num? _totalSales;
  num? _outstanding;

  ClientProfileData copyWith({
    UserDetails? user,
    List<AppointmentObject>? allBooking,
    num? pending,
    num? completed,
    num? cancel,
    num? approved,
    num? totalSales,
    num? outstanding,
  }) =>
      ClientProfileData(
        user: user ?? _user,
        allBooking: allBooking ?? _allBooking,
        pending: pending ?? _pending,
        completed: completed ?? _completed,
        cancel: cancel ?? _cancel,
        approved: approved ?? _approved,
        totalSales: totalSales ?? _totalSales,
        outstanding: outstanding ?? _outstanding,
      );

  UserDetails? get user => _user;

  List<AppointmentObject>? get allBooking => _allBooking;

  num? get pending => _pending;

  num? get completed => _completed;

  num? get cancel => _cancel;

  num? get approved => _approved;

  num? get totalSales => _totalSales;

  num? get outstanding => _outstanding;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_allBooking != null) {
      map['all_booking'] = _allBooking?.map((v) => v.toJson()).toList();
    }
    map['pending'] = _pending;
    map['completed'] = _completed;
    map['cancel'] = _cancel;
    map['approved'] = _approved;
    map['total_sales'] = _totalSales;
    map['outstanding'] = _outstanding;
    return map;
  }
}
