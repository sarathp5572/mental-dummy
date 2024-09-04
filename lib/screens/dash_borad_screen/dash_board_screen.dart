import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mentalhelth/screens/addgoals_dreams_screen/provider/ad_goals_dreams_provider.dart';
import 'package:mentalhelth/screens/dash_borad_screen/provider/dash_board_provider.dart';
import 'package:mentalhelth/screens/edit_add_profile_screen/provider/edit_provider.dart';
import 'package:mentalhelth/screens/home_screen/provider/home_provider.dart';
import 'package:mentalhelth/screens/journal_list_screen/provider/journal_list_provider.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/provider/mental_strenght_edit_provider.dart';
import 'package:mentalhelth/utils/theme/colors.dart';
import 'package:mentalhelth/widgets/functions/popup.dart';
import 'package:provider/provider.dart';

import '../../utils/core/image_constant.dart';
import '../../utils/theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer6<
            DashBoardProvider,
            MentalStrengthEditProvider,
            JournalListProvider,
            EditProfileProvider,
            HomeProvider,
            AdDreamsGoalsProvider>(
        builder: (context,
            dashBoardProvider,
            mentalStrengthEditProvider,
            journalListProvider,
            editProfileProvider,
            homeProvider,
            adDreamsGoalsProvider,
            _) {
      return PopScope(
        canPop: false,
        onPopInvoked: (value) {
          customPopup(
            context: context,
            onPressedDelete: () async {
              if (!value) {
                exit(0);
              }
            },
            yes: "Yes",
            title: 'Do you Need Exit',
            content: 'Are you sure do you need Exit',
          );
        },
        child: Scaffold(
          body: dashBoardProvider.getPage(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorsContent.primaryColor,
            selectedFontSize: 0,
            elevation: 0,
            currentIndex: dashBoardProvider.currentIndex,
            onTap: (index) async {
              dashBoardProvider.changePage(index: index);
              if (index == 0) {
                if (homeProvider.chartViewModel == null) {
                  homeProvider.fetchChartView(context);
                }
              } else if (index == 1) {
                mentalStrengthEditProvider.clearAllValuesInSaveTime();
                adDreamsGoalsProvider.clearAction();
                mentalStrengthEditProvider.openAllCloser();
                await mentalStrengthEditProvider.fetchEmotions();
                await editProfileProvider.fetchUserProfile();
              } else if (index == 2) {
                await journalListProvider.fetchJournalChartView();
                await homeProvider.fetchJournals(initial: true);
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: CustomImageView(
                  imagePath: ImageConstant.imgHome,
                  height: 24,
                  width: 24,
                  color: theme.colorScheme.primary.withOpacity(1),
                ),
                activeIcon: SvgPicture.asset(
                  ImageConstant.imgHome,
                  // ignore: deprecated_member_use
                  color: ColorsContent.primaryColor,
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: CustomImageView(
                  imagePath: ImageConstant.imgSettings,
                  height: 24,
                  width: 24,
                  color: theme.colorScheme.primary.withOpacity(1),
                ),
                activeIcon: SvgPicture.asset(
                  ImageConstant.imgSettings,
                  // ignore: deprecated_member_use
                  color: ColorsContent.primaryColor,
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: CustomImageView(
                  imagePath: ImageConstant.imgMegaphone,
                  height: 24,
                  width: 24,
                  color: theme.colorScheme.primary.withOpacity(1),
                ),
                activeIcon: SvgPicture.asset(
                  ImageConstant.imgMegaphone,
                  // ignore: deprecated_member_use
                  color: ColorsContent.primaryColor,
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: CustomImageView(
                  imagePath: ImageConstant.imgArrowDown,
                  height: 24,
                  width: 24,
                  color: theme.colorScheme.primary.withOpacity(1),
                ),
                activeIcon: SvgPicture.asset(
                  ImageConstant.imgArrowDown,
                  // ignore: deprecated_member_use
                  color: ColorsContent.primaryColor,
                  height: 24,
                  width: 24,
                  fit: BoxFit.contain,
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    });
  }
}
