import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Provider/appointments_provider.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final int id;

  const AppointmentDetailsScreen({super.key, required this.id});

  @override
  State<AppointmentDetailsScreen> createState() => _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  late AppointmentsProvider appointmentsProvider;

  @override
  void initState() {
    super.initState();
    appointmentsProvider = Provider.of<AppointmentsProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      appointmentsProvider.callSingleAppointment(widget.id);
    });
  }

  AppointmentObject? data;

  @override
  Widget build(BuildContext context) {
    appointmentsProvider = Provider.of<AppointmentsProvider>(context);
    if (appointmentsProvider.singleAppointment != null) {
      data = appointmentsProvider.singleAppointment;
    }
    return ModalProgressHUD(
      inAsyncCall: appointmentsProvider.singleAppointmentLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.appointmentDetails).toString(),
          ),
        ),
        body: data == null
            ? SizedBox()
            : SingleChildScrollView(
                padding: EdgeInsets.all(
                  Amount.screenMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ExtendedImage.network(
                          data!.empDetails != null ? data!.empDetails!.imagePath! + data!.empDetails!.image! : "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png",
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
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
                                  data!.empDetails != null ? data!.empDetails!.imagePath! + data!.empDetails!.image! : "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  shape: BoxShape.circle,
                                );
                              case LoadState.failed:
                                return CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage("assets/app/profile.png"),
                                );
                            }
                          },
                        ),
                        WidthBox(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data!.empDetails != null ? data!.empDetails!.name : ""}",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.headlineSmall
                                      : TypographySemibold.textThemeDark.headlineSmall
                              ),
                              Text(
                                "${data!.empDetails != null ? data!.empDetails!.email : ""}",
                                style: TypographyRegular.textThemeLight.titleSmall!.copyWith(
                                  color: AppColors.gray50,
                                ),
                              ),
                              Text(
                                "${data!.empDetails != null ? data!.empDetails!.phone : ""}",
                                style: TypographyRegular.textThemeLight.titleSmall!.copyWith(
                                  color: AppColors.gray50,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    HeightBox(30),
                    Text(
                      getTranslated(context, LangConst.clientDetails).toString(),
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.bodyLarge
                            : TypographySemibold.textThemeDark.bodyLarge
                    ),
                    HeightBox(8),

                    ///user name
                    Text(
                      getTranslated(context, LangConst.nameLabel).toString(),
                      style: TypographyRegular.textThemeLight.labelMedium!.copyWith(
                        color: AppColors.gray50,
                      ),
                    ),
                    Text(
                      "${data!.userDetails != null ? data!.userDetails!.name : ""}",
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.labelLarge
                            : TypographySemibold.textThemeDark.labelLarge
                    ),
                    HeightBox(16),

                    ///user email
                    Text(
                      getTranslated(context, LangConst.emailLabel).toString(),
                      style: TypographyRegular.textThemeLight.labelMedium!.copyWith(
                        color: AppColors.gray50,
                      ),
                    ),
                    Text(
                      "${data!.userDetails != null ? data!.userDetails!.email : ""}",
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.labelLarge
                            : TypographySemibold.textThemeDark.labelLarge
                    ),
                    HeightBox(16),

                    ///user phone no
                    Text(
                      getTranslated(context, LangConst.phoneLabel).toString(),
                      style: TypographyRegular.textThemeLight.labelMedium!.copyWith(
                        color: AppColors.gray50,
                      ),
                    ),
                    Text(
                      "${data!.userDetails != null ? data!.userDetails!.phone : ""}",
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.labelLarge
                            : TypographySemibold.textThemeDark.labelLarge
                    ),
                    HeightBox(16),

                    HeightBox(30),
                    Text(
                      getTranslated(context, LangConst.appointmentDetails).toString(),
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.bodyLarge
                            : TypographySemibold.textThemeDark.bodyLarge
                    ),
                    HeightBox(8),

                    ///date and time
                    Text(
                      getTranslated(context, LangConst.dateAndTimeLabel).toString(),
                      style: TypographyRegular.textThemeLight.labelMedium!.copyWith(
                        color: AppColors.gray50,
                      ),
                    ),
                    Text(
                      "${data!.date}, ${SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) == true ? DeviceUtils.convertTo24HourFormat(data!.startTime!) : data!.startTime}",
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.labelLarge
                            : TypographySemibold.textThemeDark.labelLarge
                    ),
                    HeightBox(16),

                    ///Specialist Name
                    Text(
                      getTranslated(context, LangConst.specialistName).toString(),
                      style: TypographyRegular.textThemeLight.labelMedium!.copyWith(
                        color: AppColors.gray50,
                      ),
                    ),
                    Text(
                      "${data!.empDetails != null ? data!.empDetails!.name : ""}",
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.labelLarge
                            : TypographySemibold.textThemeDark.labelLarge
                    ),
                    HeightBox(16),

                    ///Payment Method
                    Text(
                      getTranslated(context, LangConst.paymentMethod).toString(),
                      style: TypographyRegular.textThemeLight.labelMedium!.copyWith(
                        color: AppColors.gray50,
                      ),
                    ),
                    Text(
                      getTranslated(context, "${data!.paymentType}".toLowerCase()).toString(),
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.labelLarge
                            : TypographySemibold.textThemeDark.labelLarge
                    ),
                    HeightBox(16),

                    ///Appointment at
                    Text(
                      getTranslated(context, LangConst.appointmentAtLabel).toString(),
                      style: TypographyRegular.textThemeLight.labelMedium!.copyWith(
                        color: AppColors.gray50,
                      ),
                    ),
                    Text(
                      getTranslated(context, "${data!.bookingAt}".toLowerCase()).toString(),
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.labelLarge
                            : TypographySemibold.textThemeDark.labelLarge
                    ),
                    HeightBox(16),

                    ///address
                    Visibility(
                      visible: data!.bookingAt!.toLowerCase() == "home",
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, LangConst.addressLabel).toString(),
                            style: TypographyRegular.textThemeLight.labelMedium!.copyWith(
                              color: AppColors.gray50,
                            ),
                          ),
                          Text(
                            data!.addressDetails != null ? "${data!.addressDetails!.street! + " " + data!.addressDetails!.city! + " " + data!.addressDetails!.state! + " " + data!.addressDetails!.country!}" : "",
                            style: TypographySemibold.textThemeLight.labelLarge,
                            maxLines: 2,
                          ),
                          HeightBox(16),
                        ],
                      ),
                    ),

                    ///Status
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslated(context, LangConst.statusLabel).toString(),
                          style: TypographyRegular.textThemeLight.labelMedium!.copyWith(
                            color: AppColors.gray50,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                              borderRadius: AppBorderRadius.k08),
                          child: DropdownButton(
                            padding: EdgeInsets.zero,
                            value: appointmentsProvider.dropDownValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            borderRadius: AppBorderRadius.k04,
                            underline: SizedBox(),
                            items: appointmentsProvider.items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  getTranslated(context, items.toLowerCase() + '_label').toString(),
                                  style: TypographySemibold.textThemeLight.labelLarge!.copyWith(
                                    color: AppColors.success500,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                if(appointmentsProvider.dropDownValue=="Cancel"){

                                }
                                else if(appointmentsProvider.dropDownValue == "Completed"){

                                }
                                else if(appointmentsProvider.dropDownValue=="Pending"){
                                  Map<String, dynamic> body = {
                                    "bookingId": appointmentsProvider.singleAppointment!.id!.toInt(),
                                    "status": newValue,
                                  };
                                  print(body);
                                  appointmentsProvider.callAppointmentStatusChange(body);
                                }
                                else if(appointmentsProvider.dropDownValue == "Approved"){
                                  Map<String, dynamic> body = {
                                    "bookingId": appointmentsProvider.singleAppointment!.id!.toInt(),
                                    "status": newValue,
                                  };
                                  print(body);
                                  appointmentsProvider.callAppointmentStatusChange(body);
                                }
                                else if (appointmentsProvider.dropDownValue == "Approved" && newValue == "Cancel") {
                                  Map<String, dynamic> body = {
                                    "bookingId": appointmentsProvider.singleAppointment!.id!.toInt(),
                                    "status": newValue,
                                  };
                                  print(body);
                                  appointmentsProvider.callAppointmentStatusChange(body);
                                }
                                else if (appointmentsProvider.dropDownValue == "Approved" && newValue == "Completed") {
                                  Map<String, dynamic> body = {
                                    "bookingId": appointmentsProvider.singleAppointment!.id!.toInt(),
                                    "status": newValue,
                                  };
                                  print(body);
                                  appointmentsProvider.callAppointmentStatusChange(body);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    HeightBox(30),

                    Text(
                      "${getTranslated(context, LangConst.servicesLabel).toString()} (${data!.services!.length})",
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.bodyLarge
                            : TypographySemibold.textThemeDark.bodyLarge
                    ),
                    ListView.separated(
                      itemCount: data!.services!.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => HeightBox(10),
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data!.services![index].name!,
                              style: Theme.of(context).brightness == Brightness.light
                                  ? TypographyRegular.textThemeLight.labelMedium
                                  : TypographyRegular.textThemeDark.labelMedium,
                            ),
                            Text(
                              "${data!.currencySymbol}${data!.services![index].price}",
                              style: TypographySemibold.textThemeLight.labelLarge!.copyWith(
                                color: AppColors.primarySwatch,
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    HeightBox(20),
                    data!.extraCharges!="0"?Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getTranslated(context, LangConst.extraCharges).toString()),
                        Text("${data!.currencySymbol}${data!.extraCharges??0}"),
                      ],
                    ):SizedBox(),
                    data!.extraCharges!="0"?HeightBox(8):SizedBox(),
                    data!.discount!=0?Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getTranslated(context, LangConst.discount).toString()),
                        Text("-${data!.currencySymbol}${data!.discount??0}"),
                      ],
                    ):SizedBox(),
                    Divider(endIndent: 0,indent: 0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getTranslated(context,LangConst.totalPayment).toString(),style:Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.titleMedium
                            : TypographySemibold.textThemeDark.titleMedium,),
                        Text("${data!.currencySymbol}${data!.payment??0}",style:Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.titleMedium
                            : TypographySemibold.textThemeDark.titleMedium,),
                      ],
                    )

                  ],
                ),
              ),
      ),
    );
  }
}
