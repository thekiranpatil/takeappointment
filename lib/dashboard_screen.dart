import 'package:multibusiness_business_app_flutter/Appointment/appointments_screen.dart';
import 'package:multibusiness_business_app_flutter/Clients/clients_screen.dart';
import 'package:multibusiness_business_app_flutter/Home/home_screen.dart';
import 'package:multibusiness_business_app_flutter/Localization/localization_constant.dart';
import 'package:multibusiness_business_app_flutter/Profile/profile_screen.dart';
import 'package:multibusiness_business_app_flutter/Theme/colors.dart';
import 'package:multibusiness_business_app_flutter/Utils/lang_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AppointmentsScreen(),
    ClientsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? Icons.water_damage_rounded : Icons.water_damage_outlined,
            ),
            label: getTranslated(context, LangConst.homeLabel).toString(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1 ? CupertinoIcons.briefcase_fill : CupertinoIcons.briefcase,
            ),
            label: getTranslated(context, LangConst.appointment).toString(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 2 ? CupertinoIcons.person_2_fill : CupertinoIcons.person_2,
            ),
            label: getTranslated(context, LangConst.clientsLabel).toString(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3 ? CupertinoIcons.person_crop_square_fill : CupertinoIcons.person_crop_square,
            ),
            label: getTranslated(context, LangConst.profile).toString(),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primarySwatch,
        onTap: _onItemTapped,
        unselectedItemColor: AppColors.neutral800,
        elevation: 4,
      ),
    );
  }
}
