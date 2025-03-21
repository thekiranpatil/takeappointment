import 'package:multibusiness_business_app_flutter/Appointment/Model/add_appointment_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/booking_status_change_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/calendar_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/client_address_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/select_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/single_appointment_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/time_slots_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/app_setting_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/check_otp_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/expire_date_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/forgot_password_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/login_response.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Model/register_response.dart';
import 'package:multibusiness_business_app_flutter/Clients/Model/add_client_response.dart';
import 'package:multibusiness_business_app_flutter/Clients/Model/client_profile_response.dart';
import 'package:multibusiness_business_app_flutter/Clients/Model/clients_response.dart';
import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Home/Model/create_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Home/Model/notification_response.dart';
import 'package:multibusiness_business_app_flutter/Network/apis.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/add_gallery_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/add_service_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/all_services_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/business_profile_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/categories_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/change_password_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/gallery_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/profile_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/review_report_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/reviews_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/services_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/single_service_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/statistics_response.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: Apis.baseUrl)
abstract class ApiServices {
  factory ApiServices(Dio dio, {String? baseUrl}) = _ApiServices;

  @POST(Apis.login)
  Future<LoginResponse> callLogin(@Body() Map<String, dynamic> body);

  @GET(Apis.employees)
  Future<AllEmployeeResponse> callGetEmployee();

  @GET(Apis.allAppointments)
  Future<HomeAllAppointmentsResponse> callHomeAllAppointment();

  @GET(Apis.showSingleAppointment)
  Future<SingleAppointmentResponse> callSingleAppointment(@Path() int id);

  @GET(Apis.calAppointments)
  Future<CalendarAppointmentsResponse> callCalendarAppointments();

  @GET(Apis.appointments)
  Future<CalendarAppointmentsResponse> callAppointments();

  @GET(Apis.clients)
  Future<ClientsResponse> callGetClients();

  @GET(Apis.showClient)
  Future<ClientProfileResponse> callClientProfile(@Path() int id);

  @POST(Apis.addClient)
  Future<AddClientResponse> callAddClient(@Body() Map<String, dynamic> body);

  @GET(Apis.showProfile)
  Future<ProfileResponse> callGetProfile();

  @POST(Apis.profileNotification)
  Future<ProfileResponse> callProfileNotificationUpdate(@Body() Map<String, dynamic> body);

  @POST(Apis.profileMail)
  Future<ProfileResponse> callProfileEmailUpdate(@Body() Map<String, dynamic> body);

  @GET(Apis.dashboard)
  Future<StatisticsResponse> callStatistic();

  @GET(Apis.review)
  Future<ReviewsResponse> callGetReview();

  @POST(Apis.reviewReport)
  Future<ReviewReportResponse> callReviewReport(@Body() Map<String, dynamic> body);

  @POST(Apis.changePassword)
  Future<ChangePasswordResponse> callChangePassword(@Body() Map<String, dynamic> body);

  @POST(Apis.editProfile)
  Future<ProfileResponse> callUpdateProfile(@Body() Map<String, dynamic> body);

  @GET(Apis.gallery)
  Future<GalleryResponse> callGallery();

  @POST(Apis.addGallery)
  Future<AddGalleryResponse> callAddGallery(@Body() Map<String, dynamic> body);

  @GET(Apis.deleteGallery)
  Future<AddGalleryResponse> callDeleteGallery(@Path() int id);

  @GET(Apis.services)
  Future<ServicesResponse> callGetServices();

  @POST(Apis.addService)
  Future<AddServiceResponse> callAddService(@Body() Map<String, dynamic> body);

  @GET(Apis.categories)
  Future<CategoriesResponse> callGetCategories();

  @GET(Apis.showSingleService)
  Future<SingleServiceResponse> callGetSingleService(@Path() int id);

  @POST(Apis.editService)
  Future<AddServiceResponse> callEditService(@Body() Map<String, dynamic> body);

  @GET(Apis.deleteService)
  Future<SingleServiceResponse> callDeleteService(@Path() int id);

  @GET(Apis.appNotification)
  Future<NotificationResponse> callGetNotification();

  @POST(Apis.addEmp)
  Future<CreateEmployeeResponse> callCreateEmployee(@Body() Map<String, dynamic> body);

  @GET(Apis.allServices)
  Future<AllServicesResponse> callGetAllServices();

  @GET(Apis.deleteEmployee)
  Future<CreateEmployeeResponse> callDeleteEmployee(@Path() int id);

  @GET(Apis.showEmployee)
  Future<CreateEmployeeResponse> callShowEmployee(@Path() int id);

  @POST(Apis.editEmployee)
  Future<CreateEmployeeResponse> callUpdateEmployee(@Body() Map<String, dynamic> body);

  @GET(Apis.showBusiness)
  Future<BusinessProfileResponse> callBusinessProfile();

  @POST(Apis.editBusiness)
  Future<BusinessProfileResponse> callUpdateBusiness(@Body() Map<String, dynamic> body);

  @POST(Apis.register)
  Future<RegisterResponse> callRegister(@Body() Map<String, dynamic> body);

  @POST(Apis.forgetpassword)
  Future<ForgotPasswordResponse> callForgotPassword(@Body() Map<String, dynamic> body);

  @POST(Apis.addBusiness)
  Future<BusinessProfileResponse> callAddBusiness(@Body() Map<String, dynamic> body);

  @POST(Apis.changeStatus)
  Future<BookingStatusChangeResponse> callUpdateAppointmentStatus(@Body() Map<String, dynamic> body);

  @GET(Apis.appSetting)
  Future<AppSettingResponse> callGetSetting();

  @GET(Apis.clientAddress)
  Future<ClientAddressResponse> callClientAddress(@Path() int id);

  @POST(Apis.timeslot)
  Future<TimeSlotsResponse> callTimeSlots(@Body() Map<String, dynamic> body);

  @POST(Apis.selectEmp)
  Future<SelectEmployeeResponse> callSelectEmployee(@Body() Map<String, dynamic> body);

  @POST(Apis.addAppointment)
  Future<AddAppointmentResponse> callAddAppointment(@Body() Map<String, dynamic> body);

  @GET(Apis.expireDate)
  Future<ExpireDateResponse> callExpiredDate();

  @POST(Apis.checkOtp)
  Future<CheckOtpResponse> callCheckOtp(@Body() Map<String, dynamic> body);

  @POST(Apis.resendOtp)
  Future<LoginResponse> callResendOtp(@Body() Map<String, dynamic> body);
}
