import 'package:multibusiness_business_app_flutter/Profile/Model/services_response.dart';

class CategoriesResponse {
  CategoriesResponse({
    bool? success,
    List<CategoryData>? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  CategoriesResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CategoryData.fromJson(v));
      });
    }
    _message = json['message'];
  }

  bool? _success;
  List<CategoryData>? _data;
  String? _message;

  CategoriesResponse copyWith({
    bool? success,
    List<CategoryData>? data,
    String? message,
  }) =>
      CategoriesResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  List<CategoryData>? get data => _data;

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
