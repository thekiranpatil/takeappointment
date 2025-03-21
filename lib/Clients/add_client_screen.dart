import 'dart:math';

import 'package:multibusiness_business_app_flutter/Clients/Provider/clients_provider.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/input_label_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  final _formKey = GlobalKey<FormState>();

  ///user name controller & Focus node
  TextEditingController _nameController = TextEditingController();
  late FocusNode _nameFocusNode;

  ///email controller & Focus Node
  TextEditingController _emailController = TextEditingController();
  late FocusNode _emailFocusNode;

  ///Phone number Controller & Focus Node
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _countryCodePickerController = TextEditingController();
  late FocusNode _phoneNumberFocusNode;

  ///password Controller & Focus Node
  TextEditingController _passwordController = TextEditingController();
  late FocusNode _passwordFocusNode;

  bool _isObscureText = true;

  late ClientsProvider clientsProvider;

  @override
  void initState() {
    super.initState();
    clientsProvider = Provider.of<ClientsProvider>(context, listen: false);
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _phoneNumberFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();

    /// For debugging, to save time of filling form
    _nameController.text = "Demo Customer";
    _emailController.text = "democustomer2@saasmonks.in";
    _phoneNumberController.text = (Random().nextInt(1000000000) + 1000000000).toString();
    _passwordController.text = "12345678";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _countryCodePickerController.dispose();

    _emailFocusNode.dispose();
    _nameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    clientsProvider = Provider.of<ClientsProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: clientsProvider.clientsLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.addClient).toString(),
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
                  InputLabelWidget(label: getTranslated(context, LangConst.emailLabel).toString()),
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
                            color: AppColors.neutral700,
                          ),
                          borderRadius: AppBorderRadius.k08,
                        ),
                        child: CountryCodePicker(
                          onChanged: (CountryCode countryCode) {
                            print(countryCode.dialCode);
                            setState(() {
                              _countryCodePickerController.text = countryCode.dialCode!;
                            });
                          },
                          initialSelection: _countryCodePickerController.text,
                          favorite: ['+91', 'IND'],
                          showCountryOnly: false,
                          showFlag: false,
                          showOnlyCountryWhenClosed: false,
                          alignLeft: false,
                          backgroundColor: Colors.red,
                          dialogBackgroundColor: Theme.of(context).brightness == Brightness.light
                              ? AppColors.background
                              : AppColors.backgroundDark,
                            
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
                    obscureText: _isObscureText,
                    cursorColor: AppColors.primarySwatch,
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
                    textInputAction: TextInputAction.next,
                  ),
                  HeightBox(32),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> body = {"name": _nameController.text, "email": _emailController.text, "password": _passwordController.text, "phone": _phoneNumberController.text, "code": _countryCodePickerController.text};
                        print(body);
                        clientsProvider.callAddClient(body, context);
                      }
                    },
                    child: Text(
                      getTranslated(context, LangConst.saveLabel).toString(),
                    ),
                    style: AppButtonStyle.filledLarge,
                  ),
                  HeightBox(32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
