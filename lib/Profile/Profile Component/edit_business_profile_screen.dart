import 'dart:io';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/business_provider.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EditBusinessProfileScreen extends StatefulWidget {
  const EditBusinessProfileScreen({super.key});

  @override
  State<EditBusinessProfileScreen> createState() => _EditBusinessProfileScreenState();
}

class _EditBusinessProfileScreenState extends State<EditBusinessProfileScreen> {
  ///user name  focus node
  late FocusNode _userNameFocusNode;

  ///Phone number  Focus Node
  late FocusNode _phoneNumberFocusNode;

  ///website Focus Node
  late FocusNode _webSiteFocusNode;

  ///Address Focus Node
  late FocusNode _addressFocusNode;

  ///City Focus Node
  late FocusNode _cityFocusNode;

  ///Zip Code Focus Node
  late FocusNode _zipCodeFocusNode;

  ///state Focus Node
  late FocusNode _stateFocusNode;

  ///County Focus
  late FocusNode _countryFocusNode;

  late BusinessProvider businessProvider;

  @override
  void initState() {
    super.initState();
    businessProvider = Provider.of<BusinessProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      businessProvider.callGetBusiness();
    });
    _userNameFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
    _webSiteFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _cityFocusNode = FocusNode();
    _zipCodeFocusNode = FocusNode();
    _stateFocusNode = FocusNode();
    _countryFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    businessProvider.userNameController.text = "";
    businessProvider.webSiteController.text = "";
    businessProvider.addressController.text = "";
    businessProvider.cityController.text = "";
    businessProvider.zipCodeController.text = "";
    businessProvider.stateController.text = "";
    businessProvider.countryController.text = "";

    _phoneNumberFocusNode.dispose();
    _webSiteFocusNode.dispose();
    _addressFocusNode.dispose();
    _cityFocusNode.dispose();
    _zipCodeFocusNode.dispose();
    _stateFocusNode.dispose();
    _countryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    businessProvider = Provider.of<BusinessProvider>(
      context,
    );
    return ModalProgressHUD(
      inAsyncCall: businessProvider.businessLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.editBusinessProfile).toString(),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(
            Amount.screenMargin,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ///profile image
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    businessProvider.proImage != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: FileImage(File(businessProvider.proImage!.path)),
                          )
                        : ExtendedImage.network(
                            businessProvider.image,
                            fit: BoxFit.cover,
                            height: 120,
                            width: 120,
                            shape: BoxShape.circle,
                            loadStateChanged: (ExtendedImageState state) {
                              switch (state.extendedImageLoadState) {
                                case LoadState.loading:
                                  return SpinKitThreeBounce(
                                    color: AppColors.primarySwatch,
                                    size: 20.0,
                                  );
                                case LoadState.completed:
                                  return ExtendedImage.network(
                                    businessProvider.image,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                    shape: BoxShape.circle,
                                  );
                                case LoadState.failed:
                                  return CircleAvatar(
                                    radius: 60,
                                    backgroundImage: AssetImage("assets/app/profile.png"),
                                  );
                              }
                            },
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          businessProvider.chooseProfileImage(context);
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

              ///Business Name
              HeightBox(30),
              InputLabelWidget(
                label: getTranslated(context, LangConst.businessName).toString(),
              ),
              TextFormField(
                focusNode: _userNameFocusNode,
                controller: businessProvider.userNameController,
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
                controller: businessProvider.descriptionController,
                keyboardType: TextInputType.name,
                maxLines: 4,
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

              InputLabelWidget(
                label: getTranslated(context, LangConst.mobileNumber).toString(),
              ),
              TextFormField(
                focusNode: _phoneNumberFocusNode,
                maxLines: 1,
                controller: businessProvider.phoneNumberController,
                keyboardType: TextInputType.phone,
                cursorColor: AppColors.primarySwatch,
                validator: (value) {
                  if (value!.isEmpty) {
                    return getTranslated(context, LangConst.required).toString();
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"\s")), // To prevent space
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9]+")), // To allow only numbers
                ],
                decoration: InputDecoration(
                  labelText: getTranslated(context, LangConst.codeLabel).toString(),
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
                controller: businessProvider.webSiteController,
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
                readOnly: true,
                focusNode: _addressFocusNode,
                controller: businessProvider.addressController,
                keyboardType: TextInputType.name,
                maxLines: 4,
                cursorColor: AppColors.primarySwatch,
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

              ///city
              InputLabelWidget(
                label: getTranslated(context, LangConst.cityLabel).toString(),
              ),
              TextFormField(
                readOnly: true,
                focusNode: _cityFocusNode,
                controller: businessProvider.cityController,
                keyboardType: TextInputType.name,
                cursorColor: AppColors.primarySwatch,
                validator: (value) {
                  if (value!.isEmpty) {
                    return getTranslated(context, LangConst.pleaseEnterCity).toString();
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: getTranslated(context, LangConst.cityLabel).toString(),
                ),
                textInputAction: TextInputAction.next,
              ),
              HeightBox(16),

              ///zip  code
              InputLabelWidget(
                label: getTranslated(context, LangConst.zipCodeLabel).toString(),
              ),
              TextFormField(
                readOnly: true,
                focusNode: _zipCodeFocusNode,
                controller: businessProvider.zipCodeController,
                keyboardType: TextInputType.name,
                cursorColor: AppColors.primarySwatch,
                validator: (value) {
                  if (value!.isEmpty) {
                    return getTranslated(context, LangConst.pleaseEnterZipCode).toString();
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: getTranslated(context, LangConst.zipCodeLabel).toString(),
                ),
                textInputAction: TextInputAction.next,
              ),
              HeightBox(16),

              ///State
              InputLabelWidget(
                label: getTranslated(context, LangConst.stateLabel).toString(),
              ),
              TextFormField(
                readOnly: true,
                focusNode: _stateFocusNode,
                controller: businessProvider.stateController,
                keyboardType: TextInputType.name,
                cursorColor: AppColors.primarySwatch,
                validator: (value) {
                  if (value!.isEmpty) {
                    return getTranslated(context, LangConst.pleaseEnterState).toString();
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: getTranslated(context, LangConst.stateLabel).toString(),
                ),
                textInputAction: TextInputAction.next,
              ),
              HeightBox(16),

              ///Country
              InputLabelWidget(
                label: getTranslated(context, LangConst.countryLabel).toString(),
              ),
              TextFormField(
                readOnly: true,
                focusNode: _countryFocusNode,
                controller: businessProvider.countryController,
                keyboardType: TextInputType.name,
                cursorColor: AppColors.primarySwatch,
                validator: (value) {
                  if (value!.isEmpty) {
                    return getTranslated(context, LangConst.pleaseEnterCountry).toString();
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: getTranslated(context, LangConst.countryLabel).toString(),
                ),
                textInputAction: TextInputAction.next,
              ),
              HeightBox(16),

              ///Timing
              Text(
                getTranslated(context, LangConst.timingsLabel).toString(),
                style: Theme.of(context).brightness == Brightness.light
                    ? TypographySemibold.textThemeLight.titleLarge
                    : TypographySemibold.textThemeDark.titleLarge,
              ),
              ListView.builder(
                itemCount: businessProvider.times.length,
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
                            "${getTranslated(context, businessProvider.times[index].day.toLowerCase())}",
                            style: Theme.of(context).brightness == Brightness.light
                                ? TypographySemibold.textThemeLight.titleSmall
                                : TypographySemibold.textThemeDark.titleSmall,
                          ),
                          Checkbox(
                              value: businessProvider.times[index].isSelected,
                              onChanged: (value) {
                                setState(() {
                                  businessProvider.times[index].isSelected = value!;
                                  businessProvider.times[index].startTime.text = "";
                                  businessProvider.times[index].endTime.text = "";
                                });
                              },
                            fillColor: WidgetStateProperty.all(businessProvider.times[index].isSelected
                                ? AppColors.primarySwatch.shade500
                                : AppColors.transparent),
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
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographyRegular.textThemeLight.bodyMedium
                                      : TypographyRegular.textThemeDark.bodyMedium,
                                ),
                                HeightBox(5),
                                TextField(
                                  cursorColor: AppColors.primarySwatch,
                                  controller: businessProvider.times[index].startTime,
                                  readOnly: businessProvider.times[index].isSelected == true,
                                  onTap: businessProvider.times[index].isSelected == true
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
                                                  data: Theme.of(context).brightness == Brightness.light
                                                      ? ThemeData.light().copyWith(
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
                                                              dialBackgroundColor: AppColors.gray25.withAlpha(40)))
                                                      : ThemeData.dark().copyWith(
                                                          colorScheme: ColorScheme.dark(
                                                            // change the border color
                                                            primary: AppColors.primarySwatch,
                                                            // change the text color
                                                            onSurface: AppColors.primarySwatch,
                                                            surfaceTint: AppColors.backgroundDark,
                                                          ),
                                                          // button colors
                                                          buttonTheme: ButtonThemeData(
                                                            colorScheme: ColorScheme.dark(
                                                              primary: AppColors.primarySwatch,
                                                            ),
                                                          ),
                                                          timePickerTheme: TimePickerThemeData(
                                                              cancelButtonStyle: ButtonStyle(
                                                                textStyle: WidgetStateProperty.all(
                                                            TextStyle(color: AppColors.gray50,
                                                            ),
                                                          ),
                                                        ),
                                                        dayPeriodBorderSide: BorderSide(
                                                          color: AppColors.primarySwatch,
                                                        ),
                                                        dialBackgroundColor: AppColors.gray25.withAlpha(40)
                                                    )
                                                ),
                                                child: child!,
                                                ),
                                              );
                                            },
                                          );

                                          if (pickedTime != null) {
                                            businessProvider.times[index].startTimeTime = pickedTime;
                                            print(pickedTime.format(context)); //output 10:51 PM
                                            setState(() {
                                              businessProvider.times[index].startTime.text =
                                                  SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ==
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
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographyRegular.textThemeLight.bodyMedium
                                      : TypographyRegular.textThemeDark.bodyMedium,
                                ),
                                HeightBox(5),
                                TextField(
                                  controller: businessProvider.times[index].endTime,
                                  readOnly: businessProvider.times[index].isSelected == true,
                                  cursorColor: AppColors.primarySwatch,
                                  onTap: businessProvider.times[index].isSelected == true
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
                                                  data: Theme.of(context).brightness == Brightness.light
                                                      ? ThemeData.light().copyWith(
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
                                                              dialBackgroundColor: AppColors.gray25.withAlpha(40)))
                                                      : ThemeData.dark().copyWith(
                                                          colorScheme: ColorScheme.dark(
                                                            // change the border color
                                                            primary: AppColors.primarySwatch,
                                                            // change the text color
                                                            onSurface: AppColors.primarySwatch,
                                                            surfaceTint: AppColors.backgroundDark,
                                                          ),
                                                          // button colors
                                                          buttonTheme: ButtonThemeData(
                                                            colorScheme: ColorScheme.dark(
                                                              primary: AppColors.primarySwatch,
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
                                            businessProvider.times[index].endTimeTime = pickedTime;
                                            print(pickedTime.format(context)); //output 10:51 PM
                                            setState(() {
                                              businessProvider.times[index].endTime.text =
                                                  SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) ==
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
                style: Theme.of(context).brightness == Brightness.light
                    ? TypographySemibold.textThemeLight.titleLarge
                    : TypographySemibold.textThemeDark.titleLarge,
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
                    groupValue: businessProvider.gender,
                    onChanged: (Gender? value) {
                      setState(() {
                        businessProvider.gender = value!;
                      });
                    },
                  )),
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
                        businessProvider.gender = value!;
                      });
                    },
                    value: Gender.feMale,
                    groupValue: businessProvider.gender,
                  )),
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
                          businessProvider.gender = value!;
                        });
                      },
                      value: Gender.any,
                      groupValue: businessProvider.gender,
                    ),
                  ),
                ],
              ),
              HeightBox(30),

              ///Save
              ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> body = {
                    "name": businessProvider.userNameController.text,
                    "desc": businessProvider.descriptionController.text,
                    "gender": businessProvider.gender.name,
                    "phone": businessProvider.phoneNumberController.text,
                    "home_charges": businessProvider.homeCharges,
                    "give_service": businessProvider.giveService,
                    "website": businessProvider.webSiteController.text,
                    "address": businessProvider.addressController.text,
                    "city": businessProvider.cityController.text,
                    "state": businessProvider.stateController.text,
                    "country": businessProvider.countryController.text,
                    "zipcode": businessProvider.zipCodeController.text,
                    "latitude": businessProvider.latitude,
                    "longitude": businessProvider.longitude,
                  };
                  if (businessProvider.proImage != null) {
                    body['image'] = businessProvider.image;
                  }
                  for (int t = 0; t < businessProvider.times.length; t++) {
                    if (businessProvider.times[t].day == "Sunday") {
                      body['sunopen'] = businessProvider.times[t].startTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].startTimeTime.hour, businessProvider.times[t].startTimeTime.minute)
                          : null;
                      body['sunclose'] = businessProvider.times[t].endTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].endTimeTime.hour, businessProvider.times[t].endTimeTime.minute)
                          : null;
                    }
                    if (businessProvider.times[t].day == "Monday") {
                      body['monopen'] = businessProvider.times[t].startTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].startTimeTime.hour, businessProvider.times[t].startTimeTime.minute)
                          : null;
                      body['monclose'] = businessProvider.times[t].endTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].endTimeTime.hour, businessProvider.times[t].endTimeTime.minute)
                          : null;
                    }
                    if (businessProvider.times[t].day == "Tuesday") {
                      body['tueopen'] = businessProvider.times[t].startTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].startTimeTime.hour, businessProvider.times[t].startTimeTime.minute)
                          : null;
                      body['tueclose'] = businessProvider.times[t].endTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].endTimeTime.hour, businessProvider.times[t].endTimeTime.minute)
                          : null;
                    }
                    if (businessProvider.times[t].day == "Wednesday") {
                      body['wedopen'] = businessProvider.times[t].startTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].startTimeTime.hour, businessProvider.times[t].startTimeTime.minute)
                          : null;
                      body['wedclose'] = businessProvider.times[t].endTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].endTimeTime.hour, businessProvider.times[t].endTimeTime.minute)
                          : null;
                    }
                    if (businessProvider.times[t].day == "Thursday") {
                      body['thuopen'] = businessProvider.times[t].startTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].startTimeTime.hour, businessProvider.times[t].startTimeTime.minute)
                          : null;
                      body['thuclose'] = businessProvider.times[t].endTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].endTimeTime.hour, businessProvider.times[t].endTimeTime.minute)
                          : null;
                    }
                    if (businessProvider.times[t].day == "Friday") {
                      body['friopen'] = businessProvider.times[t].startTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].startTimeTime.hour, businessProvider.times[t].startTimeTime.minute)
                          : null;
                      body['friclose'] = businessProvider.times[t].endTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].endTimeTime.hour, businessProvider.times[t].endTimeTime.minute)
                          : null;
                    }
                    if (businessProvider.times[t].day == "Saturday") {
                      body['satopen'] = businessProvider.times[t].startTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].startTimeTime.hour, businessProvider.times[t].startTimeTime.minute)
                          : null;
                      body['satclose'] = businessProvider.times[t].endTime.text.isNotEmpty && businessProvider.times[t].isSelected == false
                          ? DeviceUtils.timeOfDayTo24HourString(businessProvider.times[t].endTimeTime.hour, businessProvider.times[t].endTimeTime.minute)
                          : null;
                    }
                  }
                  businessProvider.callUpdateBusiness(body, context);
                  print(body);
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
    );
  }
}

enum Gender { male, feMale, any }

class TimingModel {
  String day;
  bool isSelected;
  TextEditingController startTime;
  TextEditingController endTime;
  TimeOfDay startTimeTime;
  TimeOfDay endTimeTime;

  TimingModel({required this.day, required this.isSelected, required this.startTime, required this.endTime, required this.startTimeTime, required this.endTimeTime});
}
