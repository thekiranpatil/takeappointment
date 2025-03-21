import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/profile_provider.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
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

class EditUserProfileScreen extends StatefulWidget {
  const EditUserProfileScreen({super.key});

  @override
  State<EditUserProfileScreen> createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  late FocusNode _userNameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _phoneNumberFocusNode;

  late ProfileProvider profileProvider;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      profileProvider.callProfile();
    });
    _userNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    profileProvider.userNameController.text = "";

    _emailFocusNode.dispose();
    profileProvider.emailController.text = "";

    _phoneNumberFocusNode.dispose();
    profileProvider.phoneNumberController.text = "";
    profileProvider.countryCodeController.text = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: profileProvider.profileLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.editUserProfileLabel).toString(),
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
                      ExtendedImage.network(
                        SharedPreferenceHelper.getString(PreferencesNames.imageUrl),
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
                                SharedPreferenceHelper.getString(PreferencesNames.imageUrl),
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
                        child: InkWell(
                          onTap: () {
                            profileProvider.chooseProfileImage(context);
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
                  controller: profileProvider.userNameController,
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
                  controller: profileProvider.emailController,
                  cursorColor: AppColors.primarySwatch,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
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
                      height: 52,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).brightness == Brightness.light
                              ? AppColors.neutral700
                              : AppColors.gray50,
                        ),
                        borderRadius: AppBorderRadius.k10,
                      ),
                      child: CountryCodePicker(
                        onChanged: (CountryCode countryCode) {
                          print(countryCode.dialCode);
                          setState(() {
                            profileProvider.countryCodeController.text = countryCode.dialCode!;
                          });
                        },
                        initialSelection: profileProvider.countryCodeController.text,
                        favorite: ['+1', 'USA'],
                        showCountryOnly: false,
                        showFlag: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                        textStyle: TextStyle(
                          fontSize: 16,
                          color:
                              Theme.of(context).brightness == Brightness.light ? AppColors.gray700 : AppColors.gray50,
                        ),
                        barrierColor: Theme.of(context).brightness == Brightness.light ? null : AppColors.gray900,
                        dialogBackgroundColor:
                            Theme.of(context).brightness == Brightness.light ? null : AppColors.backgroundDark,
                        
                      ),
                    ),
                    WidthBox(8),
                    Expanded(
                      child: TextFormField(
                        focusNode: _phoneNumberFocusNode,
                        controller: profileProvider.phoneNumberController,
                        cursorColor: AppColors.primarySwatch,
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
                HeightBox(30),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> body = {
                        "name": profileProvider.userNameController.text,
                        "email": profileProvider.emailController.text,
                        "phone": profileProvider.phoneNumberController.text,
                        "code": profileProvider.countryCodeController.text,
                      };
                      profileProvider.callUpdateProfile(body, context);
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
