class LoginResponse {
  LoginResponse({
    bool? success,
    LoginData? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  LoginResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
    _message = json['message'];
  }

  bool? _success;
  LoginData? _data;
  String? _message;

  LoginResponse copyWith({
    bool? success,
    LoginData? data,
    String? message,
  }) =>
      LoginResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  LoginData? get data => _data;

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

class LoginData {
  LoginData({
    String? token,
    User? user,
  }) {
    _token = token;
    _user = user;
  }

  LoginData.fromJson(dynamic json) {
    _token = json['token'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? _token;
  User? _user;

  LoginData copyWith({
    String? token,
    User? user,
  }) =>
      LoginData(
        token: token ?? _token,
        user: user ?? _user,
      );

  String? get token => _token;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

class User {
  User({
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
    num? verifyByPhone,
    num? verifyByEmail,
    dynamic otpPhone,
    dynamic otpEmail,
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
    _verifiedByPhone = verifyByPhone;
    _verifiedByEmail = verifyByEmail;
    _otpPhone = otpPhone;
    _otpEmail = otpEmail;
  }

  User.fromJson(dynamic json) {
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
    _verifiedByEmail = json['verify_by_email'] != null && json['verify_by_email'].runtimeType == String
        ? num.parse(json['verify_by_email'].toString())
        : json['verify_by_email'];
    _verifiedByPhone = json['verify_by_phone'] != null && json['verify_by_phone'].runtimeType == String
        ? num.parse(json['verify_by_phone'].toString())
        : json['verify_by_phone'];
    _otpEmail = json['otp_email'];
    _otpPhone = json['otp_phone'];
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
  num? _verifiedByPhone;
  num? _verifiedByEmail;
  dynamic _otpPhone;
  dynamic _otpEmail;

  User copyWith({
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
    num? verifiedByPhone,
    num? verifiedByEmail,
    dynamic otpPhone,
    dynamic otpEmail,
  }) =>
      User(
        id: id ?? _id,
        name: name ?? _name,
        image: image ?? _image,
        email: email ?? _email,
        otp: otp ?? _otp,
        emailVerifiedAt: emailVerifiedAt ?? _emailVerifiedAt,
        code: code ?? _code,
        phone: phone ?? _phone,
        status: status ?? _status,
        role: role ?? _role,
        verify: verify ?? _verify,
        deviceToken: deviceToken ?? _deviceToken,
        language: language ?? _language,
        provider: provider ?? _provider,
        providerToken: providerToken ?? _providerToken,
        notification: notification ?? _notification,
        mail: mail ?? _mail,
        referralCode: referralCode ?? _referralCode,
        referredBy: referredBy ?? _referredBy,
        totalPoints: totalPoints ?? _totalPoints,
        remainPoints: remainPoints ?? _remainPoints,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        imagePath: imagePath ?? _imagePath,
        businessName: businessName ?? _businessName,
        verifyByEmail: verifiedByEmail ?? _verifiedByEmail,
        verifyByPhone: verifiedByPhone ?? _verifiedByPhone,
        otpEmail: otpEmail ?? _otpEmail,
        otpPhone: otpPhone ?? _otpPhone,
      );

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

  num? get verifiedByPhone => _verifiedByPhone;

  num? get verifiedByEmail => _verifiedByEmail;

  dynamic get otpPhone => _otpPhone;
  dynamic get otpEmail => _otpEmail;

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
    map['verify_by_phone'] = _verifiedByPhone;
    map['verify_by_email'] = _verifiedByEmail;
    map['otp_phone'] = _otpPhone;
    map['otp_email'] = _otpEmail;
    return map;
  }
}
