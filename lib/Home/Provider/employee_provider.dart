import 'dart:convert';
import 'dart:io';

import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Home/Model/create_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/all_services_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/create_employee_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/edit_business_profile_screen.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class EmployeeProvider extends ChangeNotifier {
  List<EmployeeData> employees = [];
  bool employeeLoading = false;

  ///all Employee
  Future<BaseModel<AllEmployeeResponse>> callGetEmployee() async {
    AllEmployeeResponse response;
    try {
      employeeLoading = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetEmployee();
      if (response.success == true) {
        employees = response.data!;
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      employeeLoading = false;
      notifyListeners();
    } catch (error) {
      employeeLoading = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  ///all Services
  List<ServiceName> allServices = [];

  Future<BaseModel<AllServicesResponse>> callGetAllService() async {
    AllServicesResponse response;
    try {
      allServices.clear();
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetAllServices();
      if (response.success == true) {
        allServices = response.data!;
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  ///create Employee
  Future<BaseModel<CreateEmployeeResponse>> callCreateEmployee(Map<String, dynamic> body, BuildContext context) async {
    CreateEmployeeResponse response;
    try {
      employeeLoading = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callCreateEmployee(body);
      if (response.success == true) {
        employees.add(response.data!);
        proImage = null;
        image = "";
        notifyListeners();
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
        Navigator.of(context).pop();
      }
      else if(response.success==false){
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
      }
      employeeLoading = false;
      notifyListeners();
    } catch (error) {
      employeeLoading = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  ///delete Employee
  Future<BaseModel<CreateEmployeeResponse>> callDeleteEmployee(int id, int index) async {
    CreateEmployeeResponse response;
    try {
      employeeLoading = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callDeleteEmployee(id);
      if (response.success == true) {
        employees.removeAt(index);
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
        notifyListeners();
      }
      else if(response.success==false){
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      employeeLoading = false;
      notifyListeners();
    } catch (error) {
      employeeLoading = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  ///show Single Employee
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController commissionController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  ServiceAt serviceAt = ServiceAt.home;
  List<TimingModel> times = [
    TimingModel(
      day: "Sunday",
      isSelected: false,
      startTime: TextEditingController(),
      endTime: TextEditingController(),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
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
  ];

  Future<BaseModel<CreateEmployeeResponse>> callShowEmployee(int id) async {
    CreateEmployeeResponse response;
    try {
      employeeLoading = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callShowEmployee(id);
      if (response.success == true) {
        userNameController.text = response.data!.name ?? "";
        emailController.text = response.data!.email ?? "";
        phoneNumberController.text = response.data!.phone.toString();
        commissionController.text = response.data!.commissionPercentage.toString();
        image = response.data!.imagePath! + response.data!.image!;
        serviceAt = response.data!.giveService!.toLowerCase() == "home"
            ? ServiceAt.home
            : response.data!.giveService!.toLowerCase() == "business" || response.data!.giveService!.toLowerCase() == "salon"
                ? ServiceAt.business
                : ServiceAt.both;
        for (int i = 0; i < allServices.length; i++) {
          for (int j = 0; j < response.data!.services!.length; j++) {
            if (response.data!.services![j].serviceId == allServices[i].serviceId) {
              allServices[i].isSelected = true;
            }
          }
        }

        for (int i = 0; i < times.length; i++) {
          if (times[i].day == "Sunday") {
            if (response.data!.sunday!.open != null && response.data!.sunday!.close != null) {
              times[i].startTime.text = response.data!.sunday!.open != null ? DeviceUtils.timeFormat(response.data!.sunday!.open!) : "";
              times[i].endTime.text = response.data!.sunday!.close != null ? DeviceUtils.timeFormat(response.data!.sunday!.close!) : "";
              times[i].startTimeTime = response.data!.sunday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.sunday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.sunday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.sunday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Monday") {
            if (response.data!.monday!.open != null && response.data!.monday!.close != null) {
              times[i].startTime.text = response.data!.monday!.open != null ? DeviceUtils.timeFormat(response.data!.monday!.open!) : "";
              times[i].endTime.text = response.data!.monday!.close != null ? DeviceUtils.timeFormat(response.data!.monday!.close!) : "";
              times[i].startTimeTime = response.data!.monday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.monday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.monday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.monday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Tuesday") {
            if (response.data!.tuesday!.open != null && response.data!.tuesday!.close != null) {
              times[i].startTime.text = response.data!.tuesday!.open != null ? DeviceUtils.timeFormat(response.data!.tuesday!.open!) : "";
              times[i].endTime.text = response.data!.tuesday!.close != null ? DeviceUtils.timeFormat(response.data!.tuesday!.close!) : "";
              times[i].startTimeTime = response.data!.tuesday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.tuesday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.tuesday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.tuesday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Wednesday") {
            if (response.data!.wednesday!.open != null && response.data!.wednesday!.close != null) {
              times[i].startTime.text = response.data!.wednesday!.open != null ? DeviceUtils.timeFormat(response.data!.wednesday!.open!) : "";
              times[i].endTime.text = response.data!.wednesday!.close != null ? DeviceUtils.timeFormat(response.data!.wednesday!.close!) : "";
              times[i].startTimeTime = response.data!.wednesday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.wednesday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.wednesday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.wednesday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Thursday") {
            if (response.data!.thursday!.open != null && response.data!.thursday!.close != null) {
              times[i].startTime.text = response.data!.thursday!.open != null ? DeviceUtils.timeFormat(response.data!.thursday!.open!) : "";
              times[i].endTime.text = response.data!.thursday!.close != null ? DeviceUtils.timeFormat(response.data!.thursday!.close!) : "";
              times[i].startTimeTime = response.data!.thursday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.thursday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.thursday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.thursday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Friday") {
            if (response.data!.friday!.open != null && response.data!.friday!.close != null) {
              times[i].startTime.text = response.data!.friday!.open != null ? DeviceUtils.timeFormat(response.data!.friday!.open!) : "";
              times[i].endTime.text = response.data!.friday!.close != null ? DeviceUtils.timeFormat(response.data!.friday!.close!) : "";
              times[i].startTimeTime = response.data!.friday!.open != null ? DeviceUtils.convertTimeOfDay(response.data!.friday!.open!) : TimeOfDay.now();
              times[i].endTimeTime = response.data!.friday!.close != null ? DeviceUtils.convertTimeOfDay(response.data!.friday!.close!) : TimeOfDay.now();
            } else {
              times[i].isSelected = true;
            }
          }
          if (times[i].day == "Saturday") {
            if (response.data!.saturday!.open != null && response.data!.saturday!.close != null) {
              times[i].startTime.text = response.data!.saturday!.open != null ? DeviceUtils.timeFormat(response.data!.saturday!.open!) : "";
              times[i].endTime.text = response.data!.saturday!.close != null ? DeviceUtils.timeFormat(response.data!.saturday!.close!) : "";
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
      employeeLoading = false;
      notifyListeners();
    } catch (error) {
      employeeLoading = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  ///update Employee
  Future<BaseModel<CreateEmployeeResponse>> callUpdateEmployee(Map<String, dynamic> body, BuildContext context) async {
    CreateEmployeeResponse response;
    try {
      employeeLoading = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callUpdateEmployee(body);
      if (response.success == true && response.data != null) {
        int index = employees.indexWhere((element) => element.empId == response.data!.empId);
        if (index != -1) {
          employees[index] = response.data!;
        }
        proImage = null;
        image = "";
        notifyListeners();
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
        Navigator.of(context).pop();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      employeeLoading = false;
      notifyListeners();
    } catch (error) {
      employeeLoading = false;
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
                    title:  Text(
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
}
