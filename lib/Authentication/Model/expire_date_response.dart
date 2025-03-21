/// expire_date : "2024-02-16"
/// success : true

class ExpireDateResponse {
  ExpireDateResponse({
      this.expireDate, 
      this.success,});

  ExpireDateResponse.fromJson(dynamic json) {
    expireDate = json['expire_date'];
    success = json['success'];
  }
  String? expireDate;
  bool? success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expire_date'] = expireDate;
    map['success'] = success;
    return map;
  }

}