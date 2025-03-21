import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  int? _errorCode;
  String _errorMessage = "";

  ServerError.withError({error}) {
    if (error is FormatException) {
      _handleFormatException(error);
      return;
    }
    if (error is DioException) {
      _handleError(error);
      return;
    }
    DeviceUtils.toastMessage('${error.toString()}');
  }

  getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioException error) {
    if (error.runtimeType == DioExceptionType.unknown){
      print(error.message);
      return DeviceUtils.toastMessage('Unknown error');
    }
    if (error.type == DioExceptionType.connectionTimeout) {
      print(error.message);
      return DeviceUtils.toastMessage('Connection timeout');
    }
    if (error.type == DioExceptionType.badResponse) {
      print(error.message);
      if (error.response?.data['msg'] != null) {
        print(error.response?.data['msg'].toString());
        return DeviceUtils.toastMessage('${error.response?.data['msg'].toString()}');
      } else if (error.response?.data['message'] != null) {
        print(error.response?.data['message'].toString());
        return DeviceUtils.toastMessage('${error.response?.data['message'].toString()}');
      }
    }
    if (error.type == DioExceptionType.cancel) {
      print(error.message);
      return DeviceUtils.toastMessage('Request was cancelled');
    }
    if (error.type == DioExceptionType.connectionError) {
      print(error.message);
      return DeviceUtils.toastMessage('Connection failed. Please check internet connection');
    }
    if (error.type == DioExceptionType.badCertificate) {
      print(error.message);
      return DeviceUtils.toastMessage('${error.response?.data['msg']}');
    }
    if (error.type == DioExceptionType.receiveTimeout) {
      print(error.message);
      return DeviceUtils.toastMessage('Receive timeout in connection');
    }
    if (error.type == DioExceptionType.sendTimeout) {
      print(error.message);
      return DeviceUtils.toastMessage('Receive timeout in send request');
    }
    if (error.response!.statusCode == 401 && error.response!.data['message'] != null) {
      return DeviceUtils.toastMessage('${error.response!.data['message'].toString()}');
    }
    if (error.response!.data['error'] != null) {
      return DeviceUtils.toastMessage(
        '${error.response!.data['error']}',
      );
    }
    if (error.response!.data['errors']['email'] != null) {
      return DeviceUtils.toastMessage(
        '${error.response!.data['errors']['email'][0]}',
      );
    }
    if (error.response!.data['errors']['phone'] != null) {
      return DeviceUtils.toastMessage(
        '${error.response!.data['errors']['phone'][0]}',
      );
    }
    if (error.response!.data['errors']['confirm'] != null) {
      return DeviceUtils.toastMessage(
        '${error.response!.data['errors']['confirm'][0]}',
      );
    }
    if (error.response!.data['errors']['password'] != null) {
      return DeviceUtils.toastMessage(
        '${error.response!.data['errors']['password'][0]}',
      );
    }
    if (error.response!.data['errors']['new_password'] != null) {
      return DeviceUtils.toastMessage(
        '${error.response!.data['errors']['new_password'][0]}',
      );
    }
    if (error.response!.data['errors']['confirm_password'] != null) {
      return DeviceUtils.toastMessage(
        '${error.response!.data['errors']['confirm_password'][0]}',
      );
    }
    if (error.response!.data['errors']['old_password'] != null) {
      return DeviceUtils.toastMessage(
        '${error.response!.data['errors']['old_password'][0]}',
      );
    }
    return _errorMessage;
  }

  _handleFormatException(FormatException error) {
    print('Format Exception: ${error.toString()}');
  }
}
