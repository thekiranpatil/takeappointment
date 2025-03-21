import 'dart:convert';
import 'dart:io';
import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Home/Provider/employee_provider.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/input_label_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CreateEmployeeScreen extends StatefulWidget {
  final bool isEdit;
  final int? id;

  const CreateEmployeeScreen({super.key, required this.isEdit, this.id});

  @override
  State<CreateEmployeeScreen> createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  ///user name controller & focus node

  late FocusNode _userNameFocusNode;

  ///email controller & Focus node

  late FocusNode _emailFocusNode;

  ///Phone number Controller & Focus Node

  late FocusNode _phoneNumberFocusNode;

  late FocusNode _commissionPercentageFocusNode;

  ///password controller & Focus Node
  TextEditingController _passwordController = TextEditingController();
  late FocusNode _passwordFocusNode;

  late EmployeeProvider employeeProvider;
  bool _isObscureText = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    if (widget.isEdit == false) {
      for (int i = 0; i < employeeProvider.allServices.length; i++) {
        employeeProvider.allServices[i].isSelected = false;
      }
      for (int i = 0; i < employeeProvider.times.length; i++) {
        employeeProvider.times[i].endTime.text = "";
        employeeProvider.times[i].startTime.text = "";
      }
    }
    if (widget.isEdit == true) {
      Future.delayed(Duration.zero, () {
        employeeProvider.callShowEmployee(widget.id!);
      });
    }
    _userNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _commissionPercentageFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    employeeProvider.userNameController.text = "";

    _emailFocusNode.dispose();
    employeeProvider.emailController.text = "";

    _phoneNumberFocusNode.dispose();
    employeeProvider.phoneNumberController.text = "";

    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _commissionPercentageFocusNode.dispose();
    employeeProvider.commissionController.text = "0";
    super.dispose();
  }

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    employeeProvider = Provider.of<EmployeeProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: employeeProvider.employeeLoading,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.addEmployee).toString(),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(
            Amount.screenMargin,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ///profile image
                Align(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      employeeProvider.proImage != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(File(employeeProvider.proImage!.path)),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(
                                widget.isEdit == true && employeeProvider.image.isNotEmpty
                                    ? employeeProvider.image
                                    : "https://icons.iconarchive.com/icons/pelfusion/long-shadow-media/512/Camera-icon.png",
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            employeeProvider.chooseProfileImage(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.primarySwatch,
                            child: Icon(
                              Icons.edit,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///Name
                HeightBox(30),
                InputLabelWidget(
                  label: getTranslated(context, LangConst.nameLabel).toString(),
                ),
                TextFormField(
                  focusNode: _userNameFocusNode,
                  cursorColor: AppColors.primarySwatch,
                  controller: employeeProvider.userNameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, LangConst.pleaseEnterName).toString();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.userNameLabel).toString(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                HeightBox(16),

                ///email
                InputLabelWidget(
                  label: getTranslated(context, LangConst.emailLabel).toString(),
                ),
                TextFormField(
                  focusNode: _emailFocusNode,
                  cursorColor: AppColors.primarySwatch,
                  controller: employeeProvider.emailController,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: widget.isEdit == true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, LangConst.pleaseEnterEmail).toString();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.emailLabel).toString(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                HeightBox(16),

                ///mobile number
                InputLabelWidget(
                  label: getTranslated(context, LangConst.mobileNumber).toString(),
                ),
                Row(
                  children: [
                    Container(
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.neutral700,
                        ),
                        borderRadius: AppBorderRadius.k08,
                      ),
                      child: CountryCodePicker(
                        onChanged: (CountryCode countryCode) {
                          print(countryCode.dialCode);
                          setState(() {
                            employeeProvider.countryCodeController.text = countryCode.dialCode!;
                          });
                        },
                        initialSelection: employeeProvider.countryCodeController.text,
                        favorite: ['+91', 'IND'],
                        showCountryOnly: false,
                        showFlag: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      ),
                    ),
                    WidthBox(8),
                    Expanded(
                      child: TextFormField(
                        focusNode: _phoneNumberFocusNode,
                        cursorColor: AppColors.primarySwatch,
                        controller: employeeProvider.phoneNumberController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return getTranslated(context, LangConst.pleaseEnterMobileNumber).toString();
                          }
                          return null;
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")), // To prevent space
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9]+")), // To allow only numbers
                        ],
                        decoration: InputDecoration(
                          labelText: getTranslated(context, LangConst.phoneNumber).toString(),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                HeightBox(16),

                ///password
                InputLabelWidget(
                  label: getTranslated(context, LangConst.passwordLabel).toString(),
                ),
                TextFormField(
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  obscureText: _isObscureText,
                  cursorColor: AppColors.primarySwatch,
                  validator: (value) {
                    if (value!.isEmpty && widget.isEdit == false) {
                      return getTranslated(context, LangConst.pleaseEnterYourPassword).toString();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: widget.isEdit == false
                        ? getTranslated(context, LangConst.passwordLabel).toString()
                        : getTranslated(context, LangConst.passwordLabelForEdit).toString(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isObscureText = !_isObscureText;
                        });
                      },
                      child: Icon(
                        _isObscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.go,
                ),
                HeightBox(16),

                /// Commission (Percentage)
                InputLabelWidget(
                  label: getTranslated(context, LangConst.commissionLabel).toString(),
                ),
                TextFormField(
                  controller: employeeProvider.commissionController,
                  focusNode: _commissionPercentageFocusNode,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, LangConst.pleaseEnterCommission).toString();
                    }
                    if (double.parse(value) < 0.00 || double.parse(value) > 99.99) {
                      return getTranslated(context, LangConst.commissionPercentageRangeError).toString();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.commissionLabel).toString(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                HeightBox(16),

                ///service at
                Text(
                  getTranslated(context, LangConst.serviceAtLabel).toString(),
                  style: TypographySemibold.textThemeLight.bodyLarge,
                ),
                HeightBox(10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            employeeProvider.serviceAt = ServiceAt.home;
                          });
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: employeeProvider.serviceAt.name == ServiceAt.home.name
                                ? null
                                : Border.all(
                                    color: AppColors.neutral700,
                                  ),
                            borderRadius: AppBorderRadius.k04,
                            color: employeeProvider.serviceAt.name == ServiceAt.home.name
                                ? AppColors.primarySwatch
                                : AppColors.white,
                          ),
                          child: Center(
                            child: Text(
                              getTranslated(context, LangConst.homeLabel).toString(),
                              style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                                color: employeeProvider.serviceAt.name == ServiceAt.home.name
                                    ? AppColors.white
                                    : AppColors.gray50,
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
                            employeeProvider.serviceAt = ServiceAt.business;
                          });
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: employeeProvider.serviceAt.name == ServiceAt.business.name
                                ? null
                                : Border.all(
                                    color: AppColors.neutral700,
                                  ),
                            borderRadius: AppBorderRadius.k04,
                            color: employeeProvider.serviceAt.name == ServiceAt.business.name
                                ? AppColors.primarySwatch
                                : AppColors.white,
                          ),
                          child: Center(
                            child: Text(
                              getTranslated(context, LangConst.businessLabel).toString(),
                              style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                                color: employeeProvider.serviceAt.name == ServiceAt.business.name
                                    ? AppColors.white
                                    : AppColors.gray50,
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
                            employeeProvider.serviceAt = ServiceAt.both;
                          });
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: employeeProvider.serviceAt.name == ServiceAt.both.name
                                ? null
                                : Border.all(
                                    color: AppColors.neutral700,
                                  ),
                            borderRadius: AppBorderRadius.k04,
                            color: employeeProvider.serviceAt.name == ServiceAt.both.name
                                ? AppColors.primarySwatch
                                : AppColors.white,
                          ),
                          child: Center(
                            child: Text(
                              getTranslated(context, LangConst.bothLabel).toString(),
                              style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                                color: employeeProvider.serviceAt.name == ServiceAt.both.name
                                    ? AppColors.white
                                    : AppColors.gray50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                HeightBox(30),

                ///working days
                Text(
                  getTranslated(context, LangConst.workingDays).toString(),
                  style: TypographySemibold.textThemeLight.bodyLarge,
                ),
                ListView.builder(
                  itemCount: employeeProvider.times.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${getTranslated(context, employeeProvider.times[index].day.toLowerCase())}",
                              style: TypographySemibold.textThemeLight.titleSmall,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${getTranslated(context, LangConst.offDay)}",
                                  style: TypographySemibold.textThemeLight.titleSmall,
                                ),
                                Checkbox(
                                  value: employeeProvider.times[index].isSelected,
                                  onChanged: (value) {
                                    setState(() {
                                      employeeProvider.times[index].isSelected = value!;
                                      employeeProvider.times[index].startTime.text = "";
                                      employeeProvider.times[index].endTime.text = "";
                                    });
                                  },
                                  activeColor: AppColors.primarySwatch,
                                  fillColor: WidgetStateProperty.all(employeeProvider.times[index].isSelected
                                      ? AppColors.primarySwatch.shade500
                                      : AppColors.transparent),
                                  side: BorderSide(color: AppColors.gray50),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (!employeeProvider.times[index].isSelected)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      getTranslated(context, LangConst.openingTime).toString(),
                                      style: TypographyRegular.textThemeLight.bodyMedium,
                                    ),
                                    HeightBox(5),
                                    TextField(
                                      cursorColor: AppColors.primarySwatch,
                                      controller: employeeProvider.times[index].startTime,
                                      readOnly: employeeProvider.times[index].isSelected == true,
                                      onTap: employeeProvider.times[index].isSelected == true
                                          ? null
                                          : () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                initialTime: TimeOfDay.now(),
                                                context: context,
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context).copyWith(
                                                        alwaysUse24HourFormat: SharedPreferenceHelper.getBoolean(
                                                            PreferencesNames.timeFormat24)),
                                                    child: Theme(
                                                      data: ThemeData.light().copyWith(
                                                        colorScheme: ColorScheme.light(
                                                          // change the border color
                                                          primary: AppColors.primarySwatch,
                                                          // change the text color
                                                          onSurface: AppColors.primarySwatch,
                                                          surfaceTint: AppColors.white,
                                                        ),
                                                        // button colors
                                                        buttonTheme: ButtonThemeData(
                                                          colorScheme: ColorScheme.light(
                                                            primary: Colors.green,
                                                          ),
                                                        ),
                                                        timePickerTheme: TimePickerThemeData(
                                                            cancelButtonStyle: ButtonStyle(
                                                              textStyle: WidgetStateProperty.all(
                                                                TextStyle(
                                                                  color: AppColors.gray50,
                                                                ),
                                                              ),
                                                            ),
                                                            dayPeriodBorderSide: BorderSide(
                                                              color: AppColors.primarySwatch,
                                                            ),
                                                            dialBackgroundColor: AppColors.gray25.withAlpha(40)),
                                                      ),
                                                      child: child!,
                                                    ),
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                employeeProvider.times[index].startTimeTime = pickedTime;
                                                print(pickedTime.format(context)); //output 10:51 PM
                                                setState(() {
                                                  employeeProvider.times[index].startTime.text =
                                                      SharedPreferenceHelper.getBoolean(
                                                                  PreferencesNames.timeFormat24) ==
                                                              true
                                                          ? pickedTime.hour.toString() +
                                                              ":" +
                                                              pickedTime.minute.toString().toString()
                                                          : pickedTime.format(context); //set the value of text field.
                                                });
                                              } else {}
                                            },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              WidthBox(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      getTranslated(context, LangConst.closingTime).toString(),
                                      style: TypographyRegular.textThemeLight.bodyMedium,
                                    ),
                                    HeightBox(5),
                                    TextField(
                                      controller: employeeProvider.times[index].endTime,
                                      readOnly: employeeProvider.times[index].isSelected == true,
                                      cursorColor: AppColors.primarySwatch,
                                      onTap: employeeProvider.times[index].isSelected == true
                                          ? null
                                          : () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                initialTime: TimeOfDay.now(),
                                                context: context,
                                                builder: (context, child) {
                                                  return MediaQuery(
                                                    data: MediaQuery.of(context).copyWith(
                                                        alwaysUse24HourFormat: SharedPreferenceHelper.getBoolean(
                                                            PreferencesNames.timeFormat24)),
                                                    child: Theme(
                                                      data: ThemeData.light().copyWith(
                                                          colorScheme: ColorScheme.light(
                                                            // change the border color
                                                            primary: AppColors.primarySwatch,
                                                            // change the text color
                                                            onSurface: AppColors.primarySwatch,
                                                            surfaceTint: AppColors.white,
                                                          ),
                                                          // button colors
                                                          buttonTheme: ButtonThemeData(
                                                            colorScheme: ColorScheme.light(
                                                              primary: Colors.green,
                                                            ),
                                                          ),
                                                          timePickerTheme: TimePickerThemeData(
                                                              cancelButtonStyle: ButtonStyle(
                                                                textStyle: WidgetStateProperty.all(
                                                                  TextStyle(
                                                                    color: AppColors.gray50,
                                                                  ),
                                                                ),
                                                              ),
                                                              dayPeriodBorderSide: BorderSide(
                                                                color: AppColors.primarySwatch,
                                                              ),
                                                              dialBackgroundColor: AppColors.gray25.withAlpha(40))),
                                                      child: child!,
                                                    ),
                                                  );
                                                },
                                              );

                                              if (pickedTime != null) {
                                                employeeProvider.times[index].endTimeTime = pickedTime;
                                                print(pickedTime.format(context)); //output 10:51 PM
                                                setState(() {
                                                  employeeProvider.times[index].endTime.text =
                                                      SharedPreferenceHelper.getBoolean(
                                                                  PreferencesNames.timeFormat24) ==
                                                              true
                                                          ? pickedTime.hour.toString() +
                                                              ":" +
                                                              pickedTime.minute.toString().toString()
                                                          : pickedTime.format(context); //set the value of text field.
                                                });
                                              } else {}
                                            },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                      ],
                    );
                  },
                ),
                HeightBox(30),

                ///service
                Text(
                  getTranslated(context, LangConst.servicesLabel).toString(),
                  style: TypographySemibold.textThemeLight.bodyLarge,
                ),
                ListView.separated(
                  itemCount: employeeProvider.allServices.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    top: Amount.screenMargin,
                  ),
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => HeightBox(8),
                  itemBuilder: (context, index) {
                    ServiceName service = employeeProvider.allServices[index];
                    return Row(
                      children: [
                        ExtendedImage.network(
                          service.imagePath! + service.image!,
                          fit: BoxFit.cover,
                          borderRadius: AppBorderRadius.k04,
                          shape: BoxShape.rectangle,
                          height: 70,
                          width: 70,
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
                                  borderRadius: AppBorderRadius.k04,
                                  shape: BoxShape.rectangle,
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                );
                              case LoadState.failed:
                                return ClipRRect(
                                  borderRadius: AppBorderRadius.k04,
                                  child: Image.network(
                                    "https://picsum.photos/200/300",
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                );
                            }
                          },
                        ),
                        WidthBox(12),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "${service.name}",
                                  style: TypographySemibold.textThemeLight.titleMedium,
                                ),
                              ),
                              Checkbox(
                                value: service.isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    service.isSelected = value!;
                                  });
                                },
                                fillColor: WidgetStateProperty.all(
                                    service.isSelected ? AppColors.primarySwatch.shade500 : AppColors.transparent),
                                side: BorderSide(color: AppColors.gray50),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),

                HeightBox(30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isEdit == false) {
                        if (employeeProvider.image.isEmpty) {
                          DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseAddImage).toString());
                        } else {
                          List serviceId = [];
                          for (int i = 0; i < employeeProvider.allServices.length; i++) {
                            if (employeeProvider.allServices[i].isSelected == true) {
                              serviceId.add(employeeProvider.allServices[i].serviceId);
                            }
                          }
                          Map<String, dynamic> body = {
                            "name": employeeProvider.userNameController.text,
                            "email": employeeProvider.emailController.text,
                            "password": _passwordController.text,
                            "phone": employeeProvider.phoneNumberController.text,
                            "code": employeeProvider.countryCodeController.text,
                            "give_service": employeeProvider.serviceAt.name,
                            "service_id": jsonEncode(serviceId),
                            "image": employeeProvider.image,
                            "commission_percentage": employeeProvider.commissionController.text,
                          };
                          for (int t = 0; t < employeeProvider.times.length; t++) {
                            if (employeeProvider.times[t].day == "Sunday") {
                              body['sunopen'] = employeeProvider.times[t].startTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                      employeeProvider.times[t].startTimeTime.minute)
                                  : null;
                              body['sunclose'] = employeeProvider.times[t].endTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                      employeeProvider.times[t].endTimeTime.minute)
                                  : null;
                            }
                            if (employeeProvider.times[t].day == "Monday") {
                              body['monopen'] = employeeProvider.times[t].startTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                      employeeProvider.times[t].startTimeTime.minute)
                                  : null;
                              body['monclose'] = employeeProvider.times[t].endTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                      employeeProvider.times[t].endTimeTime.minute)
                                  : null;
                            }
                            if (employeeProvider.times[t].day == "Tuesday") {
                              body['tueopen'] = employeeProvider.times[t].startTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                      employeeProvider.times[t].startTimeTime.minute)
                                  : null;
                              body['tueclose'] = employeeProvider.times[t].endTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                      employeeProvider.times[t].endTimeTime.minute)
                                  : null;
                            }
                            if (employeeProvider.times[t].day == "Wednesday") {
                              body['wedopen'] = employeeProvider.times[t].startTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                      employeeProvider.times[t].startTimeTime.minute)
                                  : null;
                              body['wedclose'] = employeeProvider.times[t].endTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                      employeeProvider.times[t].endTimeTime.minute)
                                  : null;
                            }
                            if (employeeProvider.times[t].day == "Thursday") {
                              body['thuopen'] = employeeProvider.times[t].startTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                      employeeProvider.times[t].startTimeTime.minute)
                                  : null;
                              body['thuclose'] = employeeProvider.times[t].endTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                      employeeProvider.times[t].endTimeTime.minute)
                                  : null;
                            }
                            if (employeeProvider.times[t].day == "Friday") {
                              body['friopen'] = employeeProvider.times[t].startTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                      employeeProvider.times[t].startTimeTime.minute)
                                  : null;
                              body['friclose'] = employeeProvider.times[t].endTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                      employeeProvider.times[t].endTimeTime.minute)
                                  : null;
                            }
                            if (employeeProvider.times[t].day == "Saturday") {
                              body['satopen'] = employeeProvider.times[t].startTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                      employeeProvider.times[t].startTimeTime.minute)
                                  : null;
                              body['satclose'] = employeeProvider.times[t].endTime.text.isNotEmpty
                                  ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                      employeeProvider.times[t].endTimeTime.minute)
                                  : null;
                            }
                          }
                          print(body);
                          employeeProvider.callCreateEmployee(body, context);
                        }
                      } else {
                        List serviceId = [];
                        for (int i = 0; i < employeeProvider.allServices.length; i++) {
                          if (employeeProvider.allServices[i].isSelected == true) {
                            serviceId.add(employeeProvider.allServices[i].serviceId);
                          }
                        }
                        Map<String, dynamic> body = {
                          "name": employeeProvider.userNameController.text,
                          "email": employeeProvider.emailController.text,
                          if (_passwordController.text.isNotEmpty) "password": _passwordController.text,
                          "phone": employeeProvider.phoneNumberController.text,
                          "give_service": employeeProvider.serviceAt.name,
                          "service_id": jsonEncode(serviceId),
                          "emp_id": widget.id,
                          "status": 1,
                          "commission_percentage": employeeProvider.commissionController.text,
                        };
                        for (int t = 0; t < employeeProvider.times.length; t++) {
                          if (employeeProvider.times[t].day == "Sunday") {
                            body['sunopen'] = employeeProvider.times[t].startTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                    employeeProvider.times[t].startTimeTime.minute)
                                : null;
                            body['sunclose'] = employeeProvider.times[t].endTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                    employeeProvider.times[t].endTimeTime.minute)
                                : null;
                          }
                          if (employeeProvider.times[t].day == "Monday") {
                            body['monopen'] = employeeProvider.times[t].startTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                    employeeProvider.times[t].startTimeTime.minute)
                                : null;
                            body['monclose'] = employeeProvider.times[t].endTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                    employeeProvider.times[t].endTimeTime.minute)
                                : null;
                          }
                          if (employeeProvider.times[t].day == "Tuesday") {
                            body['tueopen'] = employeeProvider.times[t].startTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                    employeeProvider.times[t].startTimeTime.minute)
                                : null;
                            body['tueclose'] = employeeProvider.times[t].endTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                    employeeProvider.times[t].endTimeTime.minute)
                                : null;
                          }
                          if (employeeProvider.times[t].day == "Wednesday") {
                            body['wedopen'] = employeeProvider.times[t].startTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                    employeeProvider.times[t].startTimeTime.minute)
                                : null;
                            body['wedclose'] = employeeProvider.times[t].endTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                    employeeProvider.times[t].endTimeTime.minute)
                                : null;
                          }
                          if (employeeProvider.times[t].day == "Thursday") {
                            body['thuopen'] = employeeProvider.times[t].startTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                    employeeProvider.times[t].startTimeTime.minute)
                                : null;
                            body['thuclose'] = employeeProvider.times[t].endTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                    employeeProvider.times[t].endTimeTime.minute)
                                : null;
                          }
                          if (employeeProvider.times[t].day == "Friday") {
                            body['friopen'] = employeeProvider.times[t].startTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                    employeeProvider.times[t].startTimeTime.minute)
                                : null;
                            body['friclose'] = employeeProvider.times[t].endTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                    employeeProvider.times[t].endTimeTime.minute)
                                : null;
                          }
                          if (employeeProvider.times[t].day == "Saturday") {
                            body['satopen'] = employeeProvider.times[t].startTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].startTimeTime.hour,
                                    employeeProvider.times[t].startTimeTime.minute)
                                : null;
                            body['satclose'] = employeeProvider.times[t].endTime.text.isNotEmpty &&
                                    employeeProvider.times[t].isSelected == false
                                ? DeviceUtils.timeOfDayTo24HourString(employeeProvider.times[t].endTimeTime.hour,
                                    employeeProvider.times[t].endTimeTime.minute)
                                : null;
                          }
                        }
                        if (employeeProvider.proImage != null) {
                          body['image'] = employeeProvider.image;
                        }
                        print(body);
                        employeeProvider.callUpdateEmployee(body, context);
                      }
                    }
                  },
                  child: Text(
                    getTranslated(context, LangConst.saveLabel).toString(),
                  ),
                  style: AppButtonStyle.filledLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum ServiceAt { home, business, both }
