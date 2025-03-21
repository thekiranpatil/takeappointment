import 'dart:convert';
import 'dart:io';

import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/profile_response.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class ProfileProvider extends ChangeNotifier {
  bool profileLoader = false;

  bool isNotification = false;
  bool isEmail = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();

  Future<BaseModel<ProfileResponse>> callProfile() async {
    ProfileResponse response;
    try {
      profileLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetProfile();
      if (response.success == true) {
        isNotification = response.data!.notification == 1 ? true : false;
        isEmail = response.data!.mail == 1 ? true : false;
        SharedPreferenceHelper.setString(PreferencesNames.email, response.data!.email ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.phoneNo, response.data!.phone ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.userName, response.data!.name ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.phoneCode, response.data!.code ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.imageUrl, "${response.data!.imagePath ?? ""}" + "${response.data!.image ?? ""}");
        userNameController.text = response.data!.name ?? "";
        emailController.text = response.data!.email ?? "";
        phoneNumberController.text = response.data!.phone ?? "";
        countryCodeController.text = response.data!.code ?? "";
        response.data!.totalPoints != null ? SharedPreferenceHelper.setDouble(PreferencesNames.totalPoints, double.parse(response.data!.totalPoints!)) : null;
        response.data!.remainPoints != null ? SharedPreferenceHelper.setDouble(PreferencesNames.remainPoints, double.parse(response.data!.remainPoints!)) : null;
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      profileLoader = false;
      notifyListeners();
    } catch (error) {
      profileLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<ProfileResponse>> callUpdateNotification(Map<String, dynamic> body) async {
    ProfileResponse response;
    try {
      profileLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callProfileNotificationUpdate(body);
      if (response.success == true) {
        isNotification = response.data!.notification == 1 ? true : false;
        isEmail = response.data!.mail == 1 ? true : false;
        SharedPreferenceHelper.setString(PreferencesNames.email, response.data!.email ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.phoneNo, response.data!.phone ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.userName, response.data!.name ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.phoneCode, response.data!.code ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.imageUrl, "${response.data!.imagePath ?? ""}" + "${response.data!.image ?? ""}");
        userNameController.text = response.data!.name ?? "";
        emailController.text = response.data!.email ?? "";
        phoneNumberController.text = response.data!.phone ?? "";
        countryCodeController.text = response.data!.code ?? "";
        response.data!.totalPoints != null ? SharedPreferenceHelper.setDouble(PreferencesNames.totalPoints, double.parse(response.data!.totalPoints!)) : null;
        response.data!.remainPoints != null ? SharedPreferenceHelper.setDouble(PreferencesNames.remainPoints, double.parse(response.data!.remainPoints!)) : null;
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      profileLoader = false;
      notifyListeners();
    } catch (error) {
      profileLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<ProfileResponse>> callUpdateEmail(Map<String, dynamic> body) async {
    ProfileResponse response;
    try {
      profileLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callProfileEmailUpdate(body);
      if (response.success == true) {
        isNotification = response.data!.notification == 1 ? true : false;
        isEmail = response.data!.mail == 1 ? true : false;
        SharedPreferenceHelper.setString(PreferencesNames.email, response.data!.email ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.phoneNo, response.data!.phone ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.userName, response.data!.name ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.phoneCode, response.data!.code ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.imageUrl, "${response.data!.imagePath ?? ""}" + "${response.data!.image ?? ""}");
        userNameController.text = response.data!.name ?? "";
        emailController.text = response.data!.email ?? "";
        phoneNumberController.text = response.data!.phone ?? "";
        countryCodeController.text = response.data!.code ?? "";
        response.data!.totalPoints != null ? SharedPreferenceHelper.setDouble(PreferencesNames.totalPoints, double.parse(response.data!.totalPoints!)) : null;
        response.data!.remainPoints != null ? SharedPreferenceHelper.setDouble(PreferencesNames.remainPoints, double.parse(response.data!.remainPoints!)) : null;
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      profileLoader = false;
      notifyListeners();
    } catch (error) {
      profileLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<ProfileResponse>> callUpdateProfile(Map<String, dynamic> body, BuildContext context) async {
    ProfileResponse response;
    try {
      profileLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callUpdateProfile(body);
      if (response.success == true) {
        isNotification = response.data!.notification == 1 ? true : false;
        isEmail = response.data!.mail == 1 ? true : false;
        SharedPreferenceHelper.setString(PreferencesNames.email, response.data!.email ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.phoneNo, response.data!.phone ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.userName, response.data!.name ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.phoneCode, response.data!.code ?? "");
        SharedPreferenceHelper.setString(PreferencesNames.imageUrl, "${response.data!.imagePath ?? ""}" + "${response.data!.image ?? ""}");
        userNameController.text = response.data!.name ?? "";
        emailController.text = response.data!.email ?? "";
        phoneNumberController.text = response.data!.phone ?? "";
        countryCodeController.text = response.data!.code ?? "";
        response.data!.totalPoints != null ? SharedPreferenceHelper.setDouble(PreferencesNames.totalPoints, double.parse(response.data!.totalPoints!)) : null;
        response.data!.remainPoints != null ? SharedPreferenceHelper.setDouble(PreferencesNames.remainPoints, double.parse(response.data!.remainPoints!)) : null;
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
        Navigator.of(context).pop();
      }
      else if(response.success==false){
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
      }
      profileLoader = false;
      notifyListeners();
    } catch (error) {
      profileLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  File? proImage;
  final picker = ImagePicker();
  String image = "";

  void chooseProfileImage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text(
                      getTranslated(context, LangConst.fromGallery).toString(),
                    ),
                    onTap: () {
                      _proImgFromGallery(context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                    getTranslated(context, LangConst.fromCamera).toString(),
                  ),
                  onTap: () {
                    _proImgFromCamera(context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _proImgFromGallery(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      proImage = File(pickedFile.path);
      List<int> imageBytes = proImage!.readAsBytesSync();
      image = base64Encode(imageBytes);
      Map<String, dynamic> body = {
        // "image": "data:image/jpg;base64,"+image,
        "image": image,
        "phone": SharedPreferenceHelper.getString(PreferencesNames.phoneNo),
        "name": SharedPreferenceHelper.getString(PreferencesNames.userName),
        "code": SharedPreferenceHelper.getString(PreferencesNames.phoneCode),
        "email": SharedPreferenceHelper.getString(PreferencesNames.email),
      };

      callUpdateProfile(body, context);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  void _proImgFromCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      proImage = File(pickedFile.path);
      List<int> imageBytes = proImage!.readAsBytesSync();
      image = base64Encode(imageBytes);
      Map<String, dynamic> body = {
        "image": image,
        "phone": SharedPreferenceHelper.getString(PreferencesNames.phoneNo),
        "name": SharedPreferenceHelper.getString(PreferencesNames.userName),
        "code": SharedPreferenceHelper.getString(PreferencesNames.phoneCode),
        "email": SharedPreferenceHelper.getString(PreferencesNames.email),
      };
      callUpdateProfile(body, context);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }
}
