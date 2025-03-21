class NotificationResponse {
  NotificationResponse({
    String? msg,
    List<NotificationData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  NotificationResponse.fromJson(dynamic json) {
    _msg = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  String? _msg;
  List<NotificationData>? _data;
  bool? _success;

  NotificationResponse copyWith({
    String? msg,
    List<NotificationData>? data,
    bool? success,
  }) =>
      NotificationResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

  List<NotificationData>? get data => _data;

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

class NotificationData {
  NotificationData({
    num? id,
    num? userId,
    num? bookingId,
    num? salonId,
    dynamic empId,
    String? title,
    String? msg,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
    String? salonImage,
  }) {
    _id = id;
    _userId = userId;
    _bookingId = bookingId;
    _salonId = salonId;
    _empId = empId;
    _title = title;
    _msg = msg;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imagePath = imagePath;
    _salonImage = salonImage;
  }

  NotificationData.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _bookingId = json['booking_id'];
    _salonId = json['business_id'];
    _empId = json['emp_id'];
    _title = json['title'];
    _msg = json['msg'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['imagePath'];
    _salonImage = json['salonImage'];
  }

  num? _id;
  num? _userId;
  num? _bookingId;
  num? _salonId;
  dynamic _empId;
  String? _title;
  String? _msg;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;
  String? _salonImage;

  NotificationData copyWith({
    num? id,
    num? userId,
    num? bookingId,
    num? salonId,
    dynamic empId,
    String? title,
    String? msg,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
    String? salonImage,
  }) =>
      NotificationData(
        id: id ?? _id,
        userId: userId ?? _userId,
        bookingId: bookingId ?? _bookingId,
        salonId: salonId ?? _salonId,
        empId: empId ?? _empId,
        title: title ?? _title,
        msg: msg ?? _msg,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        imagePath: imagePath ?? _imagePath,
        salonImage: salonImage ?? _salonImage,
      );

  num? get id => _id;

  num? get userId => _userId;

  num? get bookingId => _bookingId;

  num? get salonId => _salonId;

  dynamic get empId => _empId;

  String? get title => _title;

  String? get msg => _msg;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get imagePath => _imagePath;

  String? get salonImage => _salonImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['booking_id'] = _bookingId;
    map['business_id'] = _salonId;
    map['emp_id'] = _empId;
    map['title'] = _title;
    map['msg'] = _msg;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['imagePath'] = _imagePath;
    map['salonImage'] = _salonImage;
    return map;
  }
}
