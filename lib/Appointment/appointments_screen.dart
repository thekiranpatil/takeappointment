import 'package:extended_image/extended_image.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Provider/appointments_provider.dart';
import 'package:multibusiness_business_app_flutter/Home/appointment_details_screen.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:provider/provider.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late AppointmentsProvider appointmentsProvider;

  @override
  void initState() {
    super.initState();
    appointmentsProvider = Provider.of<AppointmentsProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      appointmentsProvider.callAppointment();
    });
  }

  @override
  Widget build(BuildContext context) {
    appointmentsProvider = Provider.of<AppointmentsProvider>(
      context,
    );
    return ModalProgressHUD(
      inAsyncCall: appointmentsProvider.singleAppointmentLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            getTranslated(context, LangConst.appointments).toString(),
          ),
        ),
        body: appointmentsProvider.appointments.isEmpty && appointmentsProvider.singleAppointmentLoader == false
            ? Center(
                child: Text(getTranslated(context, LangConst.noDataFound).toString()),
              )
            : ListView.separated(
                shrinkWrap: true,
                itemCount: appointmentsProvider.appointments.length,
                padding: EdgeInsets.all(
                  Amount.screenMargin,
                ),
                separatorBuilder: (context, index) => HeightBox(10),
                itemBuilder: (context, index) {
                  AppointmentObject data = appointmentsProvider.appointments[index];
                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.neutral700,
                      ),
                      borderRadius: AppBorderRadius.k08,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ExtendedImage.network(
                              data.userDetails != null
                                  ? data.userDetails!.imagePath! + data.userDetails!.image!
                                  : "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png",
                              clipBehavior: Clip.hardEdge,
                              fit: BoxFit.cover,
                              borderRadius: AppBorderRadius.k04,
                              height: 52,
                              width: 52,
                              shape: BoxShape.rectangle,
                              loadStateChanged: (ExtendedImageState state) {
                                switch (state.extendedImageLoadState) {
                                  case LoadState.loading:
                                    return SpinKitFadingCircle(
                                      color: AppColors.primarySwatch,
                                      size: 20.0,
                                    );
                                  case LoadState.completed:
                                    return ExtendedImage.network(
                                      data.userDetails != null
                                          ? data.userDetails!.imagePath! + data.userDetails!.image!
                                          : "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png",
                                      height: 52,
                                      width: 52,
                                      clipBehavior: Clip.hardEdge,
                                      fit: BoxFit.cover,
                                      shape: BoxShape.rectangle,
                                      borderRadius: AppBorderRadius.k04,
                                    );
                                  case LoadState.failed:
                                    return ClipRRect(
                                      borderRadius: AppBorderRadius.k04,
                                      child: Image.asset(
                                        "assets/app/image.png",
                                        height: 52,
                                        width: 52,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                }
                              },
                            ),
                            WidthBox(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${getTranslated(context, LangConst.idLabel).toString()}: ${data.bookingId}",
                                        style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                          color: AppColors.gray100,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${data.date}, ${SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24) == true ? DeviceUtils.convertTo24HourFormat(data.startTime!) : data.startTime}",
                                          style: TypographyMedium.textThemeLight.bodySmall!.copyWith(
                                            color: AppColors.gray50,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                  HeightBox(4),
                                  Text(
                                    "${data.userDetails != null ? data.userDetails!.name : getTranslated(context, LangConst.userNotFound).toString()}",
                                    style: TypographySemibold.textThemeLight.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        HeightBox(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${getTranslated(context, LangConst.servicesLabel).toString()}: ",
                              style: TypographyRegular.textThemeLight.bodySmall!.copyWith(
                                color: AppColors.gray50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    data.services!.length > 2 ? 2 : data.services!.length,
                                    (index) => Text(
                                          "${data.services![index].name}" +
                                              "${data.services!.length > 2 && index == 1 ? "..." : ""}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TypographyRegular.textThemeLight.bodySmall!.copyWith(
                                            color: AppColors.gray50,
                                          ),
                                        )),
                              ),
                            ),
                          ],
                        ),
                        HeightBox(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${getTranslated(context, LangConst.employeeCommission).toString()}: ",
                              style: TypographyRegular.textThemeLight.bodySmall!.copyWith(
                                color: AppColors.gray50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${appointmentsProvider.currency!.currencySymbol}${data.commissionEmployee}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TypographyRegular.textThemeLight.bodySmall!.copyWith(
                                color: AppColors.gray50,
                              ),
                            ),
                          ],
                        ),
                        HeightBox(4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${getTranslated(context, LangConst.assignTo).toString()}: ",
                              style: TypographyRegular.textThemeLight.bodySmall!.copyWith(
                                color: AppColors.gray50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${data.empDetails?.name ?? ""}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TypographyRegular.textThemeLight.bodySmall!.copyWith(
                                color: AppColors.success600,
                              ),
                            )
                          ],
                        ),
                        HeightBox(4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${getTranslated(context, LangConst.serviceAtLabel).toString()}: ",
                              style: TypographyRegular.textThemeLight.bodySmall!.copyWith(
                                color: AppColors.gray50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${data.bookingAt.ucFirst()}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TypographyRegular.textThemeLight.bodySmall!.copyWith(
                                color: AppColors.success600,
                              ),
                            )
                          ],
                        ),
                        HeightBox(4),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${getTranslated(context, LangConst.amountLabel).toString()}: ",
                              style: TypographyRegular.textThemeLight.bodySmall!.copyWith(
                                color: AppColors.gray50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${appointmentsProvider.currency!.currencySymbol}${data.payment}" +
                                  " (${data.paymentType.ucFirst()} - ${data.bookingStatus.ucFirst()})",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TypographyRegular.textThemeLight.bodySmall!.copyWith(
                                color: AppColors.primarySwatch.shade500,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        HeightBox(4),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => AppointmentDetailsScreen(
                                        id: data.id!.toInt(),
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  getTranslated(context, LangConst.viewDetails).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: AppBorderRadius.k04,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
