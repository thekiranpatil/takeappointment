import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Clients/Model/client_profile_response.dart';
import 'package:multibusiness_business_app_flutter/Clients/Provider/clients_provider.dart';
import 'package:multibusiness_business_app_flutter/Home/appointment_details_screen.dart';
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

class ClientProfileScreen extends StatefulWidget {
  final int id;

  const ClientProfileScreen({super.key, required this.id});

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  late ClientsProvider clientsProvider;

  @override
  void initState() {
    super.initState();
    clientsProvider = Provider.of<ClientsProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      clientsProvider.callClientProfile(widget.id);
    });
  }

  ClientProfileData? data;

  @override
  Widget build(BuildContext context) {
    clientsProvider = Provider.of<ClientsProvider>(context);
    if (clientsProvider.clientProfile != null && clientsProvider.clientProfile!.data != null) {
      data = clientsProvider.clientProfile!.data!;
    }
    return ModalProgressHUD(
      inAsyncCall: clientsProvider.clientsLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.clientProfile).toString(),
          ),
        ),
        body: data != null
            ? SingleChildScrollView(
                padding: EdgeInsets.all(
                  Amount.screenMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///client info
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ExtendedImage.network(
                            data!.user!.imagePath! + data!.user!.image!,
                            fit: BoxFit.cover,
                            height: 80,
                            width: 80,
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
                                    data!.user!.imagePath! + data!.user!.image!,
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                    shape: BoxShape.circle,
                                  );
                                case LoadState.failed:
                                  return CircleAvatar(
                                    radius: 40,
                                    backgroundImage: AssetImage("assets/app/profile.png"),
                                  );
                              }
                            },
                          ),
                          HeightBox(8),
                          Text(
                            "${data!.user!.name}",
                              style: Theme.of(context).brightness == Brightness.light
                                  ? TypographySemibold.textThemeLight.titleMedium
                                  : TypographySemibold.textThemeDark.titleMedium
                          ),
                          Text(
                            "${data!.user!.email}",
                            style: TypographyRegular.textThemeLight.titleSmall!.copyWith(
                              color: AppColors.gray50,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///count info
                    HeightBox(16),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.k04,
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Text(
                                  "${data!.totalSales}",
                                    style: Theme.of(context).brightness == Brightness.light
                                        ? TypographyMedium.textThemeLight.titleLarge
                                        : TypographyMedium.textThemeDark.titleLarge
                                ),
                                Text(
                                  getTranslated(context, LangConst.totalSalesLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        WidthBox(12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.k04,
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Text(
                                  "${data!.outstanding}",
                                    style: Theme.of(context).brightness == Brightness.light
                                        ? TypographyMedium.textThemeLight.titleLarge
                                        : TypographyMedium.textThemeDark.titleLarge
                                ),
                                Text(
                                  getTranslated(context, LangConst.outStandingLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        WidthBox(12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.k04,
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Text(
                                  "${data!.allBooking!.length}",
                                    style: Theme.of(context).brightness == Brightness.light
                                        ? TypographyMedium.textThemeLight.titleLarge
                                        : TypographyMedium.textThemeDark.titleLarge
                                ),
                                Text(
                                  getTranslated(context, LangConst.allBookingsLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    HeightBox(12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.k04,
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Text(
                                  "${data!.approved}",
                                    style: Theme.of(context).brightness == Brightness.light
                                        ? TypographyMedium.textThemeLight.titleLarge
                                        : TypographyMedium.textThemeDark.titleLarge
                                ),
                                Text(
                                  getTranslated(context, LangConst.approvedLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        WidthBox(12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.k04,
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Text(
                                  "${data!.pending}",
                                    style: Theme.of(context).brightness == Brightness.light
                                        ? TypographyMedium.textThemeLight.titleLarge
                                        : TypographyMedium.textThemeDark.titleLarge
                                ),
                                Text(
                                  getTranslated(context, LangConst.pendingLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        WidthBox(12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.k04,
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Text(
                                  "${data!.cancel}",
                                    style: Theme.of(context).brightness == Brightness.light
                                        ? TypographyMedium.textThemeLight.titleLarge
                                        : TypographyMedium.textThemeDark.titleLarge
                                ),
                                Text(
                                  getTranslated(context, LangConst.canceledLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    HeightBox(12),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                        WidthBox(12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: AppBorderRadius.k04,
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                            ),
                            padding: EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Text(
                                  "${data!.completed}",
                                    style: Theme.of(context).brightness == Brightness.light
                                        ? TypographyMedium.textThemeLight.titleLarge
                                        : TypographyMedium.textThemeDark.titleLarge
                                ),
                                Text(
                                  getTranslated(context, LangConst.completedLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        WidthBox(12),
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    HeightBox(16),

                    ///appoint label & list
                    Text(
                      getTranslated(context, LangConst.appointments).toString(),
                        style: Theme.of(context).brightness == Brightness.light
                            ? TypographySemibold.textThemeLight.titleMedium
                            : TypographySemibold.textThemeDark.titleMedium
                    ),
                    ListView.separated(
                      itemCount: data!.allBooking!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 12,
                      ),
                      separatorBuilder: (context, index) => Divider(
                        endIndent: 0,
                        indent: 0,
                      ),
                      itemBuilder: (context, index) {
                        AppointmentObject appointments = data!.allBooking![index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AppointmentDetailsScreen(
                                  id: appointments.id!.toInt(),
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "${DeviceUtils.convertShortMonthName(appointments.date!).replaceAll(" ", "\n")}",
                                // "25 \nFeb",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.bodyMedium
                                      : TypographySemibold.textThemeDark.bodyMedium
                              ),
                              WidthBox(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${DeviceUtils.getDay(appointments.date!)} ${SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) == true ? DeviceUtils.convertTo24HourFormat(appointments.startTime!) : appointments.startTime}",
                                            style: Theme.of(context).brightness == Brightness.light
                                                ? TypographyMedium.textThemeLight.bodyLarge
                                                : TypographyMedium.textThemeDark.bodyLarge
                                        ),
                                        WidthBox(12),
                                        Text(
                                          "${appointments.bookingStatus}",
                                          style: TypographyMedium.textThemeLight.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.success600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${DeviceUtils.getDay(appointments.date!)} with ${appointments.empDetails != null ? appointments.empDetails!.name : ""}",
                                        style: Theme.of(context).brightness == Brightness.light
                                            ? TypographyMedium.textThemeLight.bodyLarge
                                            : TypographyMedium.textThemeDark.bodyLarge
                                    ),
                                  ],
                                ),
                              ),
                              WidthBox(12),
                              Text(
                                "${appointments.currencySymbol}${appointments.payment}",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.bodyLarge
                                      : TypographySemibold.textThemeDark.bodyLarge
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
