import 'package:multibusiness_business_app_flutter/Appointment/Model/home_all_appointments_response.dart';
import 'package:multibusiness_business_app_flutter/Appointment/Provider/appointments_provider.dart';
import 'package:multibusiness_business_app_flutter/Home/appointment_details_screen.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class PendingAppointmentTab extends StatefulWidget {
  const PendingAppointmentTab({super.key});

  @override
  State<PendingAppointmentTab> createState() => _PendingAppointmentTabState();
}

class _PendingAppointmentTabState extends State<PendingAppointmentTab> {
  late AppointmentsProvider appointmentsProvider;

  @override
  void initState() {
    super.initState();
    appointmentsProvider = Provider.of<AppointmentsProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    appointmentsProvider = Provider.of<AppointmentsProvider>(context);
    return appointmentsProvider.pendingAppointments.isEmpty
        ? Center(
            child: Text(getTranslated(context, LangConst.noDataFound).toString()),
          )
        : ListView.separated(
            shrinkWrap: true,
            itemCount: appointmentsProvider.pendingAppointments.length,
            padding: EdgeInsets.all(
              Amount.screenMargin,
            ),
            separatorBuilder: (context, index) => HeightBox(10),
            itemBuilder: (context, index) {
              AppointmentObject data = appointmentsProvider.pendingAppointments[index];
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
                          data.userDetails != null ? data.userDetails!.imagePath! + data.userDetails!.image! : "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png",
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
                                  data.userDetails != null ? data.userDetails!.imagePath! + data.userDetails!.image! : "https://www.pngall.com/wp-content/uploads/5/User-Profile-PNG-High-Quality-Image.png",
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
                                      "${data.date}, ${SharedPreferenceHelper.getBoolean(PreferencesNames.timeFormat24)==true?DeviceUtils.convertTo24HourFormat(data.startTime!):data.startTime}",
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
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                data.services!.length > 2 ? 2 : data.services!.length,
                                (index) => Text(
                                      "${data.services![index].name}," "${data.services!.length > 2 && index == 1 ? "..." : ""}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TypographySemibold.textThemeLight.titleSmall!.copyWith(
                                        color: AppColors.gray700,
                                      ),
                                    )),
                          ),
                        ),
                      ],
                    ),
                    HeightBox(4),
                    Divider(
                      indent: 0,
                      endIndent: 0,
                    ),
                    HeightBox(4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "• ${data.empDetails != null ? data.empDetails!.name : getTranslated(context, LangConst.noEmployeeFound).toString()}",
                            style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                              color: AppColors.success600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "• ${appointmentsProvider.currency!.currencySymbol}${data.payment}",
                            style: TypographyMedium.textThemeLight.labelMedium!.copyWith(
                              color: AppColors.primarySwatch.shade500,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
          );
  }
}
