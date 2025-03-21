import 'package:multibusiness_business_app_flutter/Profile/Model/services_response.dart';

class AllEmployeeResponse {
  AllEmployeeResponse({
    bool? success,
    num? canAdd,
    List<EmployeeData>? data,
    String? message,
  }) {
    _success = success;
    _canAdd = canAdd;
    _data = data;
    _message = message;
  }

  AllEmployeeResponse.fromJson(dynamic json) {
    _success = json['success'];
    _canAdd = json['canAdd'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(EmployeeData.fromJson(v));
      });
    }
    _message = json['message'];
  }

  bool? _success;
  num? _canAdd;
  List<EmployeeData>? _data;
  String? _message;

  AllEmployeeResponse copyWith({
    bool? success,
    num? canAdd,
    List<EmployeeData>? data,
    String? message,
  }) =>
      AllEmployeeResponse(
        success: success ?? _success,
        canAdd: canAdd ?? _canAdd,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  num? get canAdd => _canAdd;

  List<EmployeeData>? get data => _data;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['canAdd'] = _canAdd;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['message'] = _message;
    return map;
  }
}

class EmployeeData {
  EmployeeData({
    num? empId,
    num? salonId,
    String? name,
    String? image,
    String? email,
    String? password,
    num? phone,
    String? giveService,
    String? serviceId,
    String? sun,
    String? mon,
    String? tue,
    String? wed,
    String? thu,
    String? fri,
    String? sat,
    num? status,
    dynamic deviceToken,
    num? isdelete,
    String? createdAt,
    String? updatedAt,
    Sunday? sunday,
    Monday? monday,
    Tuesday? tuesday,
    Wednesday? wednesday,
    Thursday? thursday,
    Friday? friday,
    Saturday? saturday,
    String? imagePath,
    List<ServiceName>? services,
    Business? business,
    num? commissionPercentage,
  }) {
    _empId = empId;
    _salonId = salonId;
    _name = name;
    _image = image;
    _email = email;
    _password = password;
    _phone = phone;
    _giveService = giveService;
    _serviceId = serviceId;
    _sun = sun;
    _mon = mon;
    _tue = tue;
    _wed = wed;
    _thu = thu;
    _fri = fri;
    _sat = sat;
    _status = status;
    _deviceToken = deviceToken;
    _isdelete = isdelete;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _sunday = sunday;
    _monday = monday;
    _tuesday = tuesday;
    _wednesday = wednesday;
    _thursday = thursday;
    _friday = friday;
    _saturday = saturday;
    _imagePath = imagePath;
    _services = services;
    _business = business;
    _commissionPercentage = commissionPercentage;
  }

  EmployeeData.fromJson(dynamic json) {
    _empId = json['emp_id'];
    _salonId = json['business_id'];
    _name = json['name'];
    _image = json['image'];
    _email = json['email'];
    _password = json['password'];
    _phone = json['phone'].runtimeType == String ? num.parse(json['phone']) : json['phone'];
    _giveService = json['give_service'];
    _serviceId = json['service_id'];
    _sun = json['sun'];
    _mon = json['mon'];
    _tue = json['tue'];
    _wed = json['wed'];
    _thu = json['thu'];
    _fri = json['fri'];
    _sat = json['sat'];
    _status = json['status'];
    _deviceToken = json['device_token'];
    _isdelete = json['isdelete'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _sunday = json['sunday'] != null ? Sunday.fromJson(json['sunday']) : null;
    _monday = json['monday'] != null ? Monday.fromJson(json['monday']) : null;
    _tuesday = json['tuesday'] != null ? Tuesday.fromJson(json['tuesday']) : null;
    _wednesday = json['wednesday'] != null ? Wednesday.fromJson(json['wednesday']) : null;
    _thursday = json['thursday'] != null ? Thursday.fromJson(json['thursday']) : null;
    _friday = json['friday'] != null ? Friday.fromJson(json['friday']) : null;
    _saturday = json['saturday'] != null ? Saturday.fromJson(json['saturday']) : null;
    _imagePath = json['imagePath'];
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(ServiceName.fromJson(v));
      });
    }
    _business = json['business'] != null ? Business.fromJson(json['business']) : null;
    _commissionPercentage = num.tryParse((json['commission_percentage'] ?? 0).toString());
  }

  num? _empId;
  num? _salonId;
  String? _name;
  String? _image;
  String? _email;
  String? _password;
  num? _phone;
  String? _giveService;
  String? _serviceId;
  String? _sun;
  String? _mon;
  String? _tue;
  String? _wed;
  String? _thu;
  String? _fri;
  String? _sat;
  num? _status;
  dynamic _deviceToken;
  num? _isdelete;
  String? _createdAt;
  String? _updatedAt;
  Sunday? _sunday;
  Monday? _monday;
  Tuesday? _tuesday;
  Wednesday? _wednesday;
  Thursday? _thursday;
  Friday? _friday;
  Saturday? _saturday;
  String? _imagePath;
  List<ServiceName>? _services;
  Business? _business;
  num? _commissionPercentage;

  EmployeeData copyWith({
    num? empId,
    num? salonId,
    String? name,
    String? image,
    String? email,
    String? password,
    num? phone,
    String? giveService,
    String? serviceId,
    String? sun,
    String? mon,
    String? tue,
    String? wed,
    String? thu,
    String? fri,
    String? sat,
    num? status,
    dynamic deviceToken,
    num? isdelete,
    String? createdAt,
    String? updatedAt,
    Sunday? sunday,
    Monday? monday,
    Tuesday? tuesday,
    Wednesday? wednesday,
    Thursday? thursday,
    Friday? friday,
    Saturday? saturday,
    String? imagePath,
    List<ServiceName>? services,
    Business? salon,
    num? commissionPercentage,
  }) =>
      EmployeeData(
        empId: empId ?? _empId,
        salonId: salonId ?? _salonId,
        name: name ?? _name,
        image: image ?? _image,
        email: email ?? _email,
        password: password ?? _password,
        phone: phone ?? _phone,
        giveService: giveService ?? _giveService,
        serviceId: serviceId ?? _serviceId,
        sun: sun ?? _sun,
        mon: mon ?? _mon,
        tue: tue ?? _tue,
        wed: wed ?? _wed,
        thu: thu ?? _thu,
        fri: fri ?? _fri,
        sat: sat ?? _sat,
        status: status ?? _status,
        deviceToken: deviceToken ?? _deviceToken,
        isdelete: isdelete ?? _isdelete,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        sunday: sunday ?? _sunday,
        monday: monday ?? _monday,
        tuesday: tuesday ?? _tuesday,
        wednesday: wednesday ?? _wednesday,
        thursday: thursday ?? _thursday,
        friday: friday ?? _friday,
        saturday: saturday ?? _saturday,
        imagePath: imagePath ?? _imagePath,
        services: services ?? _services,
        business: salon ?? _business,
        commissionPercentage: commissionPercentage ?? _commissionPercentage,
      );

  num? get empId => _empId;

  num? get salonId => _salonId;

  String? get name => _name;

  String? get image => _image;

  String? get email => _email;

  String? get password => _password;

  num? get phone => _phone;

  String? get giveService => _giveService;

  String? get serviceId => _serviceId;

  String? get sun => _sun;

  String? get mon => _mon;

  String? get tue => _tue;

  String? get wed => _wed;

  String? get thu => _thu;

  String? get fri => _fri;

  String? get sat => _sat;

  num? get status => _status;

  dynamic get deviceToken => _deviceToken;

  num? get isdelete => _isdelete;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Sunday? get sunday => _sunday;

  Monday? get monday => _monday;

  Tuesday? get tuesday => _tuesday;

  Wednesday? get wednesday => _wednesday;

  Thursday? get thursday => _thursday;

  Friday? get friday => _friday;

  Saturday? get saturday => _saturday;

  String? get imagePath => _imagePath;

  List<ServiceName>? get services => _services;

  Business? get salon => _business;

  num? get commissionPercentage => _commissionPercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['emp_id'] = _empId;
    map['business_id'] = _salonId;
    map['name'] = _name;
    map['image'] = _image;
    map['email'] = _email;
    map['password'] = _password;
    map['phone'] = _phone;
    map['give_service'] = _giveService;
    map['service_id'] = _serviceId;
    map['sun'] = _sun;
    map['mon'] = _mon;
    map['tue'] = _tue;
    map['wed'] = _wed;
    map['thu'] = _thu;
    map['fri'] = _fri;
    map['sat'] = _sat;
    map['status'] = _status;
    map['device_token'] = _deviceToken;
    map['isdelete'] = _isdelete;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
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
    map['imagePath'] = _imagePath;
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    if (_business != null) {
      map['salon'] = _business?.toJson();
    }
    return map;
  }
}

class Business {
  Business({
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
    num? availableNow,
    String? time,
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
    _availableNow = availableNow;
    _time = time;
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
  }

  Business.fromJson(dynamic json) {
    _salonId = json['business_id'];
    _ownerId = json['owner_id'];
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
    _phone = json['phone'];
    _sun = json['sun'];
    _mon = json['mon'];
    _tue = json['tue'];
    _wed = json['wed'];
    _thu = json['thu'];
    _fri = json['fri'];
    _sat = json['sat'];
    _status = json['status'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _availableNow = json['available_now'];
    _time = json['time'];
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
  num? _availableNow;
  String? _time;
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

  Business copyWith({
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
    num? availableNow,
    String? time,
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
  }) =>
      Business(
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
        availableNow: availableNow ?? _availableNow,
        time: time ?? _time,
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

  num? get availableNow => _availableNow;

  String? get time => _time;

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
    map['available_now'] = _availableNow;
    map['time'] = _time;
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

class ServiceName {
  ServiceName({
    num? serviceId,
    num? catId,
    num? salonId,
    String? image,
    String? name,
    num? time,
    String? gender,
    num? price,
    num? status,
    num? isdelete,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
    CategoryData? categoryData,
  }) {
    _serviceId = serviceId;
    _catId = catId;
    _salonId = salonId;
    _image = image;
    _name = name;
    _time = time;
    _gender = gender;
    _price = price;
    _status = status;
    _isdelete = isdelete;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imagePath = imagePath;
    _categoryData = categoryData;
  }

  ServiceName.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _catId = json['cat_id'].runtimeType == String ? num.parse(json['cat_id']) : json['cat_id'];
    _salonId = json['business_id'];
    _image = json['image'];
    _name = json['name'];
    _time = json['time'].runtimeType == String ? num.parse(json['time']) : json['time'];
    _gender = json['gender'];
    _price = json['price'].runtimeType == String ? num.parse(json['price']) : json['price'];
    _status = json['status'].runtimeType == String ? num.parse(json['status']) : json['status'];
    _isdelete = json['isdelete'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imagePath = json['imagePath'];
    _categoryData = json['category'] != null ? CategoryData.fromJson(json['category']) : null;
  }

  num? _serviceId;
  num? _catId;
  num? _salonId;
  String? _image;
  String? _name;
  num? _time;
  String? _gender;
  num? _price;
  num? _status;
  num? _isdelete;
  String? _createdAt;
  String? _updatedAt;
  String? _imagePath;
  CategoryData? _categoryData;

  ServiceName copyWith({
    num? serviceId,
    num? catId,
    num? salonId,
    String? image,
    String? name,
    num? time,
    String? gender,
    num? price,
    num? status,
    num? isdelete,
    String? createdAt,
    String? updatedAt,
    String? imagePath,
    CategoryData? categoryData,
  }) =>
      ServiceName(
        serviceId: serviceId ?? _serviceId,
        catId: catId ?? _catId,
        salonId: salonId ?? _salonId,
        image: image ?? _image,
        name: name ?? _name,
        time: time ?? _time,
        gender: gender ?? _gender,
        price: price ?? _price,
        status: status ?? _status,
        isdelete: isdelete ?? _isdelete,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        imagePath: imagePath ?? _imagePath,
        categoryData: categoryData ?? _categoryData,
      );

  num? get serviceId => _serviceId;

  num? get catId => _catId;

  num? get salonId => _salonId;

  String? get image => _image;

  String? get name => _name;

  num? get time => _time;

  String? get gender => _gender;

  num? get price => _price;

  num? get status => _status;

  num? get isdelete => _isdelete;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get imagePath => _imagePath;

  CategoryData? get categoryData => _categoryData;
  bool isSelected = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['cat_id'] = _catId;
    map['business_id'] = _salonId;
    map['image'] = _image;
    map['name'] = _name;
    map['time'] = _time;
    map['gender'] = _gender;
    map['price'] = _price;
    map['status'] = _status;
    map['isdelete'] = _isdelete;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['imagePath'] = _imagePath;
    map['category'] = _categoryData;
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
    dynamic deviceToken,
    String? language,
    String? provider,
    dynamic providerToken,
    num? notification,
    num? mail,
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
    dynamic deviceToken,
    String? language,
    String? provider,
    dynamic providerToken,
    num? notification,
    num? mail,
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
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['imagePath'] = _imagePath;
    map['businessName'] = _businessName;
    return map;
  }
}

class Saturday {
  Saturday({
    String? open,
    String? close,
  }) {
    _open = open;
    _close = close;
  }

  Saturday.fromJson(dynamic json) {
    _open = json['open'];
    _close = json['close'];
  }

  String? _open;
  String? _close;

  Saturday copyWith({
    String? open,
    String? close,
  }) =>
      Saturday(
        open: open ?? _open,
        close: close ?? _close,
      );

  String? get open => _open;

  String? get close => _close;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['open'] = _open;
    map['close'] = _close;
    return map;
  }
}

class Friday {
  Friday({
    String? open,
    String? close,
  }) {
    _open = open;
    _close = close;
  }

  Friday.fromJson(dynamic json) {
    _open = json['open'];
    _close = json['close'];
  }

  String? _open;
  String? _close;

  Friday copyWith({
    String? open,
    String? close,
  }) =>
      Friday(
        open: open ?? _open,
        close: close ?? _close,
      );

  String? get open => _open;

  String? get close => _close;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['open'] = _open;
    map['close'] = _close;
    return map;
  }
}

class Thursday {
  Thursday({
    String? open,
    String? close,
  }) {
    _open = open;
    _close = close;
  }

  Thursday.fromJson(dynamic json) {
    _open = json['open'];
    _close = json['close'];
  }

  String? _open;
  String? _close;

  Thursday copyWith({
    String? open,
    String? close,
  }) =>
      Thursday(
        open: open ?? _open,
        close: close ?? _close,
      );

  String? get open => _open;

  String? get close => _close;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['open'] = _open;
    map['close'] = _close;
    return map;
  }
}

class Wednesday {
  Wednesday({
    String? open,
    String? close,
  }) {
    _open = open;
    _close = close;
  }

  Wednesday.fromJson(dynamic json) {
    _open = json['open'];
    _close = json['close'];
  }

  String? _open;
  String? _close;

  Wednesday copyWith({
    String? open,
    String? close,
  }) =>
      Wednesday(
        open: open ?? _open,
        close: close ?? _close,
      );

  String? get open => _open;

  String? get close => _close;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['open'] = _open;
    map['close'] = _close;
    return map;
  }
}

class Tuesday {
  Tuesday({
    String? open,
    String? close,
  }) {
    _open = open;
    _close = close;
  }

  Tuesday.fromJson(dynamic json) {
    _open = json['open'];
    _close = json['close'];
  }

  String? _open;
  String? _close;

  Tuesday copyWith({
    String? open,
    String? close,
  }) =>
      Tuesday(
        open: open ?? _open,
        close: close ?? _close,
      );

  String? get open => _open;

  String? get close => _close;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['open'] = _open;
    map['close'] = _close;
    return map;
  }
}

class Monday {
  Monday({
    String? open,
    String? close,
  }) {
    _open = open;
    _close = close;
  }

  Monday.fromJson(dynamic json) {
    _open = json['open'];
    _close = json['close'];
  }

  String? _open;
  String? _close;

  Monday copyWith({
    String? open,
    String? close,
  }) =>
      Monday(
        open: open ?? _open,
        close: close ?? _close,
      );

  String? get open => _open;

  String? get close => _close;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['open'] = _open;
    map['close'] = _close;
    return map;
  }
}

class Sunday {
  Sunday({
    String? open,
    String? close,
  }) {
    _open = open;
    _close = close;
  }

  Sunday.fromJson(dynamic json) {
    _open = json['open'];
    _close = json['close'];
  }

  String? _open;
  String? _close;

  Sunday copyWith({
    String? open,
    String? close,
  }) =>
      Sunday(
        open: open ?? _open,
        close: close ?? _close,
      );

  String? get open => _open;

  String? get close => _close;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['open'] = _open;
    map['close'] = _close;
    return map;
  }
}
