import 'package:multibusiness_business_app_flutter/Authentication/Provider/auth_provider.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/input_label_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  ///user name controller & Focus node
  TextEditingController _nameController = TextEditingController();
  late FocusNode _nameFocusNode;

  ///email controller & Focus Node
  TextEditingController _emailController = TextEditingController();
  late FocusNode _emailFocusNode;

  ///Phone number Controller & Focus Node
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController(text: "+1");
  late FocusNode _phoneNumberFocusNode;

  ///password Controller & Focus Node
  TextEditingController _passwordController = TextEditingController();
  late FocusNode _passwordFocusNode;

  ///Confirm password Controller & Focus Node
  TextEditingController _confirmPasswordController = TextEditingController();
  late FocusNode _confirmPasswordFocusNode;

  String _pricingModel = "commission";
  late FocusNode _pricingModelFocusNode;

  bool _isObscureText = true;
  bool _isConfirmObscureText = true;
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
    _pricingModelFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    countryCodeController.dispose();

    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: authProvider.loginLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.createAccount).toString(),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Amount.screenMargin,
              vertical: 16,
            ),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputLabelWidget(
                    label: getTranslated(context, LangConst.nameLabel).toString(),
                  ),
                  TextFormField(
                    focusNode: _nameFocusNode,
                    controller: _nameController,
                    cursorColor: AppColors.primarySwatch,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, LangConst.pleaseEnterFullName).toString();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: getTranslated(context, LangConst.userNameLabel).toString(),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  HeightBox(16),
                  InputLabelWidget(
                    label: getTranslated(context, LangConst.emailLabel).toString(),
                  ),
                  TextFormField(
                    focusNode: _emailFocusNode,
                    controller: _emailController,
                    cursorColor: AppColors.primarySwatch,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, LangConst.pleaseEnterValidEmail).toString();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: getTranslated(context, LangConst.emailLabel).toString(),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  HeightBox(16),
                  InputLabelWidget(
                    label: getTranslated(context, LangConst.mobileNumber).toString(),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 80,
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
                              countryCodeController.text = countryCode.dialCode!;
                            });
                          },
                          initialSelection: countryCodeController.text,
                          dialogTextStyle: TextStyle(
                            color:
                                Theme.of(context).brightness == Brightness.light ? AppColors.gray700 : AppColors.gray50,
                          ),
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
                          controller: _phoneNumberController,
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
                  HeightBox(16),
                  InputLabelWidget(
                    label: getTranslated(context, LangConst.passwordLabel).toString(),
                  ),
                  TextFormField(
                    focusNode: _passwordFocusNode,
                    controller: _passwordController,
                    cursorColor: AppColors.primarySwatch,
                    obscureText: _isObscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, LangConst.pleaseEnterYourPassword);
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: getTranslated(context, LangConst.passwordLabel).toString(),
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
                    textInputAction: TextInputAction.next,
                  ),
                  HeightBox(16),
                  InputLabelWidget(
                    label: getTranslated(context, LangConst.confirmPassword).toString(),
                  ),
                  TextFormField(
                    focusNode: _confirmPasswordFocusNode,
                    controller: _confirmPasswordController,
                    cursorColor: AppColors.primarySwatch,
                    obscureText: _isConfirmObscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, LangConst.pleaseEnterYourConfirmPassword).toString();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: getTranslated(context, LangConst.confirmPassword).toString(),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _isConfirmObscureText = !_isConfirmObscureText;
                          });
                        },
                        child: Icon(
                          _isConfirmObscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  if (SharedPreferenceHelper.getBoolean(PreferencesNames.isSubscriptionModuleEnabled)) ...[
                    HeightBox(16),
                    InputLabelWidget(
                      label: getTranslated(context, LangConst.pricingModel).toString(),
                    ),
                    DropdownButtonFormField(
                      value: _pricingModel,
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            getTranslated(context, LangConst.commission).toString(),
                            style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? AppColors.gray700
                                  : AppColors.gray50,
                            ),
                          ),
                          value: "commission",
                          onTap: () => _pricingModel = "commission",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            getTranslated(context, LangConst.subscription).toString(),
                            style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.light
                                  ? AppColors.gray700
                                  : AppColors.gray50,
                            ),
                          ),
                          value: "subscription",
                          onTap: () => _pricingModel = "subscription",
                        )
                      ],
                      onChanged: (value) {
                        _pricingModel = value ?? _pricingModel;
                      },
                      focusNode: _pricingModelFocusNode,
                    ),
                  ],
                  HeightBox(32),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> body = {
                          "email": _emailController.text,
                          "name": _nameController.text,
                          "phone": _phoneNumberController.text,
                          "code": countryCodeController.text,
                          "password": _passwordController.text,
                          "confirm_password": _confirmPasswordController.text,
                          "pricing_model": _pricingModel
                        };
                        print(body);
                        authProvider.callRegister(body, context);
                      }
                    },
                    child: Text(
                      getTranslated(context, LangConst.createAccount).toString(),
                    ),
                    style: AppButtonStyle.filledLarge,
                  ),
                  HeightBox(32),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "${getTranslated(context, LangConst.alreadyHaveAnAccount).toString()} ",
                        style: TypographyMedium.textThemeLight.bodyMedium!.copyWith(
                          color: AppColors.gray50,
                        ),
                        children: [
                          TextSpan(
                            text: getTranslated(context, LangConst.signInLabel).toString(),
                            style: TypographyMedium.textThemeLight.bodyMedium!.copyWith(
                              color: AppColors.primarySwatch.shade500,
                            ),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pop();
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
