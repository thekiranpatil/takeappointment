class ClientAddressResponse {
  ClientAddressResponse({
    bool? success,
    List<ClientAddressData>? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  ClientAddressResponse.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ClientAddressData.fromJson(v));
      });
    }
    _message = json['message'];
  }

  bool? _success;
  List<ClientAddressData>? _data;
  String? _message;

  bool? get success => _success;

  List<ClientAddressData>? get data => _data;

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

class ClientAddressData {
  ClientAddressData({
    num? addressId,
    num? userId,
    String? label,
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

  ClientAddressData.fromJson(dynamic json) {
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
  String? _label;
  String? _street;
  String? _city;
  String? _state;
  String? _country;
  String? _let;
  String? _long;
  String? _createdAt;
  String? _updatedAt;

  num? get addressId => _addressId;

  num? get userId => _userId;

  String? get label => _label;

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
