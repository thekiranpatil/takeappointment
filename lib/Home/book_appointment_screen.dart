import 'dart:convert';
import 'package:multibusiness_business_app_flutter/Appointment/Model/client_address_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/time_slots_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Provider/appointments_provider.dart';
import 'package:multibusiness_business_app_flutter/Clients/Provider/clients_provider.dart';
import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Home/appointment_details_screen.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/services_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/create_employee_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/service_provider.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/input_label_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  UserDetails? clients;
  ServiceAt serviceAt = ServiceAt.home;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _extraCharges = TextEditingController();
  late FocusNode _extraFocusNode;
  late FocusNode _dateFocusNode;

  late ClientsProvider clientsProvider;
  late ServiceProvider serviceProvider;
  late AppointmentsProvider appointmentsProvider;

  @override
  void initState() {
    super.initState();
    clientsProvider = Provider.of<ClientsProvider>(context, listen: false);
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    appointmentsProvider = Provider.of<AppointmentsProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      appointmentsProvider.selectedServices.clear();
      appointmentsProvider.serviceTotal = 0;
      clientsProvider.callGetClients();
      serviceProvider.callGetServices();
    });
    _dateFocusNode = FocusNode();
    _extraFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _extraCharges.dispose();

    _dateFocusNode.dispose();
    _extraFocusNode.dispose();
    super.dispose();
  }

  int catIndex = 0;

  @override
  Widget build(BuildContext context) {
    clientsProvider = Provider.of<ClientsProvider>(context);
    serviceProvider = Provider.of<ServiceProvider>(context);
    appointmentsProvider = Provider.of<AppointmentsProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: appointmentsProvider.singleAppointmentLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.bookAppointmentLabel).toString(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///client
              Padding(
                padding: const EdgeInsets.only(
                  left: Amount.screenMargin,
                  top: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                child: InputLabelWidget(
                  label: getTranslated(context, LangConst.clientLabel).toString(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.white,
                    buttonTheme: ButtonTheme.of(context).copyWith(
                      alignedDropdown: true,
                    ),
                  ),
                  child: DropdownButtonFormField(
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.gray50,
                        size: 20,
                      ),
                      decoration: InputDecoration(
                        labelText: getTranslated(context, LangConst.selectClient).toString(),
                      ),
                      value: clients,
                      items: clientsProvider.clients.map<DropdownMenuItem<UserDetails>>((value) {
                        return DropdownMenuItem<UserDetails>(
                          value: value,
                          child: Text(
                            value.name!,
                            style: TypographyMedium.textThemeLight.bodyLarge,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          clients = value;
                          appointmentsProvider.callClientAddress(clients!.id!.toInt());
                        });
                      }),
                ),
              ),
              HeightBox(16),

              ///select service
              Padding(
                padding: const EdgeInsets.only(
                  left: Amount.screenMargin,
                  right: Amount.screenMargin,
                ),
                child: Text(
                  getTranslated(context, LangConst.selectServices).toString(),
                    style: Theme.of(context).brightness == Brightness.light
                        ? TypographySemibold.textThemeLight.titleMedium
                        : TypographySemibold.textThemeDark.titleMedium
                ),
              ),
              SizedBox(
                height: 50,
                child: ListView.separated(
                  itemCount: serviceProvider.servicesCategoryList.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                    left: Amount.screenMargin,
                    right: Amount.screenMargin,
                    top: 10,
                  ),
                  separatorBuilder: (context, index) => WidthBox(12),
                  itemBuilder: (context, index) {
                    CategoryData data = serviceProvider.servicesCategoryList[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          catIndex = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: AppBorderRadius.k04,
                          color: catIndex == index ? AppColors.primarySwatch : AppColors.transparent,
                          border: Border.all(
                            color: AppColors.neutral700,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "${data.name}",
                            style: TypographyMedium.textThemeLight.titleMedium!.copyWith(
                              color: catIndex == index ? AppColors.white : AppColors.gray50,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              serviceProvider.servicesCategoryList.isEmpty
                  ? SizedBox(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : servicesWidget(serviceProvider.servicesCategoryList[catIndex].service!),
              Padding(
                padding: const EdgeInsets.all(
                  Amount.screenMargin,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslated(context, LangConst.totalLabel).toString(),
                            style: Theme.of(context).brightness == Brightness.light
                                ? TypographySemibold.textThemeLight.bodyLarge
                                : TypographySemibold.textThemeDark.bodyLarge),
                        Text(
                          "${SharedPreferenceHelper.getString(PreferencesNames.currencySymbol)}${appointmentsProvider.serviceTotal}",
                          style: TypographySemibold.textThemeLight.bodyLarge!.copyWith(
                            color: AppColors.primarySwatch,
                          ),
                        ),
                      ],
                    ),
                    HeightBox(16),

                    ///book at
                    Text(
                      getTranslated(context, LangConst.bookAtLabel).toString(),
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.titleMedium
                            : TypographySemibold.textThemeDark.titleMedium
                    ),
                    HeightBox(10),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                serviceAt = ServiceAt.home;
                              });
                            },
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: serviceAt.name == ServiceAt.home.name
                                    ? null
                                    : Border.all(
                                        color: AppColors.neutral700,
                                      ),
                                borderRadius: AppBorderRadius.k04,
                                color: serviceAt.name == ServiceAt.home.name ? AppColors.primarySwatch : AppColors.white,
                              ),
                              child: Center(
                                child: Text(
                                  getTranslated(context, LangConst.homeLabel).toString(),
                                  style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                                    color: serviceAt.name == ServiceAt.home.name ? AppColors.white : AppColors.gray50,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        WidthBox(16),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                serviceAt = ServiceAt.business;
                              });
                            },
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                border: serviceAt.name == ServiceAt.business.name
                                    ? null
                                    : Border.all(
                                        color: AppColors.neutral700,
                                      ),
                                borderRadius: AppBorderRadius.k04,
                                color: serviceAt.name == ServiceAt.business.name
                                    ? AppColors.primarySwatch
                                    : AppColors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  getTranslated(context, LangConst.businessLabel).toString(),
                                  style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                                    color: serviceAt.name == ServiceAt.business.name ? AppColors.white : AppColors.gray50,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    HeightBox(16),

                    Visibility(
                      visible: serviceAt.name == "home",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///address
                          InputLabelWidget(
                            label: getTranslated(context, LangConst.addressLabel).toString(),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.white,
                              buttonTheme: ButtonTheme.of(context).copyWith(
                                alignedDropdown: true,
                              ),
                            ),
                            child: DropdownButtonFormField(
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColors.gray50,
                                  size: 20,
                                ),
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: getTranslated(context, LangConst.addressLabel).toString(),
                                ),
                                value: appointmentsProvider.clientAdd,
                                items: appointmentsProvider.clientAddress.map<DropdownMenuItem<ClientAddressData>>((value) {
                                  return DropdownMenuItem<ClientAddressData>(
                                    value: value,
                                    child: Text(
                                      value.street! + value.city! + value.state! + value.country!,
                                      style: TypographyMedium.textThemeLight.bodyLarge,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    appointmentsProvider.clientAdd = value;
                                  });
                                }),
                          ),
                          HeightBox(16),

                          ///Extra Charges
                          InputLabelWidget(
                            label: getTranslated(context, LangConst.extraCharges).toString(),
                          ),
                          TextFormField(
                            focusNode: _extraFocusNode,
                            controller: _extraCharges,
                            cursorColor: AppColors.primarySwatch,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return getTranslated(context, LangConst.pleaseEnterExtraCharges).toString();
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: getTranslated(context, LangConst.extraCharges).toString(),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          HeightBox(15),
                        ],
                      ),
                    ),

                    ///date
                    InputLabelWidget(
                      label: getTranslated(context, LangConst.dateLabel).toString(),
                    ),
                    TextFormField(
                      focusNode: _dateFocusNode,
                      controller: _dateController,
                      cursorColor: AppColors.primarySwatch,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: AppColors.primarySwatch, // header background color
                                  surfaceTint: AppColors.white,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primarySwatch, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            _dateController.text = formattedDate;
                          });
                          Map<String, dynamic> body = {
                            "date": formattedDate,
                          };
                          appointmentsProvider.callGetTimeSlots(body);
                        } else {}
                      },
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return getTranslated(context,LangConst.pleaseSelectDate).toString();
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: getTranslated(context, LangConst.dateLabel).toString(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    HeightBox(15),

                    ///time
                    InputLabelWidget(
                      label: getTranslated(context, LangConst.timeLabel).toString(),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                        buttonTheme: ButtonTheme.of(context).copyWith(
                          alignedDropdown: true,
                        ),
                      ),
                      child: DropdownButtonFormField(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.gray50,
                            size: 20,
                          ),
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: getTranslated(context, LangConst.selectTime).toString(),
                          ),
                          value: appointmentsProvider.slot,
                          items: appointmentsProvider.slots.map<DropdownMenuItem<TimeSlotData>>((value) {
                            return DropdownMenuItem<TimeSlotData>(
                              value: value,
                              child: Text(
                                SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)
                                    ? DeviceUtils.convertTo24HourFormat(value.startTime!)
                                    : value.startTime!,
                                style: TypographyMedium.textThemeLight.bodyLarge,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (appointmentsProvider.selectedServices.isEmpty) {
                                DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseSelectServices).toString());
                              } else {
                                appointmentsProvider.slot = value;
                                List selectServices = [];
                                for (int i = 0; i < appointmentsProvider.selectedServices.length; i++) {
                                  selectServices.add(appointmentsProvider.selectedServices[i].serviceId.toString());
                                }
                                Map<String, dynamic> body = {
                                  "start_time": appointmentsProvider.slot!.startTime,
                                  "service": jsonEncode(selectServices),
                                  "date": _dateController.text,
                                  "booking_at": serviceAt.name == "home" ? "Home" : "Business",
                                };
                                print(body);
                                appointmentsProvider.callSelectEmployee(body);
                              }
                            });
                          }),
                    ),
                    HeightBox(15),

                    ///employee
                    InputLabelWidget(
                      label: getTranslated(context, LangConst.employeeLabel).toString(),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white,
                        buttonTheme: ButtonTheme.of(context).copyWith(
                          alignedDropdown: true,
                        ),
                      ),
                      child: DropdownButtonFormField(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: AppColors.gray50,
                            size: 20,
                          ),
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: getTranslated(context, LangConst.selectEmployee).toString(),
                          ),
                          value: appointmentsProvider.selectEmployee,
                          items: appointmentsProvider.selectEmployees.map<DropdownMenuItem<EmployeeData>>((value) {
                            return DropdownMenuItem<EmployeeData>(
                              value: value,
                              child: Text(
                                value.name!,
                                style: TypographyMedium.textThemeLight.bodyLarge,
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              appointmentsProvider.selectEmployee = value;
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            bottom: Amount.screenMargin,
            left: Amount.screenMargin,
            right: Amount.screenMargin,
          ),
          child: ElevatedButton(
            onPressed: () async {
              if (clients == null) {
                DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseSelectClients).toString());
              } else if (appointmentsProvider.selectedServices.isEmpty) {
                DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseSelectClients).toString());
              } else if (serviceAt.name == "home" && appointmentsProvider.clientAdd == null) {
                DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseSelectAddress).toString());
              } else if (serviceAt.name == "home" && _extraCharges.text.isEmpty) {
                DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseEnterExtraCharges).toString());
              } else if (_dateController.text.isEmpty) {
                DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseSelectDate).toString());
              } else if (appointmentsProvider.slot == null) {
                DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseSelectTime).toString());
              } else if (appointmentsProvider.selectEmployee == null) {
                DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseSelectEmployee).toString());
              } else {
                List selectServices = [];
                for (int i = 0; i < appointmentsProvider.selectedServices.length; i++) {
                  selectServices.add(appointmentsProvider.selectedServices[i].serviceId.toString());
                }
                Map<String, dynamic> body = {
                  "user_id": clients!.id,
                  "start_time": appointmentsProvider.slot!.startTime,
                  "service_id": jsonEncode(selectServices),
                  "date": _dateController.text,
                  "payment": appointmentsProvider.serviceTotal,
                  "booking_at": serviceAt.name == "home" ? "Home" : "Business",
                  "emp_id": appointmentsProvider.selectEmployee!.empId,
                };
                if (serviceAt.name == "home" && appointmentsProvider.clientAdd != null) {
                  body['address_id'] = appointmentsProvider.clientAdd!.addressId;
                  body['extra_charges'] = _extraCharges.text;
                }
                print(body);
                await appointmentsProvider.callAddAppointment(body, context).then((value) {
                  if (value.data?.success == true && value.data!.data != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AppointmentDetailsScreen(
                          id: value.data!.data!.id!.toInt(),
                        ),
                      ),
                    );
                  }
                });

              }
            },
            child: Text(
              getTranslated(context, LangConst.bookNow).toString(),
            ),
            style: AppButtonStyle.filledLarge,
          ),
        ),
      ),
    );
  }

  Widget servicesWidget(List<ServiceName> services) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: services.length,
      padding: EdgeInsets.only(
        left: Amount.screenMargin,
        right: Amount.screenMargin,
      ),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        ServiceName service = services[index];
        return CheckboxListTile(
          value: services[index].isSelected,
          onChanged: (value) {
            setState(() {
              services[index].isSelected = value!;
            });
            appointmentsProvider.ServicesHandle(services[index]);
          },
          contentPadding: EdgeInsets.zero,
          title: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    ExtendedImage.network(
                      service.imagePath! + service.image!,
                      fit: BoxFit.cover,
                      borderRadius: AppBorderRadius.k04,
                      shape: BoxShape.rectangle,
                      width: 30,
                      height: 30,
                      loadStateChanged: (ExtendedImageState state) {
                        switch (state.extendedImageLoadState) {
                          case LoadState.loading:
                            return SpinKitThreeBounce(
                              color: AppColors.primarySwatch,
                              size: 20.0,
                            );
                          case LoadState.completed:
                            return ExtendedImage.network(
                              service.imagePath! + service.image!,
                              fit: BoxFit.cover,
                              borderRadius: AppBorderRadius.k04,
                              shape: BoxShape.rectangle,
                              width: 30,
                              height: 30,
                            );
                          case LoadState.failed:
                            return ClipRRect(
                              borderRadius: AppBorderRadius.k04,
                              child: Image.network(
                                "https://picsum.photos/200/300",
                                fit: BoxFit.cover,
                                height: 30,
                                width: 30,
                              ),
                            );
                        }
                      },
                    ),
                    WidthBox(12),
                    Expanded(child:Text(
                      "${service.name}",
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographyRegular.textThemeLight.titleMedium
                            : TypographyRegular.textThemeDark.titleMedium,
                    
                      maxLines: 2,
                    ),),

                  ],
                ),
              ),
              WidthBox(12),
              Text(
                "${SharedPreferenceHelper.getString(PreferencesNames.currencySymbol)}${service.price}",
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographyRegular.textThemeLight.bodyLarge
                      : TypographyRegular.textThemeDark.bodyLarge

              ),
            ],
          ),
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
    );
  }
}
