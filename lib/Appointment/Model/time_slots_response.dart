class TimeSlotsResponse {
  TimeSlotsResponse({
    String? msg,
    List<TimeSlotData>? data,
    bool? success,
  }) {
    _msg = msg;
    _data = data;
    _success = success;
  }

  TimeSlotsResponse.fromJson(dynamic json) {
    _msg = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TimeSlotData.fromJson(v));
      });
    }
    _success = json['success'];
  }

  String? _msg;
  List<TimeSlotData>? _data;
  bool? _success;

  String? get msg => _msg;

  List<TimeSlotData>? get data => _data;

  bool? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _msg;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    return map;
  }
}

class TimeSlotData {
  TimeSlotData({
    String? startTime,
    String? endTime,
  }) {
    _startTime = startTime;
    _endTime = endTime;
  }

  TimeSlotData.fromJson(dynamic json) {
    _startTime = json['start_time'];
    _endTime = json['end_time'];
  }

  String? _startTime;
  String? _endTime;

  String? get startTime => _startTime;

  String? get endTime => _endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    return map;
  }
}
