import 'package:multibusiness_business_app_flutter/Appointment/Provider/appointments_provider.dart';
import 'package:multibusiness_business_app_flutter/Authentication/Provider/auth_provider.dart';
import 'package:multibusiness_business_app_flutter/Home/Model/all_employee_response.dart';
import 'package:multibusiness_business_app_flutter/Home/Provider/employee_provider.dart';
import 'package:multibusiness_business_app_flutter/Home/appointment_details_screen.dart';
import 'package:multibusiness_business_app_flutter/Home/book_appointment_screen.dart';
import 'package:multibusiness_business_app_flutter/Home/notification_screen.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Theme/theme.dart';
import 'package:multibusiness_business_app_flutter/Utils/device_utils.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:multibusiness_business_app_flutter/Utils/preferences_names.dart';
import 'package:multibusiness_business_app_flutter/Utils/shared_preferences.dart';
import 'package:multibusiness_business_app_flutter/Widgets/approved_appointment_tab.dart';
import 'package:multibusiness_business_app_flutter/Widgets/constant_widget.dart';
import 'package:multibusiness_business_app_flutter/Widgets/pending_appointment_tab.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:zoom_widget/zoom_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool isCalender = true;

  late TabController _tabController;
  late EmployeeProvider employeeProvider;
  late AppointmentsProvider appointmentsProvider;
  late AuthProvider authProvider;
  @override
  void initState() {
    super.initState();
    employeeProvider = Provider.of<EmployeeProvider>(context, listen: false);
    appointmentsProvider = Provider.of<AppointmentsProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    Future.delayed(Duration.zero, () {
      employeeProvider.callGetEmployee();
      appointmentsProvider.callHomeAllAppointment();
      appointmentsProvider.callCalendarAppointment();
      authProvider.callSetting();
      authProvider.callGetExpiredDate();
    });
    _tabController = TabController(length: 2, vsync: this);
    SharedPreferenceHelper.setBoolean(
        PreferencesNames.notificationPermissionDialog, OneSignal.Notifications.permission == false ? true : false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    employeeProvider = Provider.of<EmployeeProvider>(context);
    appointmentsProvider = Provider.of<AppointmentsProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: employeeProvider.employeeLoading,
      progressIndicator: SpinKitThreeBounce(
        color: AppColors.primarySwatch,
        size: 50.0,
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: Text(
              getTranslated(context, LangConst.homeLabel).toString(),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(
                  right: Amount.screenMargin,
                  left: Amount.screenMargin,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ),
                    );
                  },
                  icon: CircleAvatar(
                    radius: 20,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.light ? AppColors.neutral100 : AppColors.transparent,
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Theme.of(context).brightness == Brightness.light ? AppColors.gray700 : AppColors.gray50,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: Amount.screenMargin,
                  left: Amount.screenMargin,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCalender = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isCalender == true ? AppColors.purple500 : AppColors.transparent,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                          border: Border.all(
                            color: Theme.of(context).brightness == Brightness.light
                                ? AppColors.neutral700
                                : AppColors.gray50,
                          ),
                        ),
                        child: Icon(
                          Icons.calendar_month,
                          color: isCalender == true ? AppColors.white : AppColors.gray50,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCalender = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isCalender == false ? AppColors.purple500 : AppColors.transparent,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                          border: Border.all(
                            color: Theme.of(context).brightness == Brightness.light
                                ? AppColors.neutral700
                                : AppColors.gray50,
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.square_favorites,
                          color: isCalender == false ? AppColors.white : AppColors.gray50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isCalender,
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: Amount.screenMargin,
                          right: Amount.screenMargin,
                        ),
                        child: Text(
                          getTranslated(context, LangConst.businessSpecialists).toString(),
                          style: Theme.of(context).brightness == Brightness.light
                              ? TypographySemibold.textThemeLight.bodyMedium
                              : TypographySemibold.textThemeDark.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: employeeProvider.employees.isEmpty
                            ? Center(
                                child: Text(getTranslated(context, LangConst.noDataFound).toString()),
                              )
                            : ListView.separated(
                                itemCount: employeeProvider.employees.length,
                                padding: const EdgeInsets.only(
                                  left: Amount.screenMargin,
                                  top: 10,
                                  right: Amount.screenMargin,
                                ),
                                separatorBuilder: (context, index) => WidthBox(15),
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  EmployeeData data = employeeProvider.employees[index];
                                  return Container(
                                    width: 80,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: AppBorderRadius.k08,
                                      border: Border.all(
                                        color: Theme.of(context).brightness == Brightness.light
                                            ? AppColors.neutral700
                                            : AppColors.gray50,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        ExtendedImage.network(
                                          data.imagePath! + data.image!,
                                          fit: BoxFit.cover,
                                          height: 45,
                                          width: 45,
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
                                                  height: 45,
                                                  width: 45,
                                                  fit: BoxFit.cover,
                                                  shape: BoxShape.circle,
                                                );
                                              case LoadState.failed:
                                                return CircleAvatar(
                                                  radius: 22,
                                                  backgroundImage: AssetImage("assets/app/profile.png"),
                                                );
                                            }
                                          },
                                        ),
                                        HeightBox(8),
                                        Text(
                                          "${data.name}",
                                          style: Theme.of(context).brightness == Brightness.light
                                              ? TypographyMedium.textThemeLight.labelMedium
                                              : TypographyMedium.textThemeDark.labelMedium,
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: Amount.screenMargin,
                          ),
                          child: Zoom(
                            backgroundColor: AppColors.transparent,
                            canvasColor: AppColors.transparent,
                            maxZoomHeight: MediaQuery.of(context).size.height,
                            maxZoomWidth: MediaQuery.of(context).size.width,
                            doubleTapZoom: true,
                            opacityScrollBars: 00,
                            child: SfCalendar(
                              backgroundColor: AppColors.transparent,
                              view: CalendarView.month,
                              cellBorderColor: Theme.of(context).brightness == Brightness.light
                                  ? AppColors.gray700
                                  : AppColors.gray50,
                              onTap: (calendarTapDetails) {
                                if ((calendarTapDetails.appointments?.length ?? 0) > 0)
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: Container(
                                            child: new Text(
                                              DeviceUtils.convertShortMonthNameWYr(calendarTapDetails.date.toString()),
                                              style: TextStyle(
                                                color: Theme.of(context).brightness == Brightness.light
                                                    ? AppColors.gray700
                                                    : AppColors.gray50,
                                              ),
                                            ),
                                          ),
                                          content: SizedBox(
                                            width: MediaQuery.of(context).size.width,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: calendarTapDetails.appointments!.length,
                                                  itemBuilder: (context, index) => ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (context) => AppointmentDetailsScreen(
                                                            id: calendarTapDetails.appointments![index].appointmentID,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "${calendarTapDetails.appointments![index].eventName.toString()}",
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ));
                                    },
                                  );
                              },
                              firstDayOfWeek: 1,
                              weekNumberStyle: WeekNumberStyle(
                                  textStyle: TypographyMedium.textThemeLight.labelMedium,
                                  backgroundColor: Colors.green),
                              dataSource: MeetingDataSource(_getDataSource()),
                              monthViewSettings:
                                  MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                              minDate: DateTime(1990),
                              todayHighlightColor: AppColors.primarySwatch,
                              headerStyle: const CalendarHeaderStyle(
                                textAlign: TextAlign.center,
                              ),
                              todayTextStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isCalender == false ? true : false,
                child: Expanded(
                  child: Column(
                    children: [
                      HeightBox(8),
                      TabBar(
                        controller: _tabController,
                        indicatorColor: AppColors.purple500,
                        labelStyle: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                        unselectedLabelStyle: TypographyMedium.textThemeLight.titleSmall!.copyWith(
                          color: AppColors.gray50,
                          fontWeight: FontWeight.w400,
                        ),
                        indicator: BoxDecoration(
                          color: AppColors.purple500,
                          borderRadius: AppBorderRadius.k04,
                        ),
                        indicatorPadding: EdgeInsets.only(
                          top: 5,
                          bottom: 5,
                        ),
                        padding: EdgeInsets.only(
                          left: Amount.screenMargin,
                          right: Amount.screenMargin,
                        ),
                        tabs: [
                          Tab(
                            text: getTranslated(context, LangConst.pendingLabel).toString(),
                          ),
                          Tab(
                            text: getTranslated(context, LangConst.approvedLabel).toString(),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            PendingAppointmentTab(),
                            ApprovedAppointmentTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: isCalender
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BookAppointmentScreen(),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.calendar_month,
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    for (int i = 0; i < appointmentsProvider.calenderAppointments.length; i++) {
      var formattedStartDate = DateFormat("yyyy-MM-dd").parse(appointmentsProvider.calenderAppointments[i].date!);
      final DateTime startTime = DateTime(formattedStartDate.year, formattedStartDate.month, formattedStartDate.day);
      final DateTime endTime = startTime.add(const Duration(hours: 2));
      meetings.add(
        Meeting(
          appointmentsProvider.calenderAppointments[i].userDetails != null
              ? appointmentsProvider.calenderAppointments[i].userDetails!.name!
              : "",
          startTime,
          endTime,
          AppColors.primarySwatch,
          false,
          appointmentsProvider.calenderAppointments[i].id!.toInt(),
          appointmentsProvider.calenderAppointments[i].bookingId.toString(),
        ),
      );
    }
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  bool appointmentID(int index) {
    return appointments![index].id;
  }

  bool bookingID(int index) {
    return appointments![index].bookingId;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay, this.appointmentID, this.bookingID);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  num appointmentID;
  String bookingID;
}
