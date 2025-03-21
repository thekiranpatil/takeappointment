class Apis {
  /// TODO Setup: Enter your base url here, Make sure you have added a "/" at the end of the URL, Do not remove api/admin/ from the URL
  /// Make sure wether you are using http or https
  /// Make sure wether you need /public/ in the base URL or not
  /// After changing here, also change in the [api_service.g.dart] file
  /// if that file doesn't exist, run the following command in the project terminal
  /// flutter pub run build_runner build --delete-conflicting-outputs
  static const String baseUrl = "https://takeappointment.in/api/admin/";

  static const String login = "login";
  static const String employees = "employees";
  static const String allAppointments = "allAppointments";
  static const String showSingleAppointment = "showAppointment/{id}";
  static const String calAppointments = "CalAppointments";
  static const String appointments = "appointments";
  static const String clients = "clients";
  static const String showClient = "showClient/{id}";
  static const String addClient = "addClient";
  static const String showProfile = "showProfile";
  static const String profileNotification = "notification";
  static const String profileMail = "mail";
  static const String dashboard = "dashboard";
  static const String review = "review";
  static const String reviewReport = "reviewReport";
  static const String changePassword = "changePassword";
  static const String editProfile = "editProfile";
  static const String gallery = "gallery";
  static const String addGallery = "addGallery";
  static const String deleteGallery = "deleteGallery/{id}";
  static const String services = "services";
  static const String addService = "addService";
  static const String categories = "categories";
  static const String showSingleService = "showService/{id}";
  static const String editService = "editService";
  static const String deleteService = "deleteService/{id}";
  static const String appNotification = "appNotification";
  static const String addEmp = "addEmp";
  static const String allServices = "allServices";
  static const String deleteEmployee = "deleteEmployee/{id}";
  static const String showEmployee = "showEmployee/{id}";
  static const String editEmployee = "editEmployee";
  static const String showBusiness = "showBusiness";
  static const String editBusiness = "editBusiness";
  static const String register = "register";
  static const String forgetpassword = "forgetpassword";
  static const String addBusiness = "addBusiness";
  static const String changeStatus = "changeStatus";
  static const String appSetting = "appSetting";
  static const String clientAddress = "clientAddress/{id}";
  static const String timeslot = "timeslot";
  static const String selectEmp = "selectEmp";
  static const String addAppointment = "addAppointment";
  static const String expireDate="expireDate";
  static const String checkOtp = "checkotp";
  static const String resendOtp = "resendotp";
}
