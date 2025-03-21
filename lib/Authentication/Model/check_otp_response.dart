/// msg : "OTP match"
/// success : true
/// wait : false

class CheckOtpResponse {
  CheckOtpResponse({
      this.msg, 
      this.success, 
      this.wait,});

  CheckOtpResponse.fromJson(dynamic json) {
    msg = json['msg'];
    success = json['success'];
    wait = json['wait'];
  }
  String? msg;
  bool? success;
  bool? wait;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = msg;
    map['success'] = success;
    map['wait'] = wait;
    return map;
  }

}