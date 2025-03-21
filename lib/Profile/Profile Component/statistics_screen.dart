import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/statistics_provider.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'dart:math' as math;
import 'package:provider/provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _ProfileDashBoardScreen();
}

class _ProfileDashBoardScreen extends State<StatisticsScreen> {
  late StatisticsProvider statisticsProvider;

  @override
  void initState() {
    super.initState();
    statisticsProvider = Provider.of<StatisticsProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      statisticsProvider.callGetStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    statisticsProvider = Provider.of<StatisticsProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: statisticsProvider.statisticsLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.statisticsLabel).toString(),
          ),
        ),
        body: statisticsProvider.data == null
            ? SizedBox()
            : SingleChildScrollView(
                padding: EdgeInsets.all(
                  Amount.screenMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///Income And Services
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(
                              Amount.screenMargin,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                              borderRadius: AppBorderRadius.k08,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.money_dollar_circle_fill,
                                  color: AppColors.primarySwatch,
                                ),
                                HeightBox(8),
                                Text(
                                  getTranslated(context, LangConst.incomeLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                                Text(
                                  "${statisticsProvider.data!.setting!.currencySymbol}${statisticsProvider.data!.income!.toInt()}",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.titleLarge
                                      : TypographySemibold.textThemeDark.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                        WidthBox(16),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(
                              Amount.screenMargin,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                              borderRadius: AppBorderRadius.k08,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.rotate(
                                  angle: 90 * math.pi / 180,
                                  child: Icon(
                                    CupertinoIcons.scissors_alt,
                                    color: AppColors.primarySwatch,
                                  ),
                                ),
                                HeightBox(8),
                                Text(
                                  getTranslated(context, LangConst.servicesLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                                Text(
                                  "${statisticsProvider.data!.service}",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.titleLarge
                                      : TypographySemibold.textThemeDark.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    HeightBox(16),

                    ///Client And Employee
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(
                              Amount.screenMargin,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                              borderRadius: AppBorderRadius.k08,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.person_2_fill,
                                  color: AppColors.primarySwatch,
                                ),
                                HeightBox(8),
                                Text(
                                  getTranslated(context, LangConst.clientsLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                                Text(
                                  "${statisticsProvider.data!.users}",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.titleLarge
                                      : TypographySemibold.textThemeDark.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                        WidthBox(16),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(
                              Amount.screenMargin,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                              borderRadius: AppBorderRadius.k08,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.person_3_fill,
                                  color: AppColors.primarySwatch,
                                ),
                                HeightBox(8),
                                Text(
                                  getTranslated(context, LangConst.employeeLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                                Text(
                                  "${statisticsProvider.data!.employee}",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.titleLarge
                                      : TypographySemibold.textThemeDark.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    HeightBox(16),

                    ///appointment
                    Text(
                      getTranslated(context, LangConst.appointments).toString(),
                      style: TypographyMedium.textThemeLight.titleMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Theme.of(context).brightness == Brightness.light ? AppColors.gray700 : AppColors.gray50,
                      ),
                    ),
                    HeightBox(16),

                    ///Total And Pending
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(
                              Amount.screenMargin,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                              borderRadius: AppBorderRadius.k08,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_bag,
                                  color: AppColors.primarySwatch,
                                ),
                                HeightBox(8),
                                Text(
                                  getTranslated(context, LangConst.totalLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                                Text(
                                  "${statisticsProvider.data!.appointment}",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.titleLarge
                                      : TypographySemibold.textThemeDark.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                        WidthBox(16),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(
                              Amount.screenMargin,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                              borderRadius: AppBorderRadius.k08,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/app/pending_appointment.png",
                                ),
                                HeightBox(8),
                                Text(
                                  getTranslated(context, LangConst.pendingLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                                Text(
                                  "${statisticsProvider.data!.pendingAppointment}",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.titleLarge
                                      : TypographySemibold.textThemeDark.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    HeightBox(16),

                    ///Approved And Cancelled
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(
                              Amount.screenMargin,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                              borderRadius: AppBorderRadius.k08,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/app/approved_appointment.png",
                                ),
                                HeightBox(8),
                                Text(
                                  getTranslated(context, LangConst.approvedLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                                Text(
                                  "${statisticsProvider.data!.approvedAppointment}",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.titleLarge
                                      : TypographySemibold.textThemeDark.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                        WidthBox(16),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(
                              Amount.screenMargin,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.neutral700,
                              ),
                              borderRadius: AppBorderRadius.k08,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/app/cancelled_appointment.png",
                                ),
                                HeightBox(8),
                                Text(
                                  getTranslated(context, LangConst.canceledLabel).toString(),
                                  style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                    color: AppColors.gray50,
                                  ),
                                ),
                                Text(
                                  "${statisticsProvider.data!.cancelAppointment}",
                                  style: Theme.of(context).brightness == Brightness.light
                                      ? TypographySemibold.textThemeLight.titleLarge
                                      : TypographySemibold.textThemeDark.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
