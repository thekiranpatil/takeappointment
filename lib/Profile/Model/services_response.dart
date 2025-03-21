import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';

class ServicesResponse {
  ServicesResponse({
    bool? success,
    Data? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  ServicesResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _message = json['message'];
  }

  bool? _success;
  Data? _data;
  String? _message;

  ServicesResponse copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      ServicesResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  Data? get data => _data;

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

class Data {
  Data({
    List<CategoryData>? category,
  }) {
    _category = category;
  }

  Data.fromJson(dynamic json) {
    if (json['category'] != null) {
      _category = [];
      json['category'].forEach((v) {
        _category?.add(CategoryData.fromJson(v));
      });
    }
  }

  List<CategoryData>? _category;

  Data copyWith({
    List<CategoryData>? category,
  }) =>
      Data(
        category: category ?? _category,
      );

  List<CategoryData>? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_category != null) {
      map['category'] = _category?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CategoryData {
  CategoryData({
    num? catId,
    String? name,
    String? image,
    String? banner,
    num? status,
    String? createdAt,
    String? updatedAt,
    List<ServiceName>? service,
    String? imagePath,
  }) {
    _catId = catId;
    _name = name;
    _image = image;
    _banner = banner;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _service = service;
    _imagePath = imagePath;
  }

  CategoryData.fromJson(dynamic json) {
    _catId = json['cat_id'];
    _name = json['name'];
    _image = json['image'];
    _banner = json['banner'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['service'] != null) {
      _service = [];
      json['service'].forEach((v) {
        _service?.add(ServiceName.fromJson(v));
      });
    }
    _imagePath = json['imagePath'];
  }

  num? _catId;
  String? _name;
  String? _image;
  String? _banner;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  List<ServiceName>? _service;
  String? _imagePath;

  CategoryData copyWith({
    num? catId,
    String? name,
    String? image,
    String? banner,
    num? status,
    String? createdAt,
    String? updatedAt,
    List<ServiceName>? service,
    String? imagePath,
  }) =>
      CategoryData(
        catId: catId ?? _catId,
        name: name ?? _name,
        image: image ?? _image,
        banner: banner ?? _banner,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        service: service ?? _service,
        imagePath: imagePath ?? _imagePath,
      );

  num? get catId => _catId;

  String? get name => _name;

  String? get image => _image;

  String? get banner => _banner;

  num? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<ServiceName>? get service => _service;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cat_id'] = _catId;
    map['name'] = _name;
    map['image'] = _image;
    map['banner'] = _banner;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_service != null) {
      map['service'] = _service?.map((v) => v.toJson()).toList();
    }
    map['imagePath'] = _imagePath;
    return map;
  }
}
