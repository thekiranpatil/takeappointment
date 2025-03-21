class ChangePasswordResponse {
  ChangePasswordResponse({
    String? msg,
    dynamic data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  ChangePasswordResponse.fromJson(dynamic json) {
    _msg = json['message'];
    _data = json['data'];
    _success = json['success'];
  }

  String? _msg;
  dynamic _data;
  bool? _success;

  ChangePasswordResponse copyWith({
    String? msg,
    dynamic data,
    bool? success,
  }) =>
      ChangePasswordResponse(
        msg: msg ?? _msg,
        data: data ?? _data,
        success: success ?? _success,
      );

  String? get msg => _msg;

  dynamic get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _msg;
    map['data'] = _data;
    map['success'] = _success;
    return map;
  }
}
