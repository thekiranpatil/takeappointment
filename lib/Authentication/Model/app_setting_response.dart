class AppSettingResponse {
  AppSettingResponse({
    String? msg,
    Data? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  AppSettingResponse.fromJson(dynamic json) {
    _msg = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
  }

  String? _msg;
  Data? _data;
  bool? _success;

  String? get msg => _msg;

  Data? get data => _data;

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

class Data {
  Data({
    String? appName,
    dynamic mapkey,
    dynamic ownerProjectNo,
    String? ownerAppId,
    dynamic projectNo,
    dynamic appId,
    String? currency,
    String? currencySymbol,
    String? lat,
    String? lang,
    num? isPointPackage,
    num? referralPoint,
    int? isSubscriptionModuleEnabled,
    String? imagePath,
  }) {
    _appName = appName;
    _mapkey = mapkey;
    _ownerProjectNo = ownerProjectNo;
    _ownerAppId = ownerAppId;
    _projectNo = projectNo;
    _appId = appId;
    _currency = currency;
    _currencySymbol = currencySymbol;
    _lat = lat;
    _lang = lang;
    _isPointPackage = isPointPackage;
    _referralPoint = referralPoint;
    _isSubscriptionModuleEnabled = isSubscriptionModuleEnabled;
    _imagePath = imagePath;
  }

  Data.fromJson(dynamic json) {
    _appName = json['app_name'];
    _mapkey = json['mapkey'];
    _ownerProjectNo = json['owner_project_no'];
    _ownerAppId = json['owner_app_id'];
    _projectNo = json['project_no'];
    _appId = json['app_id'];
    _currency = json['currency'];
    _currencySymbol = json['currency_symbol'];
    _lat = json['lat'];
    _lang = json['lang'];
    _isPointPackage = json['is_point_package'];
    _referralPoint = json['referral_point'];
    _isSubscriptionModuleEnabled = json['is_subscription_module_enabled'] ?? 0;
    _imagePath = json['imagePath'];
  }

  String? _appName;
  dynamic _mapkey;
  dynamic _ownerProjectNo;
  String? _ownerAppId;
  dynamic _projectNo;
  dynamic _appId;
  String? _currency;
  String? _currencySymbol;
  String? _lat;
  String? _lang;
  num? _isPointPackage;
  num? _referralPoint;
  int? _isSubscriptionModuleEnabled;
  String? _imagePath;

  String? get appName => _appName;

  dynamic get mapkey => _mapkey;

  dynamic get ownerProjectNo => _ownerProjectNo;

  String? get ownerAppId => _ownerAppId;

  dynamic get projectNo => _projectNo;

  dynamic get appId => _appId;

  String? get currency => _currency;

  String? get currencySymbol => _currencySymbol;

  String? get lat => _lat;

  String? get lang => _lang;

  num? get isPointPackage => _isPointPackage;

  num? get referralPoint => _referralPoint;

  int? get isSubscriptionModuleEnabled => _isSubscriptionModuleEnabled;

  String? get imagePath => _imagePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['app_name'] = _appName;
    map['mapkey'] = _mapkey;
    map['owner_project_no'] = _ownerProjectNo;
    map['owner_app_id'] = _ownerAppId;
    map['project_no'] = _projectNo;
    map['app_id'] = _appId;
    map['currency'] = _currency;
    map['currency_symbol'] = _currencySymbol;
    map['lat'] = _lat;
    map['lang'] = _lang;
    map['is_point_package'] = _isPointPackage;
    map['referral_point'] = _referralPoint;
    map['is_subscription_module_enabled'] = _isSubscriptionModuleEnabled;
    map['imagePath'] = _imagePath;
    return map;
  }
}
