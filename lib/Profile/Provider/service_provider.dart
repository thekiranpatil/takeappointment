import 'dart:convert';
import 'dart:io';

import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/add_service_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/categories_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/services_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/single_service_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/create_service_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/edit_business_profile_screen.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class ServiceProvider extends ChangeNotifier {
  bool servicesLoader = false;
  List<CategoryData> servicesCategoryList = [];

  Future<BaseModel<ServicesResponse>> callGetServices() async {
    ServicesResponse response;
    try {
      servicesLoader = true;
      servicesCategoryList.clear();
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetServices();
      if (response.success == true) {
        servicesCategoryList.addAll(response.data!.category!);
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      servicesLoader = false;
      notifyListeners();
    } catch (error) {
      servicesLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  List<CategoryData> categories = [];

  Future<BaseModel<CategoriesResponse>> callCategories() async {
    CategoriesResponse response;
    try {
      categories.clear();
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetCategories();
      if (response.success == true) {
        categories.addAll(response.data!);
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

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  CategoryData? category;

  Future<BaseModel<AddServiceResponse>> callCreateServices(Map<String, dynamic> body, BuildContext context) async {
    AddServiceResponse response;
    try {
      servicesLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callAddService(body);
      if (response.success == true) {
        for (int i = 0; i < servicesCategoryList.length; i++) {
          if (servicesCategoryList[i].catId == response.data!.catId) {
            servicesCategoryList[i].service!.add(response.data!);
            notifyListeners();
          }
        }
        image = "";
        proImage = null;
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
        Navigator.of(context).pop();
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      servicesLoader = false;
      notifyListeners();
    } catch (error) {
      servicesLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Gender gender = Gender.male;
  Status status = Status.active;

  Future<BaseModel<SingleServiceResponse>> callGetSingleService(int id) async {
    SingleServiceResponse response;
    try {
      servicesLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetSingleService(id);
      if (response.success == true) {
        nameController.text = response.data!.name!;
        priceController.text = response.data!.price!.toString();
        durationController.text = response.data!.time.toString();
        status = response.data!.status == 1 ? Status.active : Status.deactivate;
        for (int i = 0; i < categories.length; i++) {
          if (response.data!.categoryData!.catId == categories[i].catId) {
            category = categories[i];
          }
        }
        image = response.data!.imagePath! + response.data!.image!;
        gender = response.data!.gender!.toLowerCase() == "male"
            ? Gender.male
            : response.data!.gender!.toLowerCase() == "female"
                ? Gender.feMale
                : Gender.any;
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      servicesLoader = false;
      notifyListeners();
    } catch (error) {
      servicesLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<AddServiceResponse>> callEditServices(Map<String, dynamic> body, BuildContext context) async {
    AddServiceResponse response;
    try {
      servicesLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callEditService(body);
      if (response.success == true) {
        for (int i = 0; i < servicesCategoryList.length; i++) {
          for (int j = 0; j < servicesCategoryList[i].service!.length; j++) {
            if (servicesCategoryList[i].service![j].serviceId == response.data!.serviceId) {
              servicesCategoryList[i].service![j] = response.data!;
              notifyListeners();
            }
          }
        }
        image = "";
        proImage = null;
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
        Navigator.of(context).pop();
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      servicesLoader = false;
      notifyListeners();
    } catch (error) {
      servicesLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<SingleServiceResponse>> callDeleteService(int index, int id) async {
    SingleServiceResponse response;
    try {
      servicesLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callDeleteService(id);
      if (response.success == true) {
        for (int i = 0; i < servicesCategoryList.length; i++) {
          if (servicesCategoryList[i].catId == response.data!.catId) {
            servicesCategoryList[i].service!.removeAt(index);
            notifyListeners();
          }
        }
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      servicesLoader = false;
      notifyListeners();
    } catch (error) {
      servicesLoader = false;
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
                      _proImgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                    getTranslated(context, LangConst.fromCamera).toString(),
                  ),
                  onTap: () {
                    _proImgFromCamera();
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

  void _proImgFromGallery() async {
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

  void _proImgFromCamera() async {
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
