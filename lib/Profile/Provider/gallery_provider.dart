import 'dart:convert';
import 'dart:io';

import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/add_gallery_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/gallery_response.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class GalleryProvider extends ChangeNotifier {
  bool galleryLoader = false;
  List<GalleryData> galleryList = [];

  Future<BaseModel<GalleryResponse>> callGallery() async {
    GalleryResponse response;
    try {
      galleryLoader = true;
      notifyListeners();
      galleryList.clear();
      response = await ApiServices(ApiHeader().dioData()).callGallery();
      if (response.success == true) {
        galleryList = response.data!;
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      galleryLoader = false;
      notifyListeners();
    } catch (error) {
      galleryLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<AddGalleryResponse>> callAddGallery(Map<String, dynamic> body) async {
    AddGalleryResponse response;
    try {
      galleryLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callAddGallery(body);
      if (response.success == true) {
        galleryList.insert(0, response.data!);
        image = "";
        proImage = null;
        notifyListeners();
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      galleryLoader = false;
      notifyListeners();
    } catch (error) {
      galleryLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<AddGalleryResponse>> callDeleteGallery(int id, int index) async {
    AddGalleryResponse response;
    try {
      galleryLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callDeleteGallery(id);
      if (response.success == true) {
        galleryList.removeAt(index);
        notifyListeners();
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      galleryLoader = false;
      notifyListeners();
    } catch (error) {
      galleryLoader = false;
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
      Map<String, dynamic> body = {
        // "image": "data:image/jpg;base64,"+image,
        "image": image,
      };
      callAddGallery(body);
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
      Map<String, dynamic> body = {
        "image": image,
      };
      callAddGallery(body);
    } else {
      print('No image selected.');
    }
    notifyListeners();
  }
}
