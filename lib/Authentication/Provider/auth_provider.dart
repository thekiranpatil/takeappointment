import 'package:multibusiness_business_app_flutter/Authentication/Model/app_setting_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/check_otp_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/expire_date_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/forgot_password_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/login_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/register_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/otp_verification_screen_register.dart';
import 'package:multibusiness_business_app_flutter/Authentication/sign_in_screen.dart';
import 'package:multibusiness_business_app_flutter/Home/add_business_screen.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/change_password_response.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/dashboard_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:multibusiness_business_app_flutter/main.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthProvider extends ChangeNotifier {
  bool loginLoader = false;

  Future<BaseModel<LoginResponse>> callLogin(Map<String, dynamic> body, BuildContext context) async {
    LoginResponse response;
    try {
      loginLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callLogin(body);
      if (response.success == true) {
        if (response.data!.token!.isNotEmpty) {
          if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
          if (response.data!.token != null)
            SharedPreferenceHelper.setString(PreferencesNames.authToken, response.data!.token!);
          if (response.data!.user != null) {
            SharedPreferenceHelper.setString(PreferencesNames.userId, response.data!.user!.id.toString());
            SharedPreferenceHelper.setString(PreferencesNames.email, response.data!.user!.email ?? "");
            SharedPreferenceHelper.setString(PreferencesNames.phoneNo, response.data!.user!.phone ?? "");
            SharedPreferenceHelper.setString(PreferencesNames.userName, response.data!.user!.name ?? "");
            SharedPreferenceHelper.setString(PreferencesNames.phoneCode, response.data!.user!.code ?? "");
            SharedPreferenceHelper.setString(PreferencesNames.imageUrl,
                "${response.data!.user!.imagePath ?? ""}" + "${response.data!.user!.image ?? ""}");
            response.data!.user!.totalPoints != null
                ? SharedPreferenceHelper.setDouble(
                    PreferencesNames.totalPoints, double.parse(response.data!.user!.totalPoints!))
                : null;
            response.data!.user!.remainPoints != null
                ? SharedPreferenceHelper.setDouble(
                    PreferencesNames.remainPoints, double.parse(response.data!.user!.remainPoints!))
                : null;
            SharedPreferenceHelper.setBoolean(PreferencesNames.isLogin, true);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashBoardScreen()));
          }
        } else if (response.data!.token!.isEmpty) {
          if (response.data!.user != null) {
            SharedPreferenceHelper.setString(PreferencesNames.email, response.data!.user!.email ?? "");
            SharedPreferenceHelper.setString(PreferencesNames.userId, response.data!.user!.id.toString());
            SharedPreferenceHelper.setString(PreferencesNames.phoneNo, response.data!.user!.phone ?? "");
            SharedPreferenceHelper.setString(PreferencesNames.userName, response.data!.user!.name ?? "");
            SharedPreferenceHelper.setString(PreferencesNames.phoneCode, response.data!.user!.code ?? "");
            SharedPreferenceHelper.setString(PreferencesNames.imageUrl,
                "${response.data!.user!.imagePath ?? ""}" + "${response.data!.user!.image ?? ""}");
            SharedPreferenceHelper.setBoolean(PreferencesNames.isLogin, true);
            response.data!.user!.totalPoints != null
                ? SharedPreferenceHelper.setDouble(
                    PreferencesNames.totalPoints, double.parse(response.data!.user!.totalPoints!))
                : null;
            response.data!.user!.remainPoints != null
                ? SharedPreferenceHelper.setDouble(
                    PreferencesNames.remainPoints, double.parse(response.data!.user!.remainPoints!))
                : null;
          }
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AddBusinessScreen()));
        }
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
        notifyListeners();
      } else if (response.success == false) {
        if (response.message != null)
          getTranslated(context, response.message!).toString() != "null"
              ? DeviceUtils.toastMessage(getTranslated(context, response.message!).toString())
              : DeviceUtils.toastMessage(response.message!);
        if (response.data != null) {
          if (response.data!.user!.verifiedByPhone == 0 && response.data!.user!.verifiedByEmail == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OtpVerificationScreenRegistration(
                    userId: response.data!.user!.id!.toInt(),
                    emailVerify: response.data!.user!.verifiedByEmail ?? 0,
                    phoneVerify: response.data!.user!.verifiedByPhone ?? 0),
              ),
            );
          } else if (response.data!.user!.verifiedByPhone == 1 && response.data!.user!.verifiedByEmail == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OtpVerificationScreenRegistration(
                    userId: response.data!.user!.id!.toInt(),
                    emailVerify: response.data!.user!.verifiedByEmail ?? 0,
                    phoneVerify: response.data!.user!.verifiedByPhone ?? 0),
              ),
            );
          } else if (response.data!.user!.verifiedByPhone == 0 && response.data!.user!.verifiedByEmail == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => OtpVerificationScreenRegistration(
                    userId: response.data!.user!.id!.toInt(),
                    emailVerify: response.data!.user!.verifiedByEmail ?? 0,
                    phoneVerify: response.data!.user!.verifiedByPhone ?? 0),
              ),
            );
          }
        }
      }

      loginLoader = false;
      notifyListeners();
    } catch (error) {
      loginLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<ChangePasswordResponse>> callChangePassword(Map<String, dynamic> body, BuildContext context) async {
    ChangePasswordResponse response;
    try {
      loginLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callChangePassword(body);
      if (response.success == true) {
        if (response.msg != null) DeviceUtils.toastMessage(getTranslated(context, response.msg!).toString());
        Navigator.of(context).pop();
      } else if (response.success == false) {
        if (response.msg != null) DeviceUtils.toastMessage(getTranslated(context, response.msg!).toString());
      }
      loginLoader = false;
      notifyListeners();
    } catch (error) {
      loginLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<RegisterResponse>> callRegister(Map<String, dynamic> body, BuildContext context) async {
    RegisterResponse response;
    try {
      loginLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callRegister(body);
      if (response.data!.verifiedByPhone == 0 && response.data!.verifiedByEmail == 0 && response.data != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreenRegistration(
                userId: response.data!.id!.toInt(),
                emailVerify: response.data!.verifiedByEmail!,
                phoneVerify: response.data!.verifiedByPhone!),
          ),
        );
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
      } else if (response.data!.verifiedByEmail == 1 && response.data!.verifiedByPhone == 0 && response.data != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreenRegistration(
                userId: response.data!.id!.toInt(),
                emailVerify: response.data!.verifiedByEmail ?? 0,
                phoneVerify: response.data!.verifiedByPhone ?? 0),
          ),
        );
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
      } else if (response.data!.verifiedByEmail == 0 && response.data!.verifiedByPhone == 1 && response.data != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OtpVerificationScreenRegistration(
                userId: response.data!.id!.toInt(),
                emailVerify: response.data!.verifiedByEmail ?? 0,
                phoneVerify: response.data!.verifiedByPhone ?? 0),
          ),
        );
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
      } else if (response.success == false) {
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
      }
      loginLoader = false;
      notifyListeners();
    } catch (error) {
      loginLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<ForgotPasswordResponse>> callForgotPassword(Map<String, dynamic> body, BuildContext context) async {
    ForgotPasswordResponse response;
    try {
      loginLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callForgotPassword(body);
      if (response.success == true) {
        if (response.msg != null) DeviceUtils.toastMessage(getTranslated(context, response.msg!).toString());
        Navigator.of(context).pop();
        notifyListeners();
      } else if (response.success == false) {
        if (response.msg != null) DeviceUtils.toastMessage(getTranslated(context, response.msg!).toString());
      }
      loginLoader = false;
      notifyListeners();
    } catch (error) {
      loginLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<AppSettingResponse>> callSetting() async {
    AppSettingResponse response;
    try {
      response = await ApiServices(ApiHeader().dioData()).callGetSetting();
      if (response.success == true) {
        SharedPreferenceHelper.setString(PreferencesNames.currencySymbol, response.data!.currencySymbol ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.mapKey, response.data!.mapkey ?? "");
        SharedPreferenceHelper.setBoolean(PreferencesNames.isSubscriptionModuleEnabled,
            (response.data!.isSubscriptionModuleEnabled ?? 0) == 1 ? true : false);
        if (response.data!.ownerAppId != null) {
          getOneSingleToken(response.data!.ownerAppId!);
        }
      } else if (response.success == false) {
        if (response.msg != null)
          DeviceUtils.toastMessage(
              getTranslated(NavigationService.navigatorKey.currentState!.context, response.msg!).toString());
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<ExpireDateResponse>> callGetExpiredDate() async {
    ExpireDateResponse response;
    try {
      response = await ApiServices(ApiHeader().dioData()).callExpiredDate();
      if (response.success == true) {
        if (response.expireDate != null) {
          if (DateTime.now().isBefore(DateTime.parse(response.expireDate!))) {
            DeviceUtils.toastMessageExpired(
                "${getTranslated(NavigationService.navigatorKey.currentState!.context, LangConst.yourSubscriptionExpiresOn).toString()} ${response.expireDate.toString()}");
          }
        }
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  getOneSingleToken(String appId) async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize(appId);
    print(appId);
    OneSignal.Notifications.addPermissionObserver((state) {
      print("Has permission " + state.toString());
    });
    OneSignal.Notifications.permission == false &&
            SharedPreferenceHelper.getBoolean(PreferencesNames.notificationPermissionDialog) == false
        ? OneSignal.Notifications.requestPermission(true)
        : null;
    if (kDebugMode) {
      print("OneSignal ID : ${OneSignal.User.pushSubscription.id}");
      print("OneSignal Token : ${OneSignal.User.pushSubscription.token}");
    }
    OneSignal.Debug.setAlertLevel(OSLogLevel.none);
    if (SharedPreferenceHelper.getString(PreferencesNames.onesignalPushToken) == "" ||
        SharedPreferenceHelper.getString(PreferencesNames.onesignalPushToken) == "N/A") {
      if (OneSignal.User.pushSubscription.id != null) {
        SharedPreferenceHelper.setString(
            PreferencesNames.onesignalPushToken, OneSignal.User.pushSubscription.id.toString());
      } else {
        // getOneSingleToken(appId);
        SharedPreferenceHelper.setString(PreferencesNames.onesignalPushToken, '');
      }
    }
  }

  bool otpVerification = false;

  Future<BaseModel<CheckOtpResponse>> callCheckOtp(Map<String, dynamic> body, BuildContext context) async {
    CheckOtpResponse response;
    try {
      otpVerification = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callCheckOtp(body);
      if (response.success == true) {
        if (response.msg != null) DeviceUtils.toastMessage(response.msg!);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignInScreen()));
      } else if (response.success == false) {
        if (response.msg != null) DeviceUtils.toastMessage(response.msg!);
      }
      otpVerification = false;
      notifyListeners();
    } catch (error) {
      otpVerification = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<LoginResponse>> callResendOtp(Map<String, dynamic> body) async {
    LoginResponse response;
    try {
      otpVerification = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callResendOtp(body);
      if (response.success == true) {
        if (response.message != null) DeviceUtils.toastMessage(response.message!);
      } else if (response.success == false) {
        if (response.message != null) DeviceUtils.toastMessage(response.message!);
      }
      otpVerification = false;
      notifyListeners();
    } catch (error) {
      otpVerification = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
