import 'package:multibusiness_business_app_flutter/Profile/Model/gallery_response.dart';

class AddGalleryResponse {
  AddGalleryResponse({
    bool? success,
    GalleryData? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  AddGalleryResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? GalleryData.fromJson(json['data']) : null;
    _message = json['message'];
  }

  bool? _success;
  GalleryData? _data;
  String? _message;

  AddGalleryResponse copyWith({
    bool? success,
    GalleryData? data,
    String? message,
  }) =>
      AddGalleryResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  GalleryData? get data => _data;

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
