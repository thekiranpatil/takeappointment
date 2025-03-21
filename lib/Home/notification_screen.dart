import 'package:multibusiness_business_app_flutter/Home/Model/notification_response.dart';
import 'package:multibusiness_business_app_flutter/Home/Provider/notification_provider.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/time_ago.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationProvider notificationProvider;

  @override
  void initState() {
    super.initState();
    notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      notificationProvider.callGetNotification();
    });
  }

  @override
  Widget build(BuildContext context) {
    notificationProvider = Provider.of<NotificationProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: notificationProvider.notificationLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.notifications).toString(),
          ),
        ),
        body: notificationProvider.notifications.isEmpty && notificationProvider.notificationLoader == false
            ? Center(
                child: Text(getTranslated(context, LangConst.noDataFound).toString()),
              )
            : ListView.separated(
                shrinkWrap: true,
                itemCount: notificationProvider.notifications.length,
                padding: EdgeInsets.symmetric(
                  vertical: Amount.screenMargin,
                ),
                separatorBuilder: (context, index) => Divider(
                  endIndent: 0,
                  indent: 0,
                ),
                itemBuilder: (context, index) {
                  NotificationData data = notificationProvider.notifications[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Amount.screenMargin,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).brightness == Brightness.light
                              ? AppColors.primarySwatch.shade100
                              : AppColors.gray400,
                          child: Icon(Icons.notifications_none),
                        ),
                        WidthBox(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      getTranslated(context, "${data.title}").toString() == "null"
                                          ? "${data.title}"
                                          : getTranslated(context, "${data.title}").toString(),
                                      style: Theme.of(context).brightness == Brightness.light
                                          ? TypographyMedium.textThemeLight.titleMedium
                                          : TypographyMedium.textThemeDark.titleMedium,
                                    ),
                                  ),
                                  Text(
                                    "${TimeAgoT.timeAgoSinceDate(data.createdAt!)}",
                                    style: TypographyRegular.textThemeLight.labelLarge!.copyWith(
                                      color: AppColors.gray50,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${data.msg}",
                                style: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                                  color: AppColors.gray100,
                                ),
                                maxLines: 6,
                              ),
                            ],
                          ),
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
