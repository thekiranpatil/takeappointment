class GalleryResponse {
  GalleryResponse({
    bool? success,
    List<GalleryData>? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  GalleryResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GalleryData.fromJson(v));
      });
    }
    _message = json['message'];
  }

  bool? _success;
  List<GalleryData>? _data;
  String? _message;

  GalleryResponse copyWith({
    bool? success,
    List<GalleryData>? data,
    String? message,
  }) =>
      GalleryResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  List<GalleryData>? get data => _data;

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

class GalleryData {
  GalleryData({
    num? galleryId,
    num? salonId,
    String? image,
    num? status,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
  }) {
    _galleryId = galleryId;
    _salonId = salonId;
    _image = image;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imagePath = imagePath;
  }

  GalleryData.fromJson(dynamic json) {
    _galleryId = json['gallery_id'];
    _salonId = json['business_id'];
    _image = json['image'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['imagePath'];
  }

  num? _galleryId;
  num? _salonId;
  String? _image;
  num? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;

  GalleryData copyWith({
    num? galleryId,
    num? salonId,
    String? image,
    num? status,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
  }) =>
      GalleryData(
        galleryId: galleryId ?? _galleryId,
        salonId: salonId ?? _salonId,
        image: image ?? _image,
        status: status ?? _status,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        imagePath: imagePath ?? _imagePath,
      );

  num? get galleryId => _galleryId;

  num? get salonId => _salonId;

  String? get image => _image;

  num? get status => _status;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['gallery_id'] = _galleryId;
    map['business_id'] = _salonId;
    map['image'] = _image;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['imagePath'] = _imagePath;
    return map;
  }
}
