import 'dart:io';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/services_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/edit_business_profile_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/service_provider.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/input_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CreateServiceScreen extends StatefulWidget {
  final bool isEdit;
  final int? id;

  const CreateServiceScreen({super.key, required this.isEdit, this.id});

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  ///Name Focus Node

  late FocusNode _nameFocusNode;

  ///Price Focus Node

  late FocusNode _priceFocusNode;

  ///DurationFocus Node

  late FocusNode _durationFocusNode;
  late ServiceProvider serviceProvider;

  @override
  void initState() {
    super.initState();
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      if (widget.isEdit == true) {
        serviceProvider.callGetSingleService(widget.id!);
      }
    });
    _nameFocusNode = FocusNode();
    _priceFocusNode = FocusNode();
    _durationFocusNode = FocusNode();
  }

  @override
  void dispose() {
    serviceProvider.nameController.text = "";
    serviceProvider.priceController.text = "";
    serviceProvider.durationController.text = "";

    _nameFocusNode.dispose();
    _priceFocusNode.dispose();
    _durationFocusNode.dispose();
    super.dispose();
  }

  String? dropdownValue;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    serviceProvider = Provider.of<ServiceProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: serviceProvider.servicesLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.addService).toString(),
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
                      Center(
                        child: serviceProvider.proImage != null
                            ? ClipRRect(
                                borderRadius: AppBorderRadius.k08,
                                child: Image.file(
                                  File(serviceProvider.proImage!.path),
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: AppBorderRadius.k08,
                                child: Image.network(
                                  widget.isEdit == true && serviceProvider.image.isNotEmpty
                                      ? serviceProvider.image
                                      : "https://cdn.iconscout.com/icon/free/png-256/free-apple-camera-493147.png",
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      GestureDetector(
                        onTap: () {
                          serviceProvider.chooseProfileImage(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                            left: 115,
                            top: 90,
                          ),
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
                  focusNode: _nameFocusNode,
                  controller: serviceProvider.nameController,
                  keyboardType: TextInputType.name,
                  cursorColor: AppColors.primarySwatch,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, LangConst.pleaseEnterName).toString();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.nameLabel).toString(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                HeightBox(16),

                ///category
                InputLabelWidget(
                  label: getTranslated(context, LangConst.categoryLabel).toString(),
                ),
                widget.isEdit == true && serviceProvider.category == null
                    ? SizedBox()
                    : FormField<String>(
                        builder: (FormFieldState<String> state) {
                          return InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                              errorStyle: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<CategoryData>(
                                icon: Icon(Icons.keyboard_arrow_down_sharp),
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                hint: Text(
                                  getTranslated(context, LangConst.categoryLabel).toString(),
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                                value: serviceProvider.category,
                                isExpanded: true,
                                isDense: true,
                                onChanged: (CategoryData? newValue) {
                                  setState(() {
                                    serviceProvider.category = newValue!;
                                  });
                                },
                                items: serviceProvider.categories
                                    .map<DropdownMenuItem<CategoryData>>((CategoryData valueItem) {
                                  return DropdownMenuItem(
                                    value: valueItem,
                                    child: Text(
                                      valueItem.name!,
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            color: Theme.of(context).brightness == Brightness.light
                                                ? AppColors.gray700
                                                : AppColors.gray50,
                                          ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      ),
                HeightBox(16),

                ///Price
                InputLabelWidget(
                  label: getTranslated(context, LangConst.priceLabel).toString(),
                ),
                TextFormField(
                  focusNode: _priceFocusNode,
                  controller: serviceProvider.priceController,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.primarySwatch,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, LangConst.pleaseEnterPrice).toString();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.amountLabel).toString(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                HeightBox(16),

                ///Time Duration
                InputLabelWidget(
                  label: getTranslated(context, LangConst.timeDuration).toString(),
                ),
                TextFormField(
                  focusNode: _durationFocusNode,
                  controller: serviceProvider.durationController,
                  keyboardType: TextInputType.number,
                  cursorColor: AppColors.primarySwatch,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, LangConst.pleaseEnterMinutes).toString();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.minutesLabel).toString(),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                HeightBox(30),

                ///status
                Text(
                  getTranslated(context, LangConst.statusLabel).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographySemibold.textThemeLight.bodyLarge
                      : TypographySemibold.textThemeDark.bodyLarge,
                ),
                HeightBox(10),
                Row(
                  children: [
                    Expanded(
                        child: RadioListTile(
                      value: Status.active,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      title: Text(
                        getTranslated(context, LangConst.activeLabel).toString(),
                        style: serviceProvider.status == Status.active
                            ? TypographyMedium.textThemeLight.titleMedium!.copyWith(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? AppColors.gray700
                                    : AppColors.gray50,
                                fontWeight: FontWeight.w500,
                              )
                            : TypographyRegular.textThemeLight.titleMedium!.copyWith(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? AppColors.gray700
                                    : AppColors.gray50,
                                fontWeight: FontWeight.w400,
                              ),
                      ),
                      groupValue: serviceProvider.status,
                      onChanged: (Status? value) {
                        setState(() {
                          serviceProvider.status = value!;
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
                        getTranslated(context, LangConst.deactivateLabel).toString(),
                        style: serviceProvider.status == Status.deactivate
                            ? TypographyMedium.textThemeLight.titleMedium!.copyWith(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? AppColors.gray700
                                    : AppColors.gray50,
                                fontWeight: FontWeight.w500,
                              )
                            : TypographyRegular.textThemeLight.titleMedium!.copyWith(
                                color: Theme.of(context).brightness == Brightness.light
                                    ? AppColors.gray700
                                    : AppColors.gray50,
                                fontWeight: FontWeight.w400,
                              ),
                      ),
                      onChanged: (Status? value) {
                        setState(() {
                          serviceProvider.status = value!;
                        });
                      },
                      value: Status.deactivate,
                      groupValue: serviceProvider.status,
                    )),
                  ],
                ),
                HeightBox(20),

                ///service For
                Text(
                  getTranslated(context, LangConst.serviceFor).toString(),
                  style: Theme.of(context).brightness == Brightness.light
                      ? TypographySemibold.textThemeLight.bodyLarge
                      : TypographySemibold.textThemeDark.bodyLarge,
                ),
                HeightBox(10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            serviceProvider.gender = Gender.male;
                          });
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: serviceProvider.gender.name == Gender.male.name
                                ? null
                                : Border.all(
                                    color: AppColors.neutral700,
                                  ),
                            borderRadius: AppBorderRadius.k04,
                            color: serviceProvider.gender.name == Gender.male.name
                                ? AppColors.primarySwatch
                                : AppColors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              getTranslated(context, LangConst.maleLabel).toString(),
                              style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                                color: serviceProvider.gender.name == Gender.male.name
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
                            serviceProvider.gender = Gender.feMale;
                          });
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: serviceProvider.gender.name == Gender.feMale.name
                                ? null
                                : Border.all(
                                    color: AppColors.neutral700,
                                  ),
                            borderRadius: AppBorderRadius.k04,
                            color: serviceProvider.gender.name == Gender.feMale.name
                                ? AppColors.primarySwatch
                                : AppColors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              getTranslated(context, LangConst.femaleLabel).toString(),
                              style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                                color: serviceProvider.gender.name == Gender.feMale.name
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
                            serviceProvider.gender = Gender.any;
                          });
                        },
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            border: serviceProvider.gender.name == Gender.any.name
                                ? null
                                : Border.all(
                                    color: AppColors.neutral700,
                                  ),
                            borderRadius: AppBorderRadius.k04,
                            color: serviceProvider.gender.name == Gender.any.name
                                ? AppColors.primarySwatch
                                : AppColors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              getTranslated(context, LangConst.anyLabel).toString(),
                              style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                                color:
                                    serviceProvider.gender.name == Gender.any.name ? AppColors.white : AppColors.gray50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                HeightBox(30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (widget.isEdit == false) {
                        if (serviceProvider.category == null) {
                          DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseSelectCategory).toString());
                        } else if (serviceProvider.image.isEmpty) {
                          DeviceUtils.toastMessage(getTranslated(context, LangConst.pleaseAddImage).toString());
                        } else {
                          Map<String, dynamic> body = {
                            "price": serviceProvider.priceController.text,
                            "time": serviceProvider.durationController.text,
                            "name": serviceProvider.nameController.text,
                            "gender": serviceProvider.gender.name == "male"
                                ? "Male"
                                : serviceProvider.gender.name == "feMale"
                                    ? "Female"
                                    : "Both",
                            "cat_id": serviceProvider.category!.catId,
                            "image": serviceProvider.image,
                          };
                          print(body);
                          serviceProvider.callCreateServices(body, context);
                        }
                      } else {
                        Map<String, dynamic> body = {
                          "price": serviceProvider.priceController.text,
                          "time": serviceProvider.durationController.text,
                          "name": serviceProvider.nameController.text,
                          "gender": serviceProvider.gender.name == "male"
                              ? "Male"
                              : serviceProvider.gender.name == "feMale"
                                  ? "Female"
                                  : "Both",
                          "cat_id": serviceProvider.category!.catId,
                          "service_id": widget.id,
                          "status": serviceProvider.status.name == "active" ? 1 : 0,
                        };
                        if (serviceProvider.proImage != null) {
                          body["image"] = serviceProvider.image;
                        }
                        print(body);
                        serviceProvider.callEditServices(body, context);
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

enum Status {
  active,
  deactivate,
}
