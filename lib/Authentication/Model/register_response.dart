class RegisterResponse {
  RegisterResponse({
    bool? success,
    RegisterData? data,
    String? message,
    String? send,
    bool? pendingPhoneVerification,
    bool? pendingEmailVerification,
  }) {
    _success = success;
    _data = data;
    _message = message;
    _send = send;
    _pendingPhoneVerification = pendingPhoneVerification;
    _pendingEmailVerification = pendingEmailVerification;
  }

  RegisterResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null && json['data'].runtimeType != int ? RegisterData.fromJson(json['data']) : null;
    _message = json['message'];
    _send = json['send'];
    _pendingPhoneVerification = json['pending_phone_verify'] != null
        ? bool.parse(json['pending_phone_verify'].toString())
        : json['pending_phone_verify'];
    _pendingEmailVerification = json['pending_email_verify'] != null
        ? bool.parse(json['pending_email_verify'].toString())
        : json['pending_email_verify'];
  }

  bool? _success;
  RegisterData? _data;
  String? _message;
  String? _send;
  bool? _pendingPhoneVerification;
  bool? _pendingEmailVerification;

  bool? get success => _success;

  RegisterData? get data => _data;

  String? get message => _message;

  String? get send => _send;

  bool? get pendingPhoneVerification => _pendingPhoneVerification;

  bool? get pendingEmailVerification => _pendingEmailVerification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['message'] = _message;
    map['send'] = _send;
    map['verify_by_phone'] = _pendingPhoneVerification;
    map['verify_by_email'] = _pendingEmailVerification;
    return map;
  }
}

class RegisterData {
  RegisterData({
    String? name,
    String? email,
    String? code,
    String? phone,
    num? role,
    String? language,
    String? provider,
    String? updatedAt,
    String? createdAt,
    num? id,
    String? imagePath,
    String? businessName,
    num? verifyByPhone,
    num? verifyByEmail,
    dynamic otpPhone,
    dynamic otpEmail,
  }) {
    _name = name;
    _email = email;
    _code = code;
    _phone = phone;
    _role = role;
    _language = language;
    _provider = provider;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
    _imagePath = imagePath;
    _businessName = businessName;
    _verifyByPhone = verifyByPhone;
    _verifyByEmail = verifyByEmail;
    _otpPhone = otpPhone;
    _otpEmail = otpEmail;
  }

  RegisterData.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _code = json['code'];
    _phone = json['phone'];
    _role = json['role'];
    _language = json['language'];
    _provider = json['provider'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
    _imagePath = json['imagePath'];
    _businessName = json['businessName'];
    _verifyByPhone = num.parse(json['verify_by_phone'].toString());
    _verifyByEmail = num.parse(json['verify_by_email'].toString());
    _otpPhone = json['otp_phone'];
    _otpEmail = json['otp_email'];
  }

  String? _name;
  String? _email;
  String? _code;
  String? _phone;
  num? _role;
  String? _language;
  String? _provider;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
  String? _imagePath;
  String? _businessName;
  num? _verifyByPhone;
  num? _verifyByEmail;
  dynamic _otpPhone;
  dynamic _otpEmail;

  String? get name => _name;

  String? get email => _email;

  String? get code => _code;

  String? get phone => _phone;

  num? get role => _role;

  String? get language => _language;

  String? get provider => _provider;

  String? get updatedAt => _updatedAt;

  String? get createdAt => _createdAt;

  num? get id => _id;

  String? get imagePath => _imagePath;

  String? get businessName => _businessName;

  num? get verifiedByPhone => _verifyByPhone;

  num? get verifiedByEmail => _verifyByEmail;

  dynamic get otpPhone => _otpPhone;

  dynamic get otpEmail => _otpEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['code'] = _code;
    map['phone'] = _phone;
    map['role'] = _role;
    map['language'] = _language;
    map['provider'] = _provider;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    map['imagePath'] = _imagePath;
    map['businessName'] = _businessName;
    map['verify_by_email'] = _verifyByEmail;
    map['verify_by_phone'] = _verifyByPhone;
    map['otp_email'] = _otpEmail;
    map['otp_phone'] = _otpPhone;
    return map;
  }
}
