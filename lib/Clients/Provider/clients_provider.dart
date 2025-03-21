import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Clients/Model/add_client_response.dart';
import 'package:multibusiness_business_app_flutter/Clients/Model/client_profile_response.dart';
import 'package:multibusiness_business_app_flutter/Clients/Model/clients_response.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class ClientsProvider extends ChangeNotifier {
  bool clientsLoader = false;
  List<UserDetails> clients = [];
  List<UserDetails> _filteredClients = [];

  List<UserDetails> get filteredClients => _filteredClients.isNotEmpty ? _filteredClients : clients;

  void filterClients(String searchQuery) {
    _filteredClients = clients.where((client) {
      return client.name!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          client.email!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          client.phone!.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  Future<BaseModel<ClientsResponse>> callGetClients() async {
    ClientsResponse response;
    try {
      clientsLoader = true;
      clients.clear();
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callGetClients();
      if (response.success == true) {
        _filteredClients = [];
        clients = response.data!;
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      clientsLoader = false;
      notifyListeners();
    } catch (error) {
      clientsLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  ClientProfileResponse? clientProfile;

  Future<BaseModel<ClientProfileResponse>> callClientProfile(int id) async {
    ClientProfileResponse response;
    try {
      clientsLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callClientProfile(id);
      if (response.success == true) {
        clientProfile = response;
        notifyListeners();
      }
      clientsLoader = false;
      notifyListeners();
    } catch (error) {
      clientsLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<AddClientResponse>> callAddClient(Map<String, dynamic> body, BuildContext context) async {
    AddClientResponse response;
    try {
      clientsLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callAddClient(body);
      if (response.success == true) {
        clients.add(response.data!);
        notifyListeners();
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(context, response.message!).toString());
        Navigator.of(context).pop();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      clientsLoader = false;
      notifyListeners();
    } catch (error) {
      clientsLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }
}
