import 'package:multibusiness_business_app_flutter/Authentication/Provider/auth_provider.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/input_label_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  ///current password Controller & Focus Node
  TextEditingController _currentPasswordController = TextEditingController();
  late FocusNode _currentPasswordFocusNode;

  bool _isCurrentObscureText = true;

  ///new password Controller & Focus Node
  TextEditingController _newPasswordController = TextEditingController();
  late FocusNode _newPasswordFocusNode;

  bool _isNewObscureText = true;

  ///confirm password Controller & Focus Node
  TextEditingController _confirmPasswordController = TextEditingController();
  late FocusNode _confirmPasswordFocusNode;

  bool _isConfirmObscureText = true;
  final _formKey = GlobalKey<FormState>();
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    _currentPasswordFocusNode = FocusNode();
    _newPasswordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();

    _currentPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
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
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.changePassword).toString(),
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
                InputLabelWidget(
                  label: getTranslated(context, LangConst.currentPassword).toString(),
                ),
                TextFormField(
                  cursorColor: AppColors.primarySwatch,
                  focusNode: _currentPasswordFocusNode,
                  controller: _currentPasswordController,
                  obscureText: _isCurrentObscureText,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, LangConst.pleaseEnterYourCurrentPassword).toString();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.currentPassword).toString(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isCurrentObscureText = !_isCurrentObscureText;
                        });
                      },
                      child: Icon(
                        _isCurrentObscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                HeightBox(16),
                InputLabelWidget(
                  label: getTranslated(context, LangConst.newPassword).toString(),
                ),
                TextFormField(
                  focusNode: _newPasswordFocusNode,
                  controller: _newPasswordController,
                  obscureText: _isNewObscureText,
                  cursorColor: AppColors.primarySwatch,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return getTranslated(context, LangConst.pleaseEnterYourNewPassword).toString();
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: getTranslated(context, LangConst.newPassword).toString(),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isNewObscureText = !_isNewObscureText;
                        });
                      },
                      child: Icon(
                        _isNewObscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                  obscureText: _isConfirmObscureText,
                  cursorColor: AppColors.primarySwatch,
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
                HeightBox(30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> body = {
                        "old_password": _currentPasswordController.text,
                        "new_password": _newPasswordController.text,
                        "confirm_password": _confirmPasswordController.text,
                      };
                      print(body);
                      authProvider.callChangePassword(body, context);
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
