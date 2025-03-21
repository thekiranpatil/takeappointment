import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Model/services_response.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/create_service_screen.dart';
import 'package:multibusiness_business_app_flutter/Profile/Provider/service_provider.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late ServiceProvider serviceProvider;

  @override
  void initState() {
    super.initState();
    serviceProvider = Provider.of<ServiceProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      serviceProvider.callGetServices();
      serviceProvider.callCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    serviceProvider = Provider.of<ServiceProvider>(
      context,
    );
    return ModalProgressHUD(
      inAsyncCall: serviceProvider.servicesLoader,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.servicesLabel).toString(),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateServiceScreen(isEdit: false),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                  left: 5,
                  top: 8,
                  bottom: 8,
                  right: 16,
                ),
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 8,
                  left: 11,
                  right: 11,
                ),
                decoration: BoxDecoration(
                  borderRadius: AppBorderRadius.k10,
                  color: AppColors.primarySwatch,
                ),
                child: Icon(
                  Icons.add,
                  size: 20,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(
            Amount.screenMargin,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: serviceProvider.servicesCategoryList.length,
                  padding: EdgeInsets.only(
                    top: Amount.screenMargin,
                  ),
                  separatorBuilder: (context, index) => HeightBox(30),
                  itemBuilder: (context, index) {
                    CategoryData data = serviceProvider.servicesCategoryList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name!,
                          style: Theme.of(context).brightness == Brightness.light
                              ? TypographyMedium.textThemeLight.titleMedium
                              : TypographyMedium.textThemeDark.titleMedium,
                        ),
                        data.service!.isEmpty
                            ? SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    getTranslated(context, LangConst.noDataFound).toString(),
                                    style: TextStyle(
                                      color: Theme.of(context).brightness == Brightness.light
                                          ? AppColors.gray700
                                          : AppColors.gray50,
                                    ),
                                  ),
                                ))
                            : ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                  top: Amount.screenMargin,
                                ),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.service!.length,
                                separatorBuilder: (context, sIndex) {
                                  return Divider(
                                    indent: 0,
                                    endIndent: 0,
                                  );
                                },
                                itemBuilder: (context, sIndex) {
                                  ServiceName services = data.service![sIndex];
                                  return ListTile(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CreateServiceScreen(
                                            isEdit: true,
                                            id: services.serviceId!.toInt(),
                                          ),
                                        ),
                                      );
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: VisualDensity(
                                      vertical: -4,
                                      horizontal: -4,
                                    ),
                                    leading: ExtendedImage.network(
                                      services.imagePath! + services.image!,
                                      fit: BoxFit.cover,
                                      borderRadius: AppBorderRadius.k08,
                                      shape: BoxShape.rectangle,
                                      width: 48,
                                      height: 48,
                                      loadStateChanged: (ExtendedImageState state) {
                                        switch (state.extendedImageLoadState) {
                                          case LoadState.loading:
                                            return SpinKitThreeBounce(
                                              color: AppColors.primarySwatch,
                                              size: 20.0,
                                            );
                                          case LoadState.completed:
                                            return ExtendedImage.network(
                                              services.imagePath! + services.image!,
                                              fit: BoxFit.cover,
                                              borderRadius: AppBorderRadius.k08,
                                              shape: BoxShape.rectangle,
                                              width: 48,
                                              height: 48,
                                            );
                                          case LoadState.failed:
                                            return ClipRRect(
                                              borderRadius: AppBorderRadius.k04,
                                              child: Image.network(
                                                "https://picsum.photos/200/300",
                                                fit: BoxFit.cover,
                                                height: 48,
                                                width: 48,
                                              ),
                                            );
                                        }
                                      },
                                    ),
                                    title: Text(
                                      services.name!,
                                      style: Theme.of(context).brightness == Brightness.light
                                          ? TypographyMedium.textThemeLight.titleMedium
                                          : TypographyMedium.textThemeDark.titleMedium,
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        showDeleteDialog(context, sIndex, services.serviceId!.toInt());
                                      },
                                      icon: Icon(
                                        CupertinoIcons.delete_simple,
                                        size: 20,
                                        color: AppColors.danger500,
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDeleteDialog(BuildContext context, int index, int id) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              getTranslated(context, LangConst.deleteQuestion).toString(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            actionsPadding: EdgeInsets.only(bottom: 16, right: 16),
            content: Text(
              getTranslated(context, LangConst.areYouSureToDeleteThis).toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  getTranslated(context, LangConst.cancelLabel).toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  serviceProvider.callDeleteService(index, id);
                },
                child: Text(
                  getTranslated(context, LangConst.deleteLabel).toString(),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.white,
                      ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger500,
                ),
              ),
            ],
          );
        });
  }
}
