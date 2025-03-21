class ForgotPasswordResponse {
  ForgotPasswordResponse({
    String? msg,
    ForgotPasswordData? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  ForgotPasswordResponse.fromJson(dynamic json) {
    _msg = json['message'];
    _data = json['data'] != null ? ForgotPasswordData.fromJson(json['data']) : null;
    _success = json['success'];
  }

  String? _msg;
  ForgotPasswordData? _data;
  bool? _success;

  String? get msg => _msg;

  ForgotPasswordData? get data => _data;

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

class ForgotPasswordData {
  ForgotPasswordData({
    num? id,
    String? name,
    String? image,
    String? email,
    dynamic otp,
    dynamic emailVerifiedAt,
    String? code,
    String? phone,
    num? status,
    num? role,
    num? verify,
    String? deviceToken,
    String? language,
    String? provider,
    dynamic providerToken,
    num? notification,
    num? mail,
    dynamic referralCode,
    dynamic referredBy,
    String? totalPoints,
    String? remainPoints,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
    String? businessName,
  }) {
    _id = id;
    _name = name;
    _image = image;
    _email = email;
    _otp = otp;
    _emailVerifiedAt = emailVerifiedAt;
    _code = code;
    _phone = phone;
    _status = status;
    _role = role;
    _verify = verify;
    _deviceToken = deviceToken;
    _language = language;
    _provider = provider;
    _providerToken = providerToken;
    _notification = notification;
    _mail = mail;
    _referralCode = referralCode;
    _referredBy = referredBy;
    _totalPoints = totalPoints;
    _remainPoints = remainPoints;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imagePath = imagePath;
    _businessName = businessName;
  }

  ForgotPasswordData.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _email = json['email'];
    _otp = json['otp'];
    _emailVerifiedAt = json['email_verified_at'];
    _code = json['code'];
    _phone = json['phone'];
    _status = json['status'];
    _role = json['role'];
    _verify = json['verify'];
    _deviceToken = json['device_token'];
    _language = json['language'];
    _provider = json['provider'];
    _providerToken = json['provider_token'];
    _notification = json['notification'];
    _mail = json['mail'];
    _referralCode = json['referral_code'];
    _referredBy = json['referred_by'];
    _totalPoints = json['total_points'];
    _remainPoints = json['remain_points'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['imagePath'];
    _businessName = json['businessName'];
  }

  num? _id;
  String? _name;
  String? _image;
  String? _email;
  dynamic _otp;
  dynamic _emailVerifiedAt;
  String? _code;
  String? _phone;
  num? _status;
  num? _role;
  num? _verify;
  String? _deviceToken;
  String? _language;
  String? _provider;
  dynamic _providerToken;
  num? _notification;
  num? _mail;
  dynamic _referralCode;
  dynamic _referredBy;
  String? _totalPoints;
  String? _remainPoints;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;
  String? _businessName;

  num? get id => _id;

  String? get name => _name;

  String? get image => _image;

  String? get email => _email;

  dynamic get otp => _otp;

  dynamic get emailVerifiedAt => _emailVerifiedAt;

  String? get code => _code;

  String? get phone => _phone;

  num? get status => _status;

  num? get role => _role;

  num? get verify => _verify;

  String? get deviceToken => _deviceToken;

  String? get language => _language;

  String? get provider => _provider;

  dynamic get providerToken => _providerToken;

  num? get notification => _notification;

  num? get mail => _mail;

  dynamic get referralCode => _referralCode;

  dynamic get referredBy => _referredBy;

  String? get totalPoints => _totalPoints;

  String? get remainPoints => _remainPoints;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get imagePath => _imagePath;

  String? get businessName => _businessName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['email'] = _email;
    map['otp'] = _otp;
    map['email_verified_at'] = _emailVerifiedAt;
    map['code'] = _code;
    map['phone'] = _phone;
    map['status'] = _status;
    map['role'] = _role;
    map['verify'] = _verify;
    map['device_token'] = _deviceToken;
    map['language'] = _language;
    map['provider'] = _provider;
    map['provider_token'] = _providerToken;
    map['notification'] = _notification;
    map['mail'] = _mail;
    map['referral_code'] = _referralCode;
    map['referred_by'] = _referredBy;
    map['total_points'] = _totalPoints;
    map['remain_points'] = _remainPoints;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['imagePath'] = _imagePath;
    map['businessName'] = _businessName;
    return map;
  }
}
