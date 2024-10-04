import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mentalhelth/screens/auth/sign_in/screen_sign_in.dart';
import 'package:mentalhelth/screens/auth/subscribe_plan_page/subscribe_plan_page.dart';
import 'package:mentalhelth/screens/dash_borad_screen/dash_board_screen.dart';
import 'package:mentalhelth/screens/edit_add_profile_screen/provider/edit_provider.dart';
import 'package:mentalhelth/screens/home_screen/provider/home_provider.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/utils/logic/shared_prefrence.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? getSubScribed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        Future.microtask(() async {
          getSubScribed = await getUserSubScribeSharePref();
          await init();
        }).whenComplete(() {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            if (getSubScribed != null) {
              if (getSubScribed.toString() == "0") {
                return SubscribePlanPage();
              } else if (getSubScribed.toString() == "1") {
                return const DashBoardScreen();
              } else {
                return ScreenSignIn();
              }
            } else {
              return ScreenSignIn();
            }
          }));
        });
      } catch (e) {
        init();
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          if (getSubScribed != null) {
            if (getSubScribed.toString() == "0") {
              return SubscribePlanPage();
            } else {
              return const DashBoardScreen();
            }
          } else {
            return ScreenSignIn();
          }
        }));
      }
    });
  }

  Future<void> init() async {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    EditProfileProvider editProfileProvider =
        Provider.of<EditProfileProvider>(context, listen: false);
    homeProvider.fetchChartView(context);
    //homeProvider.fetchJournals(initial: true);
    editProfileProvider.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(
          30,
        ),
        child: SvgPicture.asset(
          ImageConstant.logo,
        ),
      ),
    );
  }
}
