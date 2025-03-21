import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Home/Provider/employee_provider.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/Profile%20Component/create_employee_screen.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Widgets/app_bar_back_icon.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  late EmployeeProvider employeeProvider;

  @override
  void initState() {
    super.initState();
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      employeeProvider.callGetEmployee();
      employeeProvider.callGetAllService();
    });
  }

  @override
  Widget build(BuildContext context) {
    employeeProvider = Provider.of<EmployeeProvider>(
      context,
    );
    return ModalProgressHUD(
      inAsyncCall: employeeProvider.employeeLoading,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: AppBarBack(),
          title: Text(
            getTranslated(context, LangConst.employeesLabel).toString(),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CreateEmployeeScreen(isEdit: false),
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
              TextFormField(
                cursorColor: AppColors.primarySwatch,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.icon,
                  ),
                  labelText: getTranslated(context, LangConst.searchLabel).toString(),
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Expanded(
                child: employeeProvider.employees.isEmpty && employeeProvider.employeeLoading == false
                    ? Center(
                        child: Text(getTranslated(context, LangConst.noDataFound).toString()),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: employeeProvider.employees.length,
                        padding: EdgeInsets.only(
                          top: Amount.screenMargin,
                        ),
                        separatorBuilder: (context, index) => Divider(
                          indent: 0,
                          endIndent: 0,
                        ),
                        itemBuilder: (context, index) {
                          EmployeeData data = employeeProvider.employees[index];
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CreateEmployeeScreen(
                                    isEdit: true,
                                    id: data.empId!.toInt(),
                                  ),
                                ),
                              );
                            },
                            titleAlignment: ListTileTitleAlignment.top,
                            contentPadding: EdgeInsets.zero,
                            leading: ExtendedImage.network(
                              data.imagePath! + data.image!,
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
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
                                      data.imagePath! + data.image!,
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      shape: BoxShape.circle,
                                    );
                                  case LoadState.failed:
                                    return CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage("assets/app/profile.png"),
                                    );
                                }
                              },
                            ),
                            title: Text(
                              "${data.name}",
                              style: TypographyMedium.textThemeLight.titleMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data.email}",
                                  style: TypographyRegular.textThemeLight.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.gray50,
                                  ),
                                ),
                                Text(
                                  "${data.phone}",
                                  style: TypographyRegular.textThemeLight.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.gray50,
                                  ),
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                showDeleteDialog(context, index, data.empId!.toInt());
                              },
                              icon: Icon(
                                CupertinoIcons.delete_simple,
                                color: AppColors.danger500,
                              ),
                            ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    employeeProvider.callDeleteEmployee(id, index);
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
              ),
            ],
          );
        });
  }
}
