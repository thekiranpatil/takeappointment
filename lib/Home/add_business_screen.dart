import 'dart:io';

import 'package:multibusiness_business_app_flutter/Authentication/sign_in_screen.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/create_employee_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/edit_business_profile_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/business_provider.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/input_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocode/geocode.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  ///user name controller & focus node
  TextEditingController _userNameController = TextEditingController();
  late FocusNode _userNameFocusNode;

  ///description controller & focus node
  TextEditingController _descriptionController = TextEditingController();
  late FocusNode _descriptionFocusNode;

  ///Phone number Controller & Focus Node
  TextEditingController _phoneNumberController = TextEditingController();
  late FocusNode _phoneNumberFocusNode;

  ///website Controller & Focus Node
  TextEditingController _webSiteController = TextEditingController();
  late FocusNode _webSiteFocusNode;

  ///Address Controller & Focus Node
  TextEditingController _addressController = TextEditingController();
  late FocusNode _addressFocusNode;
  TextEditingController _homeChargesController = TextEditingController();

  Gender gender = Gender.male;
  List<TimingModel> times = [
    TimingModel(
      day: "Monday",
      isSelected: false,
      startTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "08:00" : "8:00 AM"),
      endTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "20:00" : "8:00 PM"),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Tuesday",
      isSelected: false,
      startTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "08:00" : "8:00 AM"),
      endTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "20:00" : "8:00 PM"),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Wednesday",
      isSelected: false,
      startTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "08:00" : "8:00 AM"),
      endTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "20:00" : "8:00 PM"),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Thursday",
      isSelected: false,
      startTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "08:00" : "8:00 AM"),
      endTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "20:00" : "8:00 PM"),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Friday",
      isSelected: false,
      startTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "08:00" : "8:00 AM"),
      endTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "20:00" : "8:00 PM"),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Saturday",
      isSelected: false,
      startTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "08:00" : "8:00 AM"),
      endTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "20:00" : "8:00 PM"),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
    TimingModel(
      day: "Sunday",
      isSelected: false,
      startTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "08:00" : "8:00 AM"),
      endTime: TextEditingController(
          text: SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ? "20:00" : "8:00 PM"),
      endTimeTime: TimeOfDay.now(),
      startTimeTime: TimeOfDay.now(),
    ),
  ];

  final _formKey = GlobalKey<FormState>();
  late BusinessProvider businessProvider;

  @override
  void initState() {
    super.initState();
    businessProvider = Provider.of<BusinessProvider>(context, listen: false);
    _userNameFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
    _webSiteFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    _userNameController.dispose();
    _webSiteController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    _homeChargesController.dispose();

    _phoneNumberFocusNode.dispose();
    _phoneNumberController.dispose();
    _webSiteFocusNode.dispose();
    _addressFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  ServiceAt serviceAt = ServiceAt.home;

  @override
  Widget build(BuildContext context) {
    businessProvider = Provider.of<BusinessProvider>(
      context,
    );
    return PopScope(
      canPop: false,
      child: ModalProgressHUD(
        inAsyncCall: businessProvider.businessLoader,
        progressIndicator: SpinKitThreeBounce(
          color: AppColors.primarySwatch,
          size: 50.0,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              getTranslated(context, LangConst.addBusiness).toString(),
            ),
            actions: [
              IconButton(
                tooltip: getTranslated(context, LangConst.logout).toString(),
                onPressed: () {
                  SharedPreferenceHelper.remove(PreferencesNames.authToken);
                  SharedPreferenceHelper.remove(PreferencesNames.isLogin);
                  SharedPreferenceHelper.remove(PreferencesNames.email);
                  SharedPreferenceHelper.remove(PreferencesNames.userName);
                  SharedPreferenceHelper.remove(PreferencesNames.phoneNo);
                  SharedPreferenceHelper.remove(PreferencesNames.imageUrl);
                  SharedPreferenceHelper.remove(PreferencesNames.phoneCode);
                  SharedPreferenceHelper.remove(PreferencesNames.totalPoints);
                  SharedPreferenceHelper.remove(PreferencesNames.remainPoints);
                  SharedPreferenceHelper.remove(PreferencesNames.userId);
                  SharedPreferenceHelper.remove(PreferencesNames.currencySymbol);
                  SharedPreferenceHelper.remove(PreferencesNames.onesignalPushToken);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                    (route) => false,
                  );
                },
                icon: Icon(
                  Icons.logout,
                  color: AppColors.danger500,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(
              Amount.screenMargin,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///profile image & business Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          businessProvider.businessProImage != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(File(businessProvider.businessProImage!.path)),
                                )
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                    "https://cdn-icons-png.flaticon.com/512/3178/3178179.png",
                                  ),
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                businessProvider.chooseBusinessImage(context);
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
                      Stack(
                        children: [
                          businessProvider.lgoProImage != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(File(businessProvider.lgoProImage!.path)),
                                )
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                    "https://cdn-icons-png.flaticon.com/512/3178/3178179.png",
                                  ),
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                businessProvider.chooseLogoImage(context);
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
                    ],
                  ),
                  HeightBox(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        getTranslated(context, LangConst.businessImage).toString(),
                        style: TypographyMedium.textThemeLight.titleMedium,
                      ),
                      Text(
                        getTranslated(context, LangConst.businessLogo).toString(),
                        style: TypographyMedium.textThemeLight.titleMedium,
                      ),
                    ],
                  ),
                  HeightBox(30),

                  Text(
                    getTranslated(context, LangConst.businessDetails).toString(),
                    style: TypographySemibold.textThemeLight.titleMedium,
                  ),

                  ///salon Name
                  HeightBox(30),
                  InputLabelWidget(
                    label: getTranslated(context, LangConst.businessName).toString(),
                  ),
                  TextFormField(
                    focusNode: _userNameFocusNode,
                    controller: _userNameController,
                    keyboardType: TextInputType.name,
                    cursorColor: AppColors.primarySwatch,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, LangConst.pleaseEnterBusinessName).toString();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: getTranslated(context, LangConst.businessName).toString(),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  HeightBox(16),

                  ///Description
                  InputLabelWidget(
                    label: getTranslated(context, LangConst.descriptionLabel).toString(),
                  ),
                  TextFormField(
                    focusNode: _descriptionFocusNode,
                    controller: _descriptionController,
                    keyboardType: TextInputType.name,
                    cursorColor: AppColors.primarySwatch,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, LangConst.pleaseEnterDescription).toString();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: getTranslated(context, LangConst.descriptionLabel).toString(),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  HeightBox(16),

                  ///mobile number
                  InputLabelWidget(
                    label: getTranslated(context, LangConst.mobileNumber).toString(),
                  ),
                  TextFormField(
                    focusNode: _phoneNumberFocusNode,
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.phone,
                    cursorColor: AppColors.primarySwatch,
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
                  HeightBox(16),

                  ///website
                  InputLabelWidget(
                    label: getTranslated(context, LangConst.websiteLabel).toString(),
                  ),
                  TextFormField(
                    focusNode: _webSiteFocusNode,
                    controller: _webSiteController,
                    keyboardType: TextInputType.url,
                    cursorColor: AppColors.primarySwatch,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, LangConst.pleaseEnterWebsite).toString();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: getTranslated(context, LangConst.websiteLabel).toString(),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  HeightBox(16),

                  ///address
                  InputLabelWidget(
                    label: getTranslated(context, LangConst.addressLabel).toString(),
                  ),
                  TextFormField(
                    focusNode: _addressFocusNode,
                    controller: _addressController,
                    keyboardType: TextInputType.text,
                    cursorColor: AppColors.primarySwatch,
                    readOnly: true,
                    onTap: () async {
                      String kGoogleApiKey = SharedPreferenceHelper.getString(PreferencesNames.mapKey);

                      Prediction? p = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: kGoogleApiKey,
                          mode: Mode.overlay,
                          // Mode.fullscreen
                          language: "US",
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none));
                      _getLatLng(p!, context);
                    },
                    maxLines: 4,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, LangConst.pleaseEnterAddress).toString();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: getTranslated(context, LangConst.addressLabel).toString(),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  HeightBox(16),

                  ///Timing
                  Text(
                    getTranslated(context, LangConst.timingsLabel).toString(),
                    style: TypographySemibold.textThemeLight.titleLarge,
                  ),
                  ListView.builder(
                    itemCount: times.length,
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
                                "${getTranslated(context, times[index].day.toLowerCase())}",
                                style: TypographySemibold.textThemeLight.titleSmall,
                              ),
                              Checkbox(
                                value: times[index].isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    times[index].isSelected = value!;
                                    times[index].startTime.text = "";
                                    times[index].endTime.text = "";
                                  });
                                },
                                fillColor: WidgetStateProperty.all(
                                    times[index].isSelected ? AppColors.primarySwatch.shade500 : AppColors.transparent),
                                side: BorderSide(color: AppColors.gray50),
                              ),
                            ],
                          ),
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
                                      controller: times[index].startTime,
                                      cursorColor: AppColors.primarySwatch,
                                      readOnly: times[index].isSelected == true,
                                      onTap: times[index].isSelected == true
                                          ? null
                                          : () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                initialTime: TimeOfDay.now(),
                                                context: context,
                                                builder: (BuildContext context, Widget? child) {
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
                                                      ));
                                                },
                                              );

                                              if (pickedTime != null) {
                                                times[index].startTimeTime = pickedTime;
                                                print(pickedTime.format(context)); //output 10:51 PM
                                                setState(() {
                                                  times[index].startTime.text = SharedPreferenceHelper.getBoolean(
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
                                      controller: times[index].endTime,
                                      readOnly: times[index].isSelected == true,
                                      cursorColor: AppColors.primarySwatch,
                                      onTap: times[index].isSelected == true
                                          ? null
                                          : () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                initialTime: TimeOfDay.now(),
                                                context: context,
                                                builder: (BuildContext context, Widget? child) {
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
                                                      ));
                                                },
                                              );

                                              if (pickedTime != null) {
                                                times[index].endTimeTime = pickedTime;
                                                print(pickedTime.format(context)); //output 10:51 PM
                                                setState(() {
                                                  times[index].endTime.text =
                                                      pickedTime.format(context); //set the value of text field.
                                                  times[index].endTime.text = SharedPreferenceHelper.getBoolean(
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
                          ),
                        ],
                      );
                    },
                  ),
                  HeightBox(16),

                  ///Gender
                  Text(
                    getTranslated(context, LangConst.genderAllowed).toString(),
                    style: TypographySemibold.textThemeLight.titleLarge,
                  ),
                  HeightBox(6),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile(
                          value: Gender.male,
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          title: Text(
                            getTranslated(context, LangConst.maleLabel).toString(),
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          groupValue: gender,
                          onChanged: (Gender? value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          title: Text(
                            getTranslated(context, LangConst.femaleLabel).toString(),
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          onChanged: (Gender? value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                          value: Gender.feMale,
                          groupValue: gender,
                        ),
                      ),
                      Expanded(
                        child: RadioListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity(
                            horizontal: -4,
                            vertical: -4,
                          ),
                          title: Text(
                            getTranslated(context, LangConst.anyLabel).toString(),
                            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          onChanged: (Gender? value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                          value: Gender.any,
                          groupValue: gender,
                        ),
                      ),
                    ],
                  ),
                  HeightBox(16),

                  ///service at
                  Text(
                    getTranslated(context, LangConst.serviceAtLabel).toString(),
                    style: TypographySemibold.textThemeLight.titleLarge,
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
                              color:
                                  serviceAt.name == ServiceAt.business.name ? AppColors.primarySwatch : AppColors.white,
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
                      WidthBox(16),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              serviceAt = ServiceAt.both;
                            });
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              border: serviceAt.name == ServiceAt.both.name
                                  ? null
                                  : Border.all(
                                      color: AppColors.neutral700,
                                    ),
                              borderRadius: AppBorderRadius.k04,
                              color: serviceAt.name == ServiceAt.both.name ? AppColors.primarySwatch : AppColors.white,
                            ),
                            child: Center(
                              child: Text(
                                getTranslated(context, LangConst.bothLabel).toString(),
                                style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                                  color: serviceAt.name == ServiceAt.both.name ? AppColors.white : AppColors.gray50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  HeightBox(16),

                  ///home charges
                  Visibility(
                    visible: serviceAt.name != "business",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputLabelWidget(
                          label: getTranslated(context, LangConst.homeChargesLabel).toString(),
                        ),
                        TextFormField(
                          controller: _homeChargesController,
                          keyboardType: TextInputType.number,
                          cursorColor: AppColors.primarySwatch,
                          decoration: InputDecoration(
                            labelText: getTranslated(context, LangConst.homeChargesLabel).toString(),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        HeightBox(30),
                      ],
                    ),
                  ),

                  ///Save
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (businessProvider.businessProImage == null) {
                                DeviceUtils.toastMessage(
                                    getTranslated(context, LangConst.pleaseSelectBusinessImage).toString());
                              } else if (businessProvider.lgoProImage == null) {
                                DeviceUtils.toastMessage(
                                    getTranslated(context, LangConst.pleaseSelectBusinessLogo).toString());
                              } else if (_homeChargesController.text.isEmpty && serviceAt.name != "business") {
                                DeviceUtils.toastMessage(
                                    getTranslated(context, LangConst.pleaseEnterAddHomeCharges).toString());
                              } else {
                                Map<String, dynamic> body = {
                                  "name": _userNameController.text.trim(),
                                  "desc": _descriptionController.text.trim(),
                                  "gender": Gender.male == gender
                                      ? "Male"
                                      : Gender.feMale == gender
                                          ? "feMale"
                                          : "Both",
                                  "phone": _phoneNumberController.text.trim(),
                                  "address": _addressController.text.trim(),
                                  "city": city,
                                  "state": state,
                                  "country": country,
                                  "zipcode": zipcode,
                                  "latitude": lat,
                                  "longitude": long,
                                  "website": _webSiteController.text.trim(),
                                  "owner_id": SharedPreferenceHelper.getString(PreferencesNames.userId),
                                  "give_service": serviceAt.name == "home"
                                      ? "Home"
                                      : serviceAt.name == "business"
                                          ? "Business"
                                          : "Both",
                                };
                                if (_homeChargesController.text.isNotEmpty && serviceAt.name != "business") {
                                  body['home_charges'] = _homeChargesController.text;
                                }
                                for (int t = 0; t < times.length; t++) {
                                  if (times[t].day == "Sunday") {
                                    body['sunopen'] = times[t].startTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].startTimeTime.hour, times[t].startTimeTime.minute)
                                        : null;
                                    body['sunclose'] = times[t].endTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].endTimeTime.hour, times[t].endTimeTime.minute)
                                        : null;
                                  }
                                  if (times[t].day == "Monday") {
                                    body['monopen'] = times[t].startTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].startTimeTime.hour, times[t].startTimeTime.minute)
                                        : null;
                                    body['monclose'] = times[t].endTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].endTimeTime.hour, times[t].endTimeTime.minute)
                                        : null;
                                  }
                                  if (times[t].day == "Tuesday") {
                                    body['tueopen'] = times[t].startTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].startTimeTime.hour, times[t].startTimeTime.minute)
                                        : null;
                                    body['tueclose'] = times[t].endTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].endTimeTime.hour, times[t].endTimeTime.minute)
                                        : null;
                                  }
                                  if (times[t].day == "Wednesday") {
                                    body['wedopen'] = times[t].startTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].startTimeTime.hour, times[t].startTimeTime.minute)
                                        : null;
                                    body['wedclose'] = times[t].endTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].endTimeTime.hour, times[t].endTimeTime.minute)
                                        : null;
                                  }
                                  if (times[t].day == "Thursday") {
                                    body['thuopen'] = times[t].startTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].startTimeTime.hour, times[t].startTimeTime.minute)
                                        : null;
                                    body['thuclose'] = times[t].endTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].endTimeTime.hour, times[t].endTimeTime.minute)
                                        : null;
                                  }
                                  if (times[t].day == "Friday") {
                                    body['friopen'] = times[t].startTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].startTimeTime.hour, times[t].startTimeTime.minute)
                                        : null;
                                    body['friclose'] = times[t].endTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].endTimeTime.hour, times[t].endTimeTime.minute)
                                        : null;
                                  }
                                  if (times[t].day == "Saturday") {
                                    body['satopen'] = times[t].startTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].startTimeTime.hour, times[t].startTimeTime.minute)
                                        : null;
                                    body['satclose'] = times[t].endTime.text.isNotEmpty && times[t].isSelected == false
                                        ? DeviceUtils.timeOfDayTo24HourString(
                                            times[t].endTimeTime.hour, times[t].endTimeTime.minute)
                                        : null;
                                  }
                                }
                                body['image'] = businessProvider.businessImage;
                                body['logo'] = businessProvider.logoImage;
                                print(body);
                                businessProvider.callAddBusiness(body, context);
                              }
                            }
                          },
                          child: Text(
                            getTranslated(context, LangConst.saveLabel).toString(),
                          ),
                          style: AppButtonStyle.filledLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String city = "";
  String state = "";
  String country = "";
  String zipcode = "";
  double lat = 0.0;
  double long = 0.0;

  void _getLatLng(Prediction prediction, BuildContext context) async {
    GoogleMapsPlaces _places = new GoogleMapsPlaces(apiKey: SharedPreferenceHelper.getString(PreferencesNames.mapKey));
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(prediction.placeId!);
    double latitude = detail.result.geometry!.location.lat;
    double longitude = detail.result.geometry!.location.lng;
    lat = detail.result.geometry!.location.lat;
    long = detail.result.geometry!.location.lng;
    GeoCode geoCode = GeoCode();
    Address addressData = await geoCode.reverseGeocoding(latitude: latitude, longitude: longitude);
    print(addressData.streetAddress);
    print(addressData.city);
    print(addressData.region);
    print(addressData.countryName);
    print(addressData.postal);
    city = addressData.city!;
    state = addressData.region!;
    country = addressData.countryName!;
    zipcode = addressData.postal!;
    _addressController.text =
        "${addressData.streetAddress}, ${addressData.city}, ${addressData.region}, ${addressData.countryName}";
  }
}
