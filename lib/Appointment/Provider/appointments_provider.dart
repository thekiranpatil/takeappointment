import 'package:multibusiness_business_app_flutter/Appointment/Model/add_appointment_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/booking_status_change_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/calendar_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/client_address_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/select_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/single_appointment_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/time_slots_response.dart';
import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Network/api_header.dart';
import 'package:multibusiness_business_app_flutter/Network/api_services.dart';
import 'package:multibusiness_business_app_flutter/Network/base_model.dart';
import 'package:multibusiness_business_app_flutter/Network/server_error.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:multibusiness_business_app_flutter/main.dart';

class AppointmentsProvider extends ChangeNotifier {
  List<AppointmentObject> pendingAppointments = [];
  List<AppointmentObject> approvedAppointments = [];
  Currency? currency;

  Future<BaseModel<HomeAllAppointmentsResponse>> callHomeAllAppointment() async {
    HomeAllAppointmentsResponse response;
    try {
      pendingAppointments.clear();
      approvedAppointments.clear();
      response = await ApiServices(ApiHeader().dioData()).callHomeAllAppointment();
      if (response.success == true) {
        currency = response.data!.currency!;
        pendingAppointments = response.data!.pendingAppointment!;
        approvedAppointments = response.data!.approvedAppointment!;
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

  bool singleAppointmentLoader = false;
  AppointmentObject? singleAppointment;
  String? dropDownValue;
  var items = [
    'Pending',
    'Approved',
    'Cancel',
    'Completed',
  ];

  Future<BaseModel<SingleAppointmentResponse>> callSingleAppointment(int id) async {
    SingleAppointmentResponse response;
    try {
      singleAppointmentLoader = true;
      notifyListeners();
      print("Appointment ID: ${id}");
      response = await ApiServices(ApiHeader().dioData()).callSingleAppointment(id);
      if (response.success == true) {
        singleAppointment = response.data!;
        dropDownValue = response.data!.bookingStatus!;
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      singleAppointmentLoader = false;
      notifyListeners();
    } catch (error) {
      singleAppointmentLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  List<AppointmentObject> calenderAppointments = [];

  Future<BaseModel<CalendarAppointmentsResponse>> callCalendarAppointment() async {
    CalendarAppointmentsResponse response;
    try {
      response = await ApiServices(ApiHeader().dioData()).callCalendarAppointments();
      if (response.success == true) {
        calenderAppointments = response.data!;
        notifyListeners();
      }
      else if(response.success==false)
        {
          if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
        }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  List<AppointmentObject> appointments = [];

  Future<BaseModel<CalendarAppointmentsResponse>> callAppointment() async {
    CalendarAppointmentsResponse response;
    try {
      singleAppointmentLoader = true;
      appointments.clear();
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callAppointments();
      if (response.success == true) {
        appointments = response.data!;
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      singleAppointmentLoader = false;
      notifyListeners();
    } catch (error) {
      singleAppointmentLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<BookingStatusChangeResponse>> callAppointmentStatusChange(Map<String, dynamic> body) async {
    BookingStatusChangeResponse response;
    try {
      singleAppointmentLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callUpdateAppointmentStatus(body);
      if (response.success == true) {
        if (response.message != null) DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
        singleAppointment = response.data!;
        dropDownValue = response.data!.bookingStatus!;
        notifyListeners();
      }
      else if(response.success==false){
        if(response.message!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.message!).toString());
      }
      singleAppointmentLoader = false;
      notifyListeners();
    } catch (error) {
      singleAppointmentLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  List<ClientAddressData> clientAddress = [];

  ClientAddressData? clientAdd;

  Future<BaseModel<ClientAddressResponse>> callClientAddress(int id) async {
    ClientAddressResponse response;
    try {
      clientAdd = null;
      clientAddress.clear();
      response = await ApiServices(ApiHeader().dioData()).callClientAddress(id);
      if (response.success == true) {
        clientAddress.addAll(response.data!);
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

  List<TimeSlotData> slots = [];

  TimeSlotData? slot;

  Future<BaseModel<TimeSlotsResponse>> callGetTimeSlots(Map<String, dynamic> body) async {
    TimeSlotsResponse response;
    try {
      slot = null;
      slots.clear();
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callTimeSlots(body);
      if (response.success == true) {
        slots.addAll(response.data!);
        notifyListeners();
      }
      else if(response.success==false){
        if(response.msg!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.msg!).toString());
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  List<EmployeeData> selectEmployees = [];
  EmployeeData? selectEmployee;

  Future<BaseModel<SelectEmployeeResponse>> callSelectEmployee(Map<String, dynamic> body) async {
    SelectEmployeeResponse response;
    try {
      selectEmployee = null;
      selectEmployees.clear();
      response = await ApiServices(ApiHeader().dioData()).callSelectEmployee(body);
      if (response.success == true) {
        selectEmployees.addAll(response.data!);
        notifyListeners();
      }
      else if(response.success==false){
        if(response.msg!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.msg!).toString());
      }
    } catch (error) {
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  Future<BaseModel<AddAppointmentResponse>> callAddAppointment(Map<String, dynamic> body, BuildContext context) async {
    AddAppointmentResponse response;
    try {
      singleAppointmentLoader = true;
      notifyListeners();
      response = await ApiServices(ApiHeader().dioData()).callAddAppointment(body);
      if (response.success == true) {
        calenderAppointments.add(response.data!);
        if (response.msg != null) DeviceUtils.toastMessage(getTranslated(context, response.msg!).toString());
        Navigator.of(context).pop();
        notifyListeners();
      }
      else if(response.success==false){
        if(response.msg!=null)DeviceUtils.toastMessage(getTranslated(NavigationService.navigatorKey.currentState!.context, response.msg!).toString());
      }
      singleAppointmentLoader = false;
      notifyListeners();
    } catch (error) {
      singleAppointmentLoader = false;
      notifyListeners();
      return BaseModel()..setException(ServerError.withError(error: error));
    }
    return BaseModel()..data = response;
  }

  List<ServiceName> selectedServices = [];
  double serviceTotal = 0.0;

  void ServicesHandle(ServiceName service) {
    bool exists = selectedServices.any((element) => element.serviceId == service.serviceId);
    if (exists == true) {
      int index = selectedServices.indexWhere((element) => element.serviceId == service.serviceId);
      selectedServices.removeAt(index);
      notifyListeners();
    } else {
      selectedServices.add(service);
      notifyListeners();
    }
    serviceTotal = 0.0;
    for (int i = 0; i < selectedServices.length; i++) {
      serviceTotal += selectedServices[i].price!;
    }
    notifyListeners();
  }
}
