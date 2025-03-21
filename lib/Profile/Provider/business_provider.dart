import 'dart:convert';
import 'dart:io';

import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/business_profile_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/edit_business_profile_screen.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class BusinessProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController webSiteController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool businessLoader = false;
  Gender gender = Gender.male;
  String latitude = "";
  String longitude = "";
  String homeCharges = "";
  String giveService = "";

  List<TimingModel> times = [
    TimingModel(
      day: "Monday",
      isSelected: false,
      startTime: TextEditingController(),
      endTime: TextEditingController(),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Tuesday",
      isSelected: false,
      startTime: TextEditingController(),
      endTime: TextEditingController(),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Wednesday",
      isSelected: false,
      startTime: TextEditingController(),
      endTime: TextEditingController(),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Thursday",
      isSelected: false,
      startTime: TextEditingController(),
      endTime: TextEditingController(),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Friday",
      isSelected: false,
      startTime: TextEditingController(),
      endTime: TextEditingController(),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Saturday",
      isSelected: false,
      startTime: TextEditingController(),
      endTime: TextEditingController(),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Sunday",
      isSelected: false,
      startTime: TextEditingController(),
      endTime: TextEditingController(),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
  ];

  Future<BaseModel<BusinessProfileResponse>> callGetBusiness() async {
    BusinessProfileResponse response;
    try {
      businessLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callBusinessProfile();
      if (response.success == true) {
        userNameController.text = response.data!.name ?? "";
        webSiteController.text = response.data!.website ?? "";
        addressController.text = response.data!.address ?? "";
        cityController.text = response.data!.city ?? "";
        zipCodeController.text = response.data!.zipcode ?? "";
        stateController.text = response.data!.state ?? "";
        countryController.text = response.data!.country ?? "";
        descriptionController.text = response.data!.desc ?? "";
        image = response.data!.imagePath! + response.data!.image!;
        phoneNumberController.text = response.data!.phone!.toString();
        latitude = response.data!.latitude!;
        longitude = response.data!.longitude!;
        homeCharges = response.data!.homeCharges ?? "0";
        giveService = response.data!.giveService ?? "";
        gender = response.data!.gender!.toLowerCase() == "male"
            ? Gender.male
            : response.data!.gender!.toLowerCase() == "female"
                ? Gender.feMale
                : Gender.any;
        for (int i = 0; i < times.length; i++) {
          if (times[i].day == "Sunday") {
            if (response.data!.sunday!.open != null && response.data!.sunday!.close != null) {
              times[i].startTime.text = response.data!.sunday!.open != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.sunday!.open!
                      : DeviceUtils.timeFormat(response.data!.sunday!.open!)
                  : "";
              times[i].endTime.text = response.data!.sunday!.close != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.sunday!.close!
                      : DeviceUtils.timeFormat(response.data!.sunday!.close!)
                  : "";
              times[i].startTimeTime = response.data!.sunday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.sunday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.sunday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.sunday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Monday") {
            if (response.data!.monday!.open != null && response.data!.monday!.close != null) {
              times[i].startTime.text = response.data!.monday!.open != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.monday!.open!
                      : DeviceUtils.timeFormat(response.data!.monday!.open!)
                  : "";
              times[i].endTime.text = response.data!.monday!.close != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.monday!.close!
                      : DeviceUtils.timeFormat(response.data!.monday!.close!)
                  : "";
              times[i].startTimeTime = response.data!.monday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.monday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.monday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.monday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Tuesday") {
            if (response.data!.tuesday!.open != null && response.data!.tuesday!.close != null) {
              times[i].startTime.text = response.data!.tuesday!.open != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.tuesday!.open!
                      : DeviceUtils.timeFormat(response.data!.tuesday!.open!)
                  : "";
              times[i].endTime.text = response.data!.tuesday!.close != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.tuesday!.close!
                      : DeviceUtils.timeFormat(response.data!.tuesday!.close!)
                  : "";
              times[i].startTimeTime = response.data!.tuesday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.tuesday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.tuesday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.tuesday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Wednesday") {
            if (response.data!.wednesday!.open != null && response.data!.wednesday!.close != null) {
              times[i].startTime.text = response.data!.wednesday!.open != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.wednesday!.open!
                      : DeviceUtils.timeFormat(response.data!.wednesday!.open!)
                  : "";
              times[i].endTime.text = response.data!.wednesday!.close != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.wednesday!.close!
                      : DeviceUtils.timeFormat(response.data!.wednesday!.close!)
                  : "";
              times[i].startTimeTime = response.data!.wednesday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.wednesday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.wednesday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.wednesday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Thursday") {
            if (response.data!.thursday!.open != null && response.data!.thursday!.close != null) {
              times[i].startTime.text = response.data!.thursday!.open != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.thursday!.open!
                      : DeviceUtils.timeFormat(response.data!.thursday!.open!)
                  : "";
              times[i].endTime.text = response.data!.thursday!.close != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.thursday!.close!
                      : DeviceUtils.timeFormat(response.data!.thursday!.close!)
                  : "";
              times[i].startTimeTime = response.data!.thursday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.thursday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.thursday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.thursday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Friday") {
            if (response.data!.friday!.open != null && response.data!.friday!.close != null) {
              times[i].startTime.text = response.data!.friday!.open != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.friday!.open!
                      : DeviceUtils.timeFormat(response.data!.friday!.open!)
                  : "";
              times[i].endTime.text = response.data!.friday!.close != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.friday!.close!
                      : DeviceUtils.timeFormat(response.data!.friday!.close!)
                  : "";
              times[i].startTimeTime = response.data!.friday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.friday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.friday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.friday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Saturday") {
            if (response.data!.saturday!.open != null && response.data!.saturday!.close != null) {
              times[i].startTime.text = response.data!.saturday!.open != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.saturday!.open!
                      : DeviceUtils.timeFormat(response.data!.saturday!.open!)
                  : "";
              times[i].endTime.text = response.data!.saturday!.close != null
                  ? SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                      ? response.data!.saturday!.close!
                      : DeviceUtils.timeFormat(response.data!.saturday!.close!)
                  : "";
              times[i].startTimeTime = response.data!.saturday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.saturday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.saturday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.saturday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
        }
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      businessLoader = false;
      notifyListeners();
    } catch (error) {
      businessLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<BusinessProfileResponse>> callUpdateBusiness(Map<String, dynamic> body, BuildContext context) async {
    BusinessProfileResponse response;
    try {
      businessLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callUpdateBusiness(body);
      if (response.success == true) {
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
        Navigator.of(context).pop();
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      businessLoader = false;
      notifyListeners();
    } catch (error) {
      businessLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<BusinessProfileResponse>> callAddBusiness(Map<String, dynamic> body, BuildContext context) async {
    BusinessProfileResponse response;
    try {
      businessLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callAddBusiness(body);
      if (response.success == true) {
        SharedPreferenceHelper.setString(PreferencesNames.authToken, response.data!.token ?? "");
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DashBoardScreen(),
          ),
        );
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      businessLoader = false;
      notifyListeners();
    } catch (error) {
      businessLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  ///employee profile picture
  File? proImage;
  final picker = ImagePicker();
  String image = "";

  void chooseProfileImage(BuildContext context) {
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
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  ///business picture image
  File? businessProImage;
  final businessPicker = ImagePicker();
  String businessImage = "";

  void chooseBusinessImage(BuildContext context) {
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
                     getTranslated(context, LangConst.fromGallery).toString()
                    ),
                    onTap: () {
                      _businessProImgFromGallery(context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                   getTranslated(context, LangConst.fromCamera).toString(),
                  ),
                  onTap: () {
                    _businessProImgFromCamera(context);
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

  void _businessProImgFromGallery(BuildContext context) async {
    final pickedFile = await businessPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      businessProImage = File(pickedFile.path);
      List<int> imageBytes = businessProImage!.readAsBytesSync();
      businessImage = base64Encode(imageBytes);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  void _businessProImgFromCamera(BuildContext context) async {
    final pickedFile = await businessPicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      businessProImage = File(pickedFile.path);
      List<int> imageBytes = businessProImage!.readAsBytesSync();
      businessImage = base64Encode(imageBytes);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  ///business logo image
  File? lgoProImage;
  final logoPicker = ImagePicker();
  String logoImage = "";

  void chooseLogoImage(BuildContext context) {
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
                      _logoProImgFromGallery(context);
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                    getTranslated(context, LangConst.fromCamera).toString(),
                  ),
                  onTap: () {
                    _logoProImgFromCamera(context);
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

  void _logoProImgFromGallery(BuildContext context) async {
    final pickedFile = await logoPicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      lgoProImage = File(pickedFile.path);
      List<int> imageBytes = lgoProImage!.readAsBytesSync();
      logoImage = base64Encode(imageBytes);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }

  void _logoProImgFromCamera(BuildContext context) async {
    final pickedFile = await logoPicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      lgoProImage = File(pickedFile.path);
      List<int> imageBytes = lgoProImage!.readAsBytesSync();
      logoImage = base64Encode(imageBytes);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }
}
