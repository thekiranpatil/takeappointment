import 'package:multibusiness_business_app_flutter/Network/server_error.dart';

class BaseModel<T> {
  late ServerError error;
  T? data;

  setException(ServerError error) {
    this.error = error;
  }

  setData(T data) {
    this.data = data;
  }
}
