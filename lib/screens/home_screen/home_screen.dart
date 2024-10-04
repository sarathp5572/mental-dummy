import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mentalhelth/screens/dash_borad_screen/provider/dash_board_provider.dart';
import 'package:mentalhelth/screens/edit_add_profile_screen/provider/edit_provider.dart';
import 'package:mentalhelth/screens/home_screen/provider/home_provider.dart';
import 'package:mentalhelth/screens/home_screen/widgets/chart_widget.dart';
import 'package:mentalhelth/screens/home_screen/widgets/home_menu/home_menu.dart';
import 'package:mentalhelth/screens/journal_view_screen/journal_view_screen.dart';
import 'package:mentalhelth/utils/logic/logic.dart';
import 'package:mentalhelth/utils/theme/app_decoration.dart';
import 'package:mentalhelth/widgets/background_image/background_imager.dart';
import 'package:mentalhelth/widgets/custom_elevated_button.dart';
import 'package:mentalhelth/widgets/indicatores_widgets.dart';
import 'package:mentalhelth/widgets/widget/shimmer.dart';
import 'package:provider/provider.dart';

import '../../utils/logic/shared_prefrence.dart';
import '../../utils/theme/custom_button_style.dart';
import '../../utils/theme/custom_text_style.dart';
import '../../utils/theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../auth/sign_in/provider/sign_in_provider.dart';
import '../goals_dreams_page/provider/goals_dreams_provider.dart';
import '../home_screen/widgets/userprofilelist_item_widget.dart';
import '../mental_strength_add_edit_screen/provider/mental_strenght_edit_provider.dart';
import '../token_expiry/tocken_expiry_warning_screen.dart';
import '../token_expiry/token_expiry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SignInProvider signInProvider;
  late HomeProvider homeProvider;
  late MentalStrengthEditProvider mentalStrengthEditProvider;
  late EditProfileProvider editProfileProvider;
  late DashBoardProvider dashBoardProvider;
  late GoalsDreamsProvider goalsDreamsProvider;
  bool tokenStatus = false;
  var logger = Logger();

  Future<void> _isTokenExpired() async {
      await homeProvider.fetchChartView(context);
      await homeProvider.fetchJournals(initial: true);
      await editProfileProvider.fetchUserProfile();
      // await homeProvider.fetchRemindersDetails();
      tokenStatus = TokenManager.checkTokenExpiry();
      if (tokenStatus) {
        setState(() {
          logger.e("Token status changed: $tokenStatus");
        });
        logger.e("Token status changed: $tokenStatus");
      }else{
        logger.e("Token status changedElse: $tokenStatus");
      }
  }

  @override
  void initState() {
    super.initState();
    signInProvider = Provider.of<SignInProvider>(context, listen: false);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    mentalStrengthEditProvider = Provider.of<MentalStrengthEditProvider>(context, listen: false);
    editProfileProvider = Provider.of<EditProfileProvider>(context, listen: false);
    dashBoardProvider = Provider.of<DashBoardProvider>(context, listen: false);
    goalsDreamsProvider = Provider.of<GoalsDreamsProvider>(context, listen: false);
    scheduleMicrotask(() {
      goalsDreamsProvider.goalsanddreams.clear();
      goalsDreamsProvider.goalsanddreams = [];
      mentalStrengthEditProvider.mediaSelected = -1;
      _isTokenExpired();
    });
  }
  @override
  Widget build(BuildContext context) {
    final signInProvider = Provider.of<SignInProvider>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return
      tokenStatus == false ?
      SafeArea(
      child: Consumer4<MentalStrengthEditProvider,HomeProvider, EditProfileProvider, DashBoardProvider>(
          builder: (context, mentalStrengthEditProvider,homeProvider, editProfileProvider,
              dashBoardProvider, _) {
        return backGroundImager(
          size: size,
          child: RefreshIndicator(
            onRefresh: () async {
              _isTokenExpired();
              homeProvider.fetchChartView(context);
              homeProvider.fetchJournals(initial: true);
              editProfileProvider.fetchUserProfile();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  _buildHeaderRow(
                      context, size, editProfileProvider, dashBoardProvider),
                  const SizedBox(
                    height: 12,
                  ),
                  _buildMessageColumn(context, size),
                  CustomElevatedButton(
                    onPressed: ()  {
                      dashBoardProvider.changePage(index: 1);
                      mentalStrengthEditProvider.fetchEmotions();
                    },
                    height: size.height * 0.06,
                    width: size.width * 0.85,
                    text: "Build your mental strength now",
                    buttonStyle: CustomButtonStyles.fillBlueBL10,
                    buttonTextStyle:
                        CustomTextStyles.titleSmallOnSecondaryContainer15,
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 1,
                      ),
                      child: Text(
                        "Your recent mental strength scores",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  const ChartWidget(),
                  const SizedBox(
                    height: 1,
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 1,
                      ),
                      child: Text(
                        "2024",
                        style: CustomTextStyles.titleMediumBlue300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    width: 324,
                    margin: const EdgeInsets.only(left: 1, right: 10),
                    child: Text(
                      "You average mental strength according to the last 7 entries is 4 out of 5. keep tracking...",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodyMediumOnPrimary14,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 1,
                      ),
                      child: Text(
                        "Your recent Journals",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  homeProvider.journalsModel == null?

                const SizedBox():
                  _buildUserProfileList(context, size, homeProvider),
                  const SizedBox(
                    height: 4,
                  ),
                  homeProvider.journalsModel == null
                      ? const SizedBox()
                      : (homeProvider.journalsModel?.journals?.length ?? 0) < 0
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                dashBoardProvider.changePage(index: 2);
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 1,
                                  ),
                                  child: Text(
                                    "View more ...",
                                    style: CustomTextStyles.bodySmallPrimary,
                                  ),
                                ),
                              ),
                            ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    )
          : const TokenExpireScreen();
  }

  /// Section Widget
  Widget _buildHeaderRow(
      BuildContext context,
      Size size,
      EditProfileProvider editProfileProvider,
      DashBoardProvider dashBoardProvider) {
    return editProfileProvider.getProfileModel == null
        ? const SizedBox(
      height: 70,
    )
        : Padding(
            padding: const EdgeInsets.only(
              left: 1,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    dashBoardProvider.changeCommentPage(index: 8);
                  },
                  child: CustomImageView(
                    imagePath: editProfileProvider.getProfileModel?.profileurl
                        .toString() ?? "",
                    height: 58,
                    width: 58,
                    radius: BorderRadius.circular(
                      34,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    top: 21,
                    bottom: 21,
                  ),
                  child: Text(
                    capitalText(editProfileProvider.getProfileModel == null
                        ? ""
                        : editProfileProvider.getProfileModel!.firstname
                            .toString()),
                    style: CustomTextStyles.bodyLarge18,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => buildPopupDialog(
                        context,
                        size,
                      ),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: PrimaryColors().blue300,
                    radius: size.width * 0.04,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: size.height * 0.003,
                          width: size.width * 0.03,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Container(
                          height: size.height * 0.003,
                          width: size.width * 0.03,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  /// Section Widget
  Widget _buildMessageColumn(BuildContext context, Size size) {
    return Container(
      height: size.height * 0.06,
      width: size.width * 0.85,
      // padding: EdgeInsets.symmetric(
      //     horizontal: size.width * 0.2, vertical: size.width * 0.027),
      decoration: AppDecoration.outlineBlue.copyWith(
        borderRadius: BorderRadiusStyle.customBorderTL10,
      ),
      child: Center(
        child: Text(
          "Whats on your mind now?",
          style: CustomTextStyles.bodyMediumGray50001,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfileList(
      BuildContext context, Size size, HomeProvider homeProvider) {
    var logger = Logger();
    return Padding(
      padding: const EdgeInsets.only(left: 1),
      child: homeProvider.journalsModelLoading
          ? shimmerList(
              height: size.height * 0.5,
              list: 4,
              shimmerHeight: size.height * 0.07,
            )
          : homeProvider.journalsModel == null
              ? SizedBox(
                  height: size.height * 0.2,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: homeProvider.noDataPageController,
                        itemCount: homeProvider.noDataImageList.length,
                        itemBuilder: (context, index) {
                          // return Image.asset(homeProvider.noDataImageList[index]);
                          return
                            CustomImageView(
                            fit: BoxFit.cover,
                            imagePath: homeProvider.noDataImageList[index],
                            height: size.height * 0.27,
                            width: size.width,
                            alignment: Alignment.center,
                          );
                        },
                        onPageChanged: (int pageIndex) {
                          homeProvider.noDataIndexChangeFunction(pageIndex);
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          width: homeProvider.noDataImageList.length *
                              size.width *
                              0.1,
                          child: buildIndicators(
                            homeProvider.noDataImageList.length,
                            homeProvider.noDataCurrentIndex,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 3);
                  },
                  itemCount: homeProvider.journalsModel!.journals!.length < 4
                      ? homeProvider.journalsModel!.journals!.length
                      : 4,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => JournalViewScreen(
                              journalId: homeProvider
                                  .journalsModelList[index].journalId
                                  .toString(),
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: UserProfileListItemWidget(
                        title: homeProvider.journalsModel!.journals![index].journalDesc!,
                        date: homeProvider.journalsModel!.journals![index].journalDatetime!,
                        image: homeProvider.journalsModel!.journals![index].displayImage!,
                      ),
                    );

                  },
                ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: PrimaryColors().blue300,
            ),
            child: const Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Handle item 1 tap
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Handle item 2 tap
              Navigator.pop(context); // Close the drawer
            },
          ),
          // Add more ListTile widgets for additional items
        ],
      ),
    );
  }
}
