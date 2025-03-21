import '../../Home/Model/all_employee_response.dart';

class HomeAllAppointmentsResponse {
  HomeAllAppointmentsResponse({
    bool? success,
    AppointmentData? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  HomeAllAppointmentsResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? AppointmentData.fromJson(json['data']) : null;
    _message = json['message'];
  }

  bool? _success;
  AppointmentData? _data;
  String? _message;

  HomeAllAppointmentsResponse copyWith({
    bool? success,
    AppointmentData? data,
    String? message,
  }) =>
      HomeAllAppointmentsResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  AppointmentData? get data => _data;

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

class AppointmentData {
  AppointmentData({
    List<AppointmentObject>? pendingAppointment,
    List<AppointmentObject>? approvedAppointment,
    List<AppointmentObject>? cancelAppointment,
    Currency? currency,
  }) {
    _pendingAppointment = pendingAppointment;
    _approvedAppointment = approvedAppointment;
    _cancelAppointment = cancelAppointment;
    _currency = currency;
  }

  AppointmentData.fromJson(dynamic json) {
    if (json['pending_appointment'] != null) {
      _pendingAppointment = [];
      json['pending_appointment'].forEach((v) {
        _pendingAppointment?.add(AppointmentObject.fromJson(v));
      });
    }
    if (json['approved_appointment'] != null) {
      _approvedAppointment = [];
      json['approved_appointment'].forEach((v) {
        _approvedAppointment?.add(AppointmentObject.fromJson(v));
      });
    }
    if (json['cancel_appointment'] != null) {
      _cancelAppointment = [];
      json['cancel_appointment'].forEach((v) {
        _cancelAppointment?.add(AppointmentObject.fromJson(v));
      });
    }
    _currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }

  List<AppointmentObject>? _pendingAppointment;
  List<AppointmentObject>? _approvedAppointment;
  List<AppointmentObject>? _cancelAppointment;
  Currency? _currency;

  AppointmentData copyWith({
    List<AppointmentObject>? pendingAppointment,
    List<AppointmentObject>? approvedAppointment,
    List<AppointmentObject>? cancelAppointment,
    Currency? currency,
  }) =>
      AppointmentData(
        pendingAppointment: pendingAppointment ?? _pendingAppointment,
        approvedAppointment: approvedAppointment ?? _approvedAppointment,
        cancelAppointment: cancelAppointment ?? _cancelAppointment,
        currency: currency ?? _currency,
      );

  List<AppointmentObject>? get pendingAppointment => _pendingAppointment;

  List<AppointmentObject>? get approvedAppointment => _approvedAppointment;

  List<AppointmentObject>? get cancelAppointment => _cancelAppointment;

  Currency? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_pendingAppointment != null) {
      map['pending_appointment'] = _pendingAppointment?.map((v) => v.toJson()).toList();
    }
    if (_approvedAppointment != null) {
      map['approved_appointment'] = _approvedAppointment?.map((v) => v.toJson()).toList();
    }
    if (_cancelAppointment != null) {
      map['cancel_appointment'] = _cancelAppointment?.map((v) => v.toJson()).toList();
    }
    if (_currency != null) {
      map['currency'] = _currency?.toJson();
    }
    return map;
  }
}

class Currency {
  Currency({
    String? currency,
    String? currencySymbol,
    String? imagePath,
  }) {
    _currency = currency;
    _currencySymbol = currencySymbol;
    _imagePath = imagePath;
  }

  Currency.fromJson(dynamic json) {
    _currency = json['currency'];
    _currencySymbol = json['currency_symbol'];
    _imagePath = json['imagePath'];
  }

  String? _currency;
  String? _currencySymbol;
  String? _imagePath;

  Currency copyWith({
    String? currency,
    String? currencySymbol,
    String? imagePath,
  }) =>
      Currency(
        currency: currency ?? _currency,
        currencySymbol: currencySymbol ?? _currencySymbol,
        imagePath: imagePath ?? _imagePath,
      );

  String? get currency => _currency;

  String? get currencySymbol => _currencySymbol;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currency'] = _currency;
    map['currency_symbol'] = _currencySymbol;
    map['imagePath'] = _imagePath;
    return map;
  }
}

class AppointmentObject {
  AppointmentObject({
    num? id,
    String? bookingId,
    num? businessId,
    num? userId,
    num? empId,
    String? serviceId,
    dynamic couponId,
    String? addressId,
    num? discount,
    num? payment,
    String? date,
    String? startTime,
    String? endTime,
    String? paymentType,
    dynamic paymentToken,
    num? paymentStatus,
    String? bookingStatus,
    num? commission,
    num? businessIncome,
    String? bookingAt,
    String? extraCharges,
    String? points,
    String? createdAt,
    String? updatedAt,
    List<ServiceName>? services,
    UserDetails? userDetails,
    EmployeeData? empDetails,
    AddressDetails? addressDetails,
    String? currencySymbol,
    num? status,
    num? commissionEmployee,
  }) {
    _id = id;
    _bookingId = bookingId;
    _businessId = businessId;
    _userId = userId;
    _empId = empId;
    _serviceId = serviceId;
    _couponId = couponId;
    _addressId = addressId;
    _discount = discount;
    _payment = payment;
    _date = date;
    _startTime = startTime;
    _endTime = endTime;
    _paymentType = paymentType;
    _paymentToken = paymentToken;
    _paymentStatus = paymentStatus;
    _bookingStatus = bookingStatus;
    _commission = commission;
    _businessIncome = businessIncome;
    _bookingAt = bookingAt;
    _extraCharges = extraCharges;
    _points = points;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _services = services;
    _userDetails = userDetails;
    _empDetails = empDetails;
    _addressDetails = addressDetails;
    _currencySymbol = currencySymbol;
    _status = status;
    _commissionEmployee = commissionEmployee;
  }

  AppointmentObject.fromJson(dynamic json) {
    _id = json['id'];
    _bookingId = json['booking_id'];
    _businessId = json['business_id'];
    _userId = json['user_id'].runtimeType == String ? num.parse(json['user_id']) : json['user_id'];
    _empId = json['emp_id'].runtimeType == String ? num.parse(json['emp_id']) : json['emp_id'];
    _serviceId = json['service_id'];
    _couponId = json['coupon_id'];
    _addressId = json['address_id'].toString();
    _discount = json['discount'];
    _payment = json['payment'].runtimeType == String ? num.parse(json['payment']) : json['payment'];
    _date = json['date'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _paymentType = json['payment_type'];
    _paymentToken = json['payment_token'];
    _paymentStatus = json['payment_status'];
    _bookingStatus = json['booking_status'];
    _commission = json['commission'];
    _businessIncome = json['business_income'];
    _bookingAt = json['booking_at'];
    _extraCharges = json['extra_charges'].toString();
    _points = json['points'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(ServiceName.fromJson(v));
      });
    }
    _userDetails = json['userDetails'] != null ? UserDetails.fromJson(json['userDetails']) : null;
    _empDetails = json['empDetails'] != null ? EmployeeData.fromJson(json['empDetails']) : null;
    _addressDetails = json['addressDetails'] != null ? AddressDetails.fromJson(json['addressDetails']) : null;
    _currencySymbol = json['currencySymbol'];
    _status = json['status'];
    _commissionEmployee = num.tryParse((json['commission_employee'] ?? 0).toString());
  }

  num? _id;
  String? _bookingId;
  num? _businessId;
  num? _userId;
  num? _empId;
  String? _serviceId;
  dynamic _couponId;
  String? _addressId;
  num? _discount;
  num? _payment;
  String? _date;
  String? _startTime;
  String? _endTime;
  String? _paymentType;
  dynamic _paymentToken;
  num? _paymentStatus;
  String? _bookingStatus;
  num? _commission;
  num? _businessIncome;
  String? _bookingAt;
  String? _extraCharges;
  String? _points;
  String? _createdAt;
  String? _updatedAt;
  List<ServiceName>? _services;
  UserDetails? _userDetails;
  EmployeeData? _empDetails;
  AddressDetails? _addressDetails;
  String? _currencySymbol;
  num? _status;
  num? _commissionEmployee;

  AppointmentObject copyWith({
    num? id,
    String? bookingId,
    num? businessId,
    num? userId,
    num? empId,
    String? serviceId,
    dynamic couponId,
    String? addressId,
    num? discount,
    num? payment,
    String? date,
    String? startTime,
    String? endTime,
    String? paymentType,
    dynamic paymentToken,
    num? paymentStatus,
    String? bookingStatus,
    num? commission,
    num? businessIncome,
    String? bookingAt,
    String? extraCharges,
    String? points,
    String? createdAt,
    String? updatedAt,
    List<ServiceName>? services,
    UserDetails? userDetails,
    EmployeeData? empDetails,
    AddressDetails? addressDetails,
    String? currencySymbol,
    num? status,
    num? commissionEmployee,
  }) =>
      AppointmentObject(
        id: id ?? _id,
        bookingId: bookingId ?? _bookingId,
        businessId: businessId ?? _businessId,
        userId: userId ?? _userId,
        empId: empId ?? _empId,
        serviceId: serviceId ?? _serviceId,
        couponId: couponId ?? _couponId,
        addressId: addressId ?? _addressId,
        discount: discount ?? _discount,
        payment: payment ?? _payment,
        date: date ?? _date,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        paymentType: paymentType ?? _paymentType,
        paymentToken: paymentToken ?? _paymentToken,
        paymentStatus: paymentStatus ?? _paymentStatus,
        bookingStatus: bookingStatus ?? _bookingStatus,
        commission: commission ?? _commission,
        businessIncome: businessIncome ?? _businessIncome,
        bookingAt: bookingAt ?? _bookingAt,
        extraCharges: extraCharges ?? _extraCharges,
        points: points ?? _points,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        services: services ?? _services,
        userDetails: userDetails ?? _userDetails,
        empDetails: empDetails ?? _empDetails,
        addressDetails: addressDetails ?? _addressDetails,
        currencySymbol: currencySymbol ?? _currencySymbol,
        status: status ?? _status,
        commissionEmployee: commissionEmployee ?? _commissionEmployee,
);

  num? get id => _id;

  String? get bookingId => _bookingId;

  num? get businessId => _businessId;

  num? get userId => _userId;

  num? get empId => _empId;

  String? get serviceId => _serviceId;

  dynamic get couponId => _couponId;

  String? get addressId => _addressId;

  num? get discount => _discount;

  num? get payment => _payment;

  String? get date => _date;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  String? get paymentType => _paymentType;

  dynamic get paymentToken => _paymentToken;

  num? get paymentStatus => _paymentStatus;

  String? get bookingStatus => _bookingStatus;

  num? get commission => _commission;

  num? get businessIncome => _businessIncome;

  String? get bookingAt => _bookingAt;

  String? get extraCharges => _extraCharges;

  String? get points => _points;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  List<ServiceName>? get services => _services;

  UserDetails? get userDetails => _userDetails;

  EmployeeData? get empDetails => _empDetails;

  AddressDetails? get addressDetails => _addressDetails;

  String? get currencySymbol => _currencySymbol;

  num? get status => _status;

  num? get commissionEmployee => _commissionEmployee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['booking_id'] = _bookingId;
    map['business_id'] = _businessId;
    map['user_id'] = _userId;
    map['emp_id'] = _empId;
    map['service_id'] = _serviceId;
    map['coupon_id'] = _couponId;
    map['address_id'] = _addressId;
    map['discount'] = _discount;
    map['payment'] = _payment;
    map['date'] = _date;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['payment_type'] = _paymentType;
    map['payment_token'] = _paymentToken;
    map['payment_status'] = _paymentStatus;
    map['booking_status'] = _bookingStatus;
    map['commission'] = _commission;
    map['business_income'] = _businessIncome;
    map['booking_at'] = _bookingAt;
    map['extra_charges'] = _extraCharges;
    map['points'] = _points;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    if (_userDetails != null) {
      map['userDetails'] = _userDetails?.toJson();
    }
    if (_empDetails != null) {
      map['empDetails'] = _empDetails?.toJson();
    }
    if (_addressDetails != null) {
      map['addressDetails'] = _addressDetails?.toJson();
    }
    map['currencySymbol'] = _currencySymbol;
    map['status'] = _status;
    map['commission_employee'] = _commissionEmployee;
    return map;
  }
}

class AddressDetails {
  AddressDetails({
    num? addressId,
    num? userId,
    dynamic label,
    String? street,
    String? city,
    String? state,
    String? country,
    String? let,
    String? long,
    String? createdAt,
    String? updatedAt,
  }) {
    _addressId = addressId;
    _userId = userId;
    _label = label;
    _street = street;
    _city = city;
    _state = state;
    _country = country;
    _let = let;
    _long = long;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  AddressDetails.fromJson(dynamic json) {
    _addressId = json['address_id'];
    _userId = json['user_id'];
    _label = json['label'];
    _street = json['street'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _let = json['let'];
    _long = json['long'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  num? _addressId;
  num? _userId;
  dynamic _label;
  String? _street;
  String? _city;
  String? _state;
  String? _country;
  String? _let;
  String? _long;
  String? _createdAt;
  String? _updatedAt;

  AddressDetails copyWith({
    num? addressId,
    num? userId,
    dynamic label,
    String? street,
    String? city,
    String? state,
    String? country,
    String? let,
    String? long,
    String? createdAt,
    String? updatedAt,
  }) =>
      AddressDetails(
        addressId: addressId ?? _addressId,
        userId: userId ?? _userId,
        label: label ?? _label,
        street: street ?? _street,
        city: city ?? _city,
        state: state ?? _state,
        country: country ?? _country,
        let: let ?? _let,
        long: long ?? _long,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );

  num? get addressId => _addressId;

  num? get userId => _userId;

  dynamic get label => _label;

  String? get street => _street;

  String? get city => _city;

  String? get state => _state;

  String? get country => _country;

  String? get let => _let;

  String? get long => _long;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = _addressId;
    map['user_id'] = _userId;
    map['label'] = _label;
    map['street'] = _street;
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['let'] = _let;
    map['long'] = _long;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class OwnerDetails {
  OwnerDetails({
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

  OwnerDetails.fromJson(dynamic json) {
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

  OwnerDetails copyWith({
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
  }) =>
      OwnerDetails(
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

class UserDetails {
  UserDetails({
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
    dynamic deviceToken,
    String? language,
    String? provider,
    dynamic providerToken,
    num? notification,
    num? mail,
    String? referralCode,
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

  UserDetails.fromJson(dynamic json) {
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
    _notification = json['notification'].runtimeType == String ? num.parse(json['notification']) : json['notification'];
    _mail = json['mail'].runtimeType == String ? num.parse(json['mail']) : json['mail'];
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
  dynamic _deviceToken;
  String? _language;
  String? _provider;
  dynamic _providerToken;
  num? _notification;
  num? _mail;
  String? _referralCode;
  dynamic _referredBy;
  String? _totalPoints;
  String? _remainPoints;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;
  String? _businessName;

  UserDetails copyWith({
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
    dynamic deviceToken,
    String? language,
    String? provider,
    dynamic providerToken,
    num? notification,
    num? mail,
    String? referralCode,
    dynamic referredBy,
    String? totalPoints,
    String? remainPoints,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
    String? businessName,
  }) =>
      UserDetails(
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

  dynamic get deviceToken => _deviceToken;

  String? get language => _language;

  String? get provider => _provider;

  dynamic get providerToken => _providerToken;

  num? get notification => _notification;

  num? get mail => _mail;

  String? get referralCode => _referralCode;

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
