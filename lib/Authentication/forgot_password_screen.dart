import 'package:multibusiness_business_app_flutter/Authentication/Provider/auth_provider.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/input_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController _emailController = TextEditingController();
  late FocusNode _emailFocusNode;
  final _formKey = GlobalKey<FormState>();
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(
      context,
    );
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
            getTranslated(context, LangConst.forgotPasswordLabel).toString(),
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
                HeightBox(48),
                InputLabelWidget(
                  label: getTranslated(context, LangConst.registeredEmail).toString(),
                ),
                TextFormField(
                  focusNode: _emailFocusNode,
                  controller: _emailController,
                  cursorColor: AppColors.primarySwatch,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, LangConst.pleaseEnterEmailAddress).toString();
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r"\s")), // To prevent space
                  ],
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.emailLabel).toString(),
                  ),
                ),
                HeightBox(32),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> body = {
                        "email": _emailController.text,
                      };
                      authProvider.callForgotPassword(body, context);
                    }
                  },
                  child: Text(
                    getTranslated(context, LangConst.sendOTP).toString(),
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
