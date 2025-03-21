import 'package:multibusiness_business_app_flutter/Authentication/Provider/auth_provider.dart';
import 'package:multibusiness_business_app_flutter/Authentication/forgot_password_screen.dart';
import 'package:multibusiness_business_app_flutter/Authentication/sign_up_screen.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/const_string.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/input_label_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isObscureText = true;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  final _formKey = GlobalKey<FormState>();
  late AuthProvider authProvider;

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    /// TODO Setup: You can set default email and password for testing purpose, so you don't have to type every time.
    /// NOTE: Make sure to comment this code before release.

    // _emailController.text = 'demoowner@saasmonks.in';
    // _passwordController.text = '12345678';

    Future.delayed(Duration.zero, () async {
      SharedPreferenceHelper.getBoolean(PreferencesNames.isDisclaimer) == true
          ? await authProvider.callSetting()
          : null;
    });
    SharedPreferenceHelper.getBoolean(PreferencesNames.isDisclaimer) == false
        ? Future.delayed(Duration.zero, () {
            showAlertDialog(context);
          })
        : null;
    OneSignal.initialize(ConstString.oneSignalAppID);
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColors.white, // set Status bar color in Android devices
      statusBarIconBrightness: Brightness.dark, // set Status bar icons color in Android devices
      statusBarBrightness: Brightness.dark, // set Status bar icon color in iOS
    ));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.light ? AppColors.white : AppColors.backgroundDark,
        body: ModalProgressHUD(
          inAsyncCall: authProvider.loginLoader,
          progressIndicator: SpinKitThreeBounce(
            color: AppColors.primarySwatch,
            size: 50.0,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              reverse: true,
              padding: EdgeInsets.symmetric(
                horizontal: Amount.screenMargin,
              ),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppColors.transparent,
                    child: Image.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? "assets/app/splash_screen.png"
                          : "assets/app/splash_screen_dark.png",
                      height: 70,
                    ),
                  ),
                  HeightBox(24),

                  /// "Welcome back to the Barber", where the word "The Barber" is in primary shade500 color, using RichText
                  Text(
                    "${getTranslated(context, LangConst.welcomeBack).toString()}👋🏻",
                      style: Theme.of(context).brightness == Brightness.light
                          ? TypographySemibold.textThemeLight.headlineLarge
                          : TypographySemibold.textThemeDark.headlineLarge
                  ),
                  HeightBox(45),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\s")), // To prevent space
                          ],
                          decoration: InputDecoration(labelText: getTranslated(context, LangConst.emailAddress).toString()),
                          textInputAction: TextInputAction.next,
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
                              return getTranslated(context, LangConst.pleaseEnterYourPassword).toString();
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
                          textInputAction: TextInputAction.go,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: Text(
                              getTranslated(context, LangConst.forgotPasswordQuestion).toString(),
                              style: TypographyMedium.textThemeLight.bodyMedium!.copyWith(
                                color: AppColors.primarySwatch.shade500,
                              ),
                            ),
                          ),
                        ),
                        HeightBox(24),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Map<String, dynamic> body = {
                                "email": _emailController.text,
                                "password": _passwordController.text,
                                "device_token":
                                    SharedPreferenceHelper.getString(PreferencesNames.onesignalPushToken).isEmpty
                                        ? "N/A"
                                        : SharedPreferenceHelper.getString(PreferencesNames.onesignalPushToken),
                              };
                              print(body);
                              authProvider.callLogin(body, context);
                            }
                          },
                          child: Text(
                            getTranslated(context, LangConst.signInLabel).toString(),
                          ),
                          style: AppButtonStyle.filledLarge,
                        ),
                        HeightBox(32),
                        Align(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: "${getTranslated(context, LangConst.doNotHaveAnAccount).toString()} ",
                              style: TypographyMedium.textThemeLight.bodyMedium!.copyWith(
                                color: AppColors.gray50,
                              ),
                              children: [
                                TextSpan(
                                  text: getTranslated(context, LangConst.createOne).toString(),
                                  style: TypographyMedium.textThemeLight.bodyMedium!.copyWith(
                                    color: AppColors.primarySwatch.shade500,
                                  ),
                                  recognizer: new TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => SignUpScreen(),
                                        ),
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        HeightBox(76),
                      ],
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        getTranslated(context, LangConst.okLabel).toString(),
        style: TypographyMedium.textThemeLight.titleMedium!.copyWith(
          color: AppColors.primarySwatch,
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
        SharedPreferenceHelper.setBoolean(PreferencesNames.isDisclaimer, true);
        authProvider.callSetting();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      actionsPadding: EdgeInsets.only(
        right: Amount.screenMargin,
        bottom: Amount.screenMargin,
      ),
      title: Text(
        getTranslated(context, LangConst.disclaimer).toString(),
      ),
      content: Text(
        getTranslated(context, LangConst.disclaimerContent).toString(),
        maxLines: 8,
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
