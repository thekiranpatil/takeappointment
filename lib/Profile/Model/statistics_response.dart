class StatisticsResponse {
  StatisticsResponse({
    bool? success,
    StatisticsData? data,
    String? message,
  }) {
    _success = success;
    _data = data;
    _message = message;
  }

  StatisticsResponse.fromJson(dynamic json) {
    _success = json['success'];
    _data = json['data'] != null ? StatisticsData.fromJson(json['data']) : null;
    _message = json['message'];
  }

  bool? _success;
  StatisticsData? _data;
  String? _message;

  StatisticsResponse copyWith({
    bool? success,
    StatisticsData? data,
    String? message,
  }) =>
      StatisticsResponse(
        success: success ?? _success,
        data: data ?? _data,
        message: message ?? _message,
      );

  bool? get success => _success;

  StatisticsData? get data => _data;

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

class StatisticsData {
  StatisticsData({
    num? income,
    StatisticsSetting? setting,
    num? service,
    num? users,
    num? employee,
    num? appointment,
    num? pendingAppointment,
    num? approvedAppointment,
    num? cancelAppointment,
  }) {
    _income = income;
    _setting = setting;
    _service = service;
    _users = users;
    _employee = employee;
    _appointment = appointment;
    _pendingAppointment = pendingAppointment;
    _approvedAppointment = approvedAppointment;
    _cancelAppointment = cancelAppointment;
  }

  StatisticsData.fromJson(dynamic json) {
    _income = json['income'];
    _setting = json['setting'] != null ? StatisticsSetting.fromJson(json['setting']) : null;
    _service = json['service'];
    _users = json['users'];
    _employee = json['employee'];
    _appointment = json['appointment'];
    _pendingAppointment = json['pending_appointment'];
    _approvedAppointment = json['approved_appointment'];
    _cancelAppointment = json['cancel_appointment'];
  }

  num? _income;
  StatisticsSetting? _setting;
  num? _service;
  num? _users;
  num? _employee;
  num? _appointment;
  num? _pendingAppointment;
  num? _approvedAppointment;
  num? _cancelAppointment;

  StatisticsData copyWith({
    num? income,
    StatisticsSetting? setting,
    num? service,
    num? users,
    num? employee,
    num? appointment,
    num? pendingAppointment,
    num? approvedAppointment,
    num? cancelAppointment,
  }) =>
      StatisticsData(
        income: income ?? _income,
        setting: setting ?? _setting,
        service: service ?? _service,
        users: users ?? _users,
        employee: employee ?? _employee,
        appointment: appointment ?? _appointment,
        pendingAppointment: pendingAppointment ?? _pendingAppointment,
        approvedAppointment: approvedAppointment ?? _approvedAppointment,
        cancelAppointment: cancelAppointment ?? _cancelAppointment,
      );

  num? get income => _income;

  StatisticsSetting? get setting => _setting;

  num? get service => _service;

  num? get users => _users;

  num? get employee => _employee;

  num? get appointment => _appointment;

  num? get pendingAppointment => _pendingAppointment;

  num? get approvedAppointment => _approvedAppointment;

  num? get cancelAppointment => _cancelAppointment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['income'] = _income;
    if (_setting != null) {
      map['setting'] = _setting?.toJson();
    }
    map['service'] = _service;
    map['users'] = _users;
    map['employee'] = _employee;
    map['appointment'] = _appointment;
    map['pending_appointment'] = _pendingAppointment;
    map['approved_appointment'] = _approvedAppointment;
    map['cancel_appointment'] = _cancelAppointment;
    return map;
  }
}

class StatisticsSetting {
  StatisticsSetting({
    String? currency,
    String? currencySymbol,
    String? imagePath,
  }) {
    _currency = currency;
    _currencySymbol = currencySymbol;
    _imagePath = imagePath;
  }

  StatisticsSetting.fromJson(dynamic json) {
    _currency = json['currency'];
    _currencySymbol = json['currency_symbol'];
    _imagePath = json['imagePath'];
  }

  String? _currency;
  String? _currencySymbol;
  String? _imagePath;

  StatisticsSetting copyWith({
    String? currency,
    String? currencySymbol,
    String? imagePath,
  }) =>
      StatisticsSetting(
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
