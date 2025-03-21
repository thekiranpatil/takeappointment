import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Provider/auth_provider.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/input_label_widget.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreenRegistration extends StatefulWidget {
  final int userId;
  final num emailVerify;
  final num phoneVerify;
  const OtpVerificationScreenRegistration(
      {Key? key, required this.userId, required this.emailVerify, required this.phoneVerify})
      : super(key: key);

  @override
  State<OtpVerificationScreenRegistration> createState() => _OtpVerificationScreenRegistrationState();
}

class _OtpVerificationScreenRegistrationState extends State<OtpVerificationScreenRegistration> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _otpEmailController = TextEditingController();
  TextEditingController _otpPhoneController = TextEditingController();
  late FocusNode _otpEmailFocusNode;
  late FocusNode _otpPhoneFocusNode;
  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    _otpEmailFocusNode = FocusNode();
    _otpPhoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _otpEmailController.dispose();
    _otpPhoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: authProvider.otpVerification,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.otpVerification).toString(),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(
            Amount.screenMargin,
          ),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeightBox(48),
                InputLabelWidget(
                  label: getTranslated(context, LangConst.otpLabel).toString(),
                ),
                widget.emailVerify == 0
                    ? TextFormField(
                        focusNode: _otpEmailFocusNode,
                        controller: _otpEmailController,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        cursorColor: AppColors.primarySwatch,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          labelText: getTranslated(context, LangConst.verificationCodeEmail).toString(),
                        ),
                      )
                    : SizedBox(),
                widget.emailVerify == 0 ? HeightBox(32) : SizedBox(),
                widget.phoneVerify == 0
                    ? TextFormField(
                        focusNode: _otpPhoneFocusNode,
                        controller: _otpPhoneController,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        cursorColor: AppColors.primarySwatch,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          labelText: getTranslated(context, LangConst.verificationCodePhone).toString(),
                        ),
                      )
                    : SizedBox(),
                HeightBox(32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> body = {
                        'user_id': widget.userId.toString(),
                      };
                      if (_otpEmailController.text.isNotEmpty) {
                        body['otp_email'] = _otpEmailController.text;
                      }
                      if (_otpPhoneController.text.isNotEmpty) {
                        body["otp_phone"] = _otpPhoneController.text;
                      }
                      authProvider.callCheckOtp(body, context);
                    }
                  },
                  child: Text(
                    getTranslated(context, LangConst.verify).toString(),
                  ),
                  style: AppButtonStyle.filledLarge,
                ),
                HeightBox(32),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: getTranslated(context, LangConst.didNotReceivedTheCode).toString(),
                      style: TypographyMedium.textThemeLight.bodyMedium!.copyWith(
                        color: AppColors.gray50,
                      ),
                      children: [
                        TextSpan(
                          text: " " + getTranslated(context, LangConst.resend).toString(),
                          style: TypographyMedium.textThemeLight.bodyMedium!.copyWith(
                            color: AppColors.primarySwatch.shade500,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              Map<String, dynamic> body = {
                                "user_id": widget.userId,
                              };
                              authProvider.callResendOtp(body);
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
    );
  }
}
