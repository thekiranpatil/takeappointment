import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';

class ReviewsResponse {
  ReviewsResponse({
    bool? success,
    List<ReviewData>? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  ReviewsResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ReviewData.fromJson(v));
      });
    }
    _message = json['message'];
  }

  bool? _success;
  List<ReviewData>? _data;
  String? _message;

  ReviewsResponse copyWith({
    bool? success,
    List<ReviewData>? data,
    String? message,
  }) =>
      ReviewsResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  List<ReviewData>? get data => _data;

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

class ReviewData {
  ReviewData({
    num? reviewId,
    num? userId,
    num? salonId,
    num? bookingId,
    num? rate,
    String? message,
    num? report,
    String? createdAt,
    String? updatedAt,
    String? display,
    UserDetails? user,
  }) {
    _reviewId = reviewId;
    _userId = userId;
    _salonId = salonId;
    _bookingId = bookingId;
    _rate = rate;
    _message = message;
    _report = report;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _display = display;
    _user = user;
  }

  ReviewData.fromJson(dynamic json) {
    _reviewId = json['review_id'];
    _userId = json['user_id'];
    _salonId = json['business_id'];
    _bookingId = json['booking_id'];
    _rate = json['rate'];
    _message = json['message'];
    _report = json['report'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _display = json['display'];
    _user = json['user'] != null ? UserDetails.fromJson(json['user']) : null;
  }

  num? _reviewId;
  num? _userId;
  num? _salonId;
  num? _bookingId;
  num? _rate;
  String? _message;
  num? _report;
  String? _createdAt;
  String? _updatedAt;
  String? _display;
  UserDetails? _user;

  ReviewData copyWith({
    num? reviewId,
    num? userId,
    num? salonId,
    num? bookingId,
    num? rate,
    String? message,
    num? report,
    String? createdAt,
    String? updatedAt,
    String? display,
    UserDetails? user,
  }) =>
      ReviewData(
        reviewId: reviewId ?? _reviewId,
        userId: userId ?? _userId,
        salonId: salonId ?? _salonId,
        bookingId: bookingId ?? _bookingId,
        rate: rate ?? _rate,
        message: message ?? _message,
        report: report ?? _report,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        display: display ?? _display,
        user: user ?? _user,
      );

  num? get reviewId => _reviewId;

  num? get userId => _userId;

  num? get salonId => _salonId;

  num? get bookingId => _bookingId;

  num? get rate => _rate;

  String? get message => _message;

  num? get report => _report;

  set report(num? value) {
    _report = value;
  }

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get display => _display;

  UserDetails? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['review_id'] = _reviewId;
    map['user_id'] = _userId;
    map['business_id'] = _salonId;
    map['booking_id'] = _bookingId;
    map['rate'] = _rate;
    map['message'] = _message;
    map['report'] = _report;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['display'] = _display;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}
