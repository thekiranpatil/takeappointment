import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';

class BusinessProfileResponse {
  BusinessProfileResponse({
    bool? success,
    BusinessData? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  BusinessProfileResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? BusinessData.fromJson(json['data']) : null;
    _message = json['message'];
  }

  bool? _success;
  BusinessData? _data;
  String? _message;

  BusinessProfileResponse copyWith({
    bool? success,
    BusinessData? data,
    String? message,
  }) =>
      BusinessProfileResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  BusinessData? get data => _data;

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

class BusinessData {
  BusinessData({
    num? salonId,
    num? ownerId,
    String? name,
    String? image,
    String? logo,
    String? desc,
    String? gender,
    String? giveService,
    String? homeCharges,
    String? address,
    String? zipcode,
    String? city,
    String? state,
    String? country,
    String? website,
    num? phone,
    String? sun,
    String? mon,
    String? tue,
    String? wed,
    String? thu,
    String? fri,
    String? sat,
    num? status,
    String? latitude,
    String? longitude,
    String? createdAt,
    String? updatedAt,
    bool? sunCheck,
    bool? monCheck,
    bool? tueCheck,
    bool? wedCheck,
    bool? thuCheck,
    bool? friCheck,
    bool? satCheck,
    Sunday? sunday,
    Monday? monday,
    Tuesday? tuesday,
    Wednesday? wednesday,
    Thursday? thursday,
    Friday? friday,
    Saturday? saturday,
    num? rate,
    num? rateCount,
    String? imagePath,
    String? ownerName,
    OwnerDetails? ownerDetails,
    num? open,
    num? completedBooking,
    List<ServiceName>? serviceName,
    String? token,
  }) {
    _salonId = salonId;
    _ownerId = ownerId;
    _name = name;
    _image = image;
    _logo = logo;
    _desc = desc;
    _gender = gender;
    _giveService = giveService;
    _homeCharges = homeCharges;
    _address = address;
    _zipcode = zipcode;
    _city = city;
    _state = state;
    _country = country;
    _website = website;
    _phone = phone;
    _sun = sun;
    _mon = mon;
    _tue = tue;
    _wed = wed;
    _thu = thu;
    _fri = fri;
    _sat = sat;
    _status = status;
    _latitude = latitude;
    _longitude = longitude;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _sunCheck = sunCheck;
    _monCheck = monCheck;
    _tueCheck = tueCheck;
    _wedCheck = wedCheck;
    _thuCheck = thuCheck;
    _friCheck = friCheck;
    _satCheck = satCheck;
    _sunday = sunday;
    _monday = monday;
    _tuesday = tuesday;
    _wednesday = wednesday;
    _thursday = thursday;
    _friday = friday;
    _saturday = saturday;
    _rate = rate;
    _rateCount = rateCount;
    _imagePath = imagePath;
    _ownerName = ownerName;
    _ownerDetails = ownerDetails;
    _open = open;
    _completedBooking = completedBooking;
    _serviceName = serviceName;
    _token = token;
  }

  BusinessData.fromJson(dynamic json) {
    _salonId = json['business_id'];
    _ownerId = json['owner_id'].runtimeType == String ? num.parse(json['owner_id']) : json['owner_id'];
    _name = json['name'];
    _image = json['image'];
    _logo = json['logo'];
    _desc = json['desc'];
    _gender = json['gender'];
    _giveService = json['give_service'];
    _homeCharges = json['home_charges'];
    _address = json['address'];
    _zipcode = json['zipcode'];
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _website = json['website'];
    _phone = json['phone'].runtimeType == String ? num.parse(json['phone']) : json['phone'];
    _sun = json['sun'];
    _mon = json['mon'];
    _tue = json['tue'];
    _wed = json['wed'];
    _thu = json['thu'];
    _fri = json['fri'];
    _sat = json['sat'];
    _status = json['status'];
    _latitude = json['latitude'].toString();
    _longitude = json['longitude'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _sunCheck = json['sunCheck'];
    _monCheck = json['monCheck'];
    _tueCheck = json['tueCheck'];
    _wedCheck = json['wedCheck'];
    _thuCheck = json['thuCheck'];
    _friCheck = json['friCheck'];
    _satCheck = json['satCheck'];
    _token = json['token'];
    _sunday = json['sunday'] != null ? Sunday.fromJson(json['sunday']) : null;
    _monday = json['monday'] != null ? Monday.fromJson(json['monday']) : null;
    _tuesday = json['tuesday'] != null ? Tuesday.fromJson(json['tuesday']) : null;
    _wednesday = json['wednesday'] != null ? Wednesday.fromJson(json['wednesday']) : null;
    _thursday = json['thursday'] != null ? Thursday.fromJson(json['thursday']) : null;
    _friday = json['friday'] != null ? Friday.fromJson(json['friday']) : null;
    _saturday = json['saturday'] != null ? Saturday.fromJson(json['saturday']) : null;
    _rate = json['rate'].runtimeType == String ? num.parse(json['rate']) : json['rate'];
    _rateCount = json['rateCount'];
    _imagePath = json['imagePath'];
    _ownerName = json['ownerName'];
    _ownerDetails = json['ownerDetails'] != null ? OwnerDetails.fromJson(json['ownerDetails']) : null;
    _open = json['open'];
    _completedBooking = json['completedBooking'];
    if (json['serviceName'] != null) {
      _serviceName = [];
      json['serviceName'].forEach((v) {
        _serviceName?.add(ServiceName.fromJson(v));
      });
    }
  }

  num? _salonId;
  num? _ownerId;
  String? _name;
  String? _image;
  String? _logo;
  String? _desc;
  String? _gender;
  String? _giveService;
  String? _homeCharges;
  String? _address;
  String? _zipcode;
  String? _city;
  String? _state;
  String? _country;
  String? _website;
  num? _phone;
  String? _sun;
  String? _mon;
  String? _tue;
  String? _wed;
  String? _thu;
  String? _fri;
  String? _sat;
  num? _status;
  String? _latitude;
  String? _longitude;
  String? _createdAt;
  String? _updatedAt;
  bool? _sunCheck;
  bool? _monCheck;
  bool? _tueCheck;
  bool? _wedCheck;
  bool? _thuCheck;
  bool? _friCheck;
  bool? _satCheck;
  Sunday? _sunday;
  Monday? _monday;
  Tuesday? _tuesday;
  Wednesday? _wednesday;
  Thursday? _thursday;
  Friday? _friday;
  Saturday? _saturday;
  num? _rate;
  num? _rateCount;
  String? _imagePath;
  String? _ownerName;
  OwnerDetails? _ownerDetails;
  num? _open;
  num? _completedBooking;
  List<ServiceName>? _serviceName;
  String? _token;

  BusinessData copyWith({
    num? salonId,
    num? ownerId,
    String? name,
    String? image,
    String? logo,
    String? desc,
    String? gender,
    String? giveService,
    String? homeCharges,
    String? address,
    String? zipcode,
    String? city,
    String? state,
    String? country,
    String? website,
    num? phone,
    String? sun,
    String? mon,
    String? tue,
    String? wed,
    String? thu,
    String? fri,
    String? sat,
    num? status,
    String? latitude,
    String? longitude,
    String? createdAt,
    String? updatedAt,
    bool? sunCheck,
    bool? monCheck,
    bool? tueCheck,
    bool? wedCheck,
    bool? thuCheck,
    bool? friCheck,
    bool? satCheck,
    Sunday? sunday,
    Monday? monday,
    Tuesday? tuesday,
    Wednesday? wednesday,
    Thursday? thursday,
    Friday? friday,
    Saturday? saturday,
    num? rate,
    num? rateCount,
    String? imagePath,
    String? ownerName,
    OwnerDetails? ownerDetails,
    num? open,
    num? completedBooking,
    List<ServiceName>? serviceName,
    String? token,
  }) =>
      BusinessData(
        salonId: salonId ?? _salonId,
        ownerId: ownerId ?? _ownerId,
        name: name ?? _name,
        image: image ?? _image,
        logo: logo ?? _logo,
        desc: desc ?? _desc,
        gender: gender ?? _gender,
        giveService: giveService ?? _giveService,
        homeCharges: homeCharges ?? _homeCharges,
        address: address ?? _address,
        zipcode: zipcode ?? _zipcode,
        city: city ?? _city,
        state: state ?? _state,
        country: country ?? _country,
        website: website ?? _website,
        phone: phone ?? _phone,
        sun: sun ?? _sun,
        mon: mon ?? _mon,
        tue: tue ?? _tue,
        wed: wed ?? _wed,
        thu: thu ?? _thu,
        fri: fri ?? _fri,
        sat: sat ?? _sat,
        status: status ?? _status,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        sunCheck: sunCheck ?? _sunCheck,
        monCheck: monCheck ?? _monCheck,
        tueCheck: tueCheck ?? _tueCheck,
        wedCheck: wedCheck ?? _wedCheck,
        thuCheck: thuCheck ?? _thuCheck,
        friCheck: friCheck ?? _friCheck,
        satCheck: satCheck ?? _satCheck,
        sunday: sunday ?? _sunday,
        monday: monday ?? _monday,
        tuesday: tuesday ?? _tuesday,
        wednesday: wednesday ?? _wednesday,
        thursday: thursday ?? _thursday,
        friday: friday ?? _friday,
        saturday: saturday ?? _saturday,
        rate: rate ?? _rate,
        rateCount: rateCount ?? _rateCount,
        imagePath: imagePath ?? _imagePath,
        ownerName: ownerName ?? _ownerName,
        ownerDetails: ownerDetails ?? _ownerDetails,
        open: open ?? _open,
        completedBooking: completedBooking ?? _completedBooking,
        serviceName: serviceName ?? _serviceName,
        token: token ?? _token,
      );

  num? get salonId => _salonId;

  num? get ownerId => _ownerId;

  String? get name => _name;

  String? get image => _image;

  String? get logo => _logo;

  String? get desc => _desc;

  String? get gender => _gender;

  String? get giveService => _giveService;

  String? get homeCharges => _homeCharges;

  String? get address => _address;

  String? get zipcode => _zipcode;

  String? get city => _city;

  String? get state => _state;

  String? get country => _country;

  String? get website => _website;

  num? get phone => _phone;

  String? get sun => _sun;

  String? get mon => _mon;

  String? get tue => _tue;

  String? get wed => _wed;

  String? get thu => _thu;

  String? get fri => _fri;

  String? get sat => _sat;

  num? get status => _status;

  String? get latitude => _latitude;

  String? get longitude => _longitude;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  bool? get sunCheck => _sunCheck;

  bool? get monCheck => _monCheck;

  bool? get tueCheck => _tueCheck;

  bool? get wedCheck => _wedCheck;

  bool? get thuCheck => _thuCheck;

  bool? get friCheck => _friCheck;

  bool? get satCheck => _satCheck;

  Sunday? get sunday => _sunday;

  Monday? get monday => _monday;

  Tuesday? get tuesday => _tuesday;

  Wednesday? get wednesday => _wednesday;

  Thursday? get thursday => _thursday;

  Friday? get friday => _friday;

  Saturday? get saturday => _saturday;

  num? get rate => _rate;

  num? get rateCount => _rateCount;

  String? get imagePath => _imagePath;

  String? get ownerName => _ownerName;

  OwnerDetails? get ownerDetails => _ownerDetails;

  num? get open => _open;

  num? get completedBooking => _completedBooking;

  List<ServiceName>? get serviceName => _serviceName;

  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['business_id'] = _salonId;
    map['owner_id'] = _ownerId;
    map['name'] = _name;
    map['image'] = _image;
    map['logo'] = _logo;
    map['desc'] = _desc;
    map['gender'] = _gender;
    map['give_service'] = _giveService;
    map['home_charges'] = _homeCharges;
    map['address'] = _address;
    map['zipcode'] = _zipcode;
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['website'] = _website;
    map['phone'] = _phone;
    map['sun'] = _sun;
    map['mon'] = _mon;
    map['tue'] = _tue;
    map['wed'] = _wed;
    map['thu'] = _thu;
    map['fri'] = _fri;
    map['sat'] = _sat;
    map['status'] = _status;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['sunCheck'] = _sunCheck;
    map['monCheck'] = _monCheck;
    map['tueCheck'] = _tueCheck;
    map['wedCheck'] = _wedCheck;
    map['thuCheck'] = _thuCheck;
    map['friCheck'] = _friCheck;
    map['satCheck'] = _satCheck;
    map['token'] = _token;
    if (_sunday != null) {
      map['sunday'] = _sunday?.toJson();
    }
    if (_monday != null) {
      map['monday'] = _monday?.toJson();
    }
    if (_tuesday != null) {
      map['tuesday'] = _tuesday?.toJson();
    }
    if (_wednesday != null) {
      map['wednesday'] = _wednesday?.toJson();
    }
    if (_thursday != null) {
      map['thursday'] = _thursday?.toJson();
    }
    if (_friday != null) {
      map['friday'] = _friday?.toJson();
    }
    if (_saturday != null) {
      map['saturday'] = _saturday?.toJson();
    }
    map['rate'] = _rate;
    map['rateCount'] = _rateCount;
    map['imagePath'] = _imagePath;
    map['ownerName'] = _ownerName;
    if (_ownerDetails != null) {
      map['ownerDetails'] = _ownerDetails?.toJson();
    }
    map['open'] = _open;
    map['completedBooking'] = _completedBooking;
    if (_serviceName != null) {
      map['serviceName'] = _serviceName?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
