import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:mentalhelth/screens/dash_borad_screen/provider/dash_board_provider.dart';
import 'package:mentalhelth/screens/edit_add_profile_screen/provider/edit_provider.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/screens/add_action/add_action_mental_strength.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/screens/choose_action/choose_action.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/screens/choose_goal/choose_goal.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/widgets/googlemap_widget/google_map_widget.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/widgets/popup/audio_popup.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/widgets/popup/camera_popup.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/widgets/popup/gallary_popup.dart';
import 'package:mentalhelth/utils/logic/logic.dart';
import 'package:mentalhelth/utils/theme/custom_button_style.dart';
import 'package:mentalhelth/widgets/background_image/background_imager.dart';
import 'package:mentalhelth/widgets/custom_elevated_button.dart';
import 'package:mentalhelth/widgets/custom_icon_button.dart';
import 'package:mentalhelth/widgets/custom_text_form_field.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';
import 'package:mentalhelth/widgets/widget/shimmer.dart';
import 'package:provider/provider.dart';

import '../../utils/core/image_constant.dart';
import '../../utils/logic/date_format.dart';
import '../../utils/theme/colors.dart';
import '../../utils/theme/custom_text_style.dart';
import '../../utils/theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/custom_image_view.dart';
import '../../widgets/custom_rating_bar.dart';
import '../../widgets/functions/popup.dart';
import '../auth/sign_in/provider/sign_in_provider.dart';
import '../home_screen/provider/home_provider.dart';
import '../token_expiry/tocken_expiry_warning_screen.dart';
import '../token_expiry/token_expiry.dart';
import 'model/emotions_model.dart';
import 'provider/mental_strenght_edit_provider.dart';
import 'screens/action_full_view_mental_helth/action_full_view_journal.dart';
import 'screens/add_goals_and_dreams_widget/add_goals_and_dreams_mental_strength.dart';
import 'screens/goals_and_dreams_full_view/goals_and_dreams_full_view_screen.dart';

class MentalStrengthAddEditFullViewScreen extends StatefulWidget {
  const MentalStrengthAddEditFullViewScreen({Key? key}) : super(key: key,);

  @override
  _MentalStrengthAddEditFullViewScreenState createState() =>
      _MentalStrengthAddEditFullViewScreenState();
}
class _MentalStrengthAddEditFullViewScreenState extends State<MentalStrengthAddEditFullViewScreen> {
  late HomeProvider homeProvider;
  late MentalStrengthEditProvider mentalStrengthEditProvider;
  late EditProfileProvider editProfileProvider;
  late DashBoardProvider dashBoardProvider;
  bool tokenStatus = false;
  var logger = Logger();

  Future<void> _isTokenExpired() async {
    await homeProvider.fetchJournals(initial: true);
  //  await editProfileProvider.fetchUserProfile();
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
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    mentalStrengthEditProvider = Provider.of<MentalStrengthEditProvider>(context, listen: false);
    editProfileProvider = Provider.of<EditProfileProvider>(context, listen: false);
    dashBoardProvider = Provider.of<DashBoardProvider>(context, listen: false);
    scheduleMicrotask(() {
      mentalStrengthEditProvider.mediaSelected = -1;
      _isTokenExpired();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    var logger = Logger();
    Size size = MediaQuery.of(context).size;
    return
      tokenStatus == false ?
      SafeArea(
      child: backGroundImager(
        size: size,
        padding: EdgeInsets.zero,
        child: Consumer3<EditProfileProvider, MentalStrengthEditProvider,
                DashBoardProvider>(
            builder: (contexts, editProfileProvider, mentalStrengthEditProvider,
                dashBoardProvider, _) {
          return GestureDetector(
            onTap: () {
              mentalStrengthEditProvider.openAllCloser();
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                buildAppBar(
                  context,
                  size,
                  heading: "Build your mental strength",
                  onTap: () {
                    homeProvider.fetchJournals(initial: true);
                    dashBoardProvider.changePage(index: 0);
                  },
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: size.width * 0.05,
                          right: size.width * 0.05,
                        ),
                        color: mentalStrengthEditProvider.openChooseGoal
                            ? Colors.blue[50]
                            : null,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: size.height * 0.04,
                                backgroundColor: Colors.grey[300],
                                child: CustomImageView(
                                  imagePath:
                                      editProfileProvider.profileUrl.toString(),
                                  height: size.height * 0.1,
                                  width: size.height * 0.1,
                                  radius: BorderRadius.circular(54),
                                  alignment: Alignment.center,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              editProfileProvider.getProfileModel == null
                                  ? const SizedBox()
                                  : Text(
                                      editProfileProvider
                                          .getProfileModel!.firstname
                                          .toString(),
                                      style: CustomTextStyles.bodyLarge18,
                                    ),
                              editProfileProvider.getProfileModel == null
                                  ? const SizedBox()
                                  : Text(
                                      capitalText(
                                        editProfileProvider
                                                        .getProfileModel?.dob ==
                                                    null ||
                                                editProfileProvider
                                                        .getProfileModel?.dob ==
                                                    null
                                            ? ""
                                            : dateTimeFormatterMain(
                                                date: editProfileProvider
                                                    .getProfileModel!.dob
                                                    .toString(),
                                              ),
                                      ),
                                      style: CustomTextStyles.bodyMediumGray700,
                                    ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                "Whats on your mind?",
                                style: theme.textTheme.bodyLarge,
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              _buildDescriptionEditText(
                                  context, mentalStrengthEditProvider),
                              SizedBox(height: size.height * 0.03),
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup27,
                                height: 33,
                                width: 5,
                                fit: BoxFit.cover,
                              ),
                              _buildAddMediaColumn(
                                context,
                                size,
                              ),
                              SizedBox(height: size.height * 0.03),

                              // mentalStrengthEditProvider.mediaSelected == 3
                              //     ? const MentalGoogleMap()
                              //     : const SizedBox(),
                              const SizedBox(
                                height: 30,
                              ),
                              // CustomImageView(
                              //   imagePath: ImageConstant.imgGroup28,
                              //   height: 19,
                              //   width: 5,
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomIconButton(
                                height: size.height * 0.08,
                                width: size.height * 0.08,
                                padding: const EdgeInsets.all(
                                  11,
                                ),
                                decoration: IconButtonStyleHelper.fillBlue,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgLightBulb,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup28,
                                height: 19,
                                width: 5,
                              ),
                              SizedBox(height: size.height * 0.03),
                              Text(
                                "Rate how you are feeling now?",
                                style: theme.textTheme.bodyLarge,
                              ),
                              SizedBox(height: size.height * 0.01),
                              CustomRatingBar(
                                initialRating: mentalStrengthEditProvider
                                    .emotionalValueStar,
                                itemSize: 34,
                                color: Colors.blue,
                                onRatingUpdate: (value) {
                                  logger.w("mentalStrengthEditProvider.emotionalValueStar");
                                  mentalStrengthEditProvider
                                      .changeEmotionalValueStar(value);
                                  _isTokenExpired();
                                },
                              ),
                              SizedBox(height: size.height * 0.01),
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup29,
                                height: 33,
                                width: 5,
                              ),
                              SizedBox(height: size.height * 0.03),
                              Text(
                                "What is your emotional state?",
                                style: theme.textTheme.bodyLarge,
                              ),
                              SizedBox(height: size.height * 0.01),
                              mentalStrengthEditProvider.getEmotionsModel ==
                                      null
                                  ? const SizedBox()
                                  :Container(
                                width: size.width * 0.60, // This controls the button width
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey, // Border color
                                    width: 1.0,         // Border width
                                  ),
                                  borderRadius: BorderRadius.circular(15.0), // Border radius for rounded corners
                                  color: Colors.white, // Background color (optional)
                                ),
                                child: Center(
                                  child: DropdownButton(
                                    underline: const SizedBox(),
                                    elevation: 0,
                                    value: mentalStrengthEditProvider.emotionValue,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: mentalStrengthEditProvider
                                        .getEmotionsModel!.emotions!
                                        .map((Emotion items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: SizedBox(
                                          width: 190, // Set the desired width for the dropdown list items here
                                          child: Text(
                                            items.title.toString(),
                                            style: TextStyle(
                                              color: ColorsContent.primaryColor, // Change to your desired color
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (Emotion? newValue) {
                                      mentalStrengthEditProvider
                                          .addEmotionValue(newValue ?? Emotion());

                                      _isTokenExpired();
                                      // setState(() {
                                      //   mentalStrengthEditProvider.emotionValue = newValue!;
                                      // });
                                    },
                                  ),
                                ),
                              ),

                              SizedBox(height: size.height * 0.03),
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup29,
                                height: 33,
                                width: 5,
                              ),
                              SizedBox(height: size.height * 0.03),
                              Text(
                                "Do you like your reaction to the situation?",
                                style: theme.textTheme.bodyLarge,
                              ),
                              SizedBox(height: size.height * 0.01),
                              CustomRatingBar(
                                initialRating:
                                    mentalStrengthEditProvider.driveValueStar,
                                itemSize: 34,
                                color: Colors.blue,
                                onRatingUpdate: (value) {
                                  mentalStrengthEditProvider
                                      .changeDriveValueStar(value);

                                  _isTokenExpired();
                                },
                              ),
                              SizedBox(height: size.height * 0.03),
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup29,
                                height: 33,
                                width: 5,
                              ),
                              SizedBox(height: size.height * 0.03),
                              Text(
                                "Which goal is affected by your reaction?",
                                style: theme.textTheme.bodyLarge,
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _isTokenExpired();
                                  mentalStrengthEditProvider
                                      .openChooseGoalFunction();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  "Choose Goal",
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              mentalStrengthEditProvider.goalsValue.id == null
                                  ? const SizedBox()
                                  : Container(
                                      height: size.height * 0.04,
                                      width: size.width * 0.7,
                                      padding: const EdgeInsets.only(
                                        bottom: 5,
                                        top: 5,
                                        left: 5,
                                        right: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            100), // Makes it circular
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              customPopup(
                                                context: context,
                                                onPressedDelete: () async {
                                                  mentalStrengthEditProvider
                                                      .cleaGoalValue();
                                                  Navigator.of(context).pop();

                                                  // Close the bottom sheet after deleting
                                                //  Navigator.of(context).pop();  // This will close the galleryBottomSheet as well
                                                },
                                                yes: "Yes",
                                                title: 'Do you Need Delete',
                                                content: 'Are you sure do you need delete',
                                              );

                                            },
                                            child: CircleAvatar(
                                              radius: size.width * 0.04,
                                              backgroundColor: Colors.blue,
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: size.width * 0.03,
                                              ),
                                            ),
                                          ),
                                          Container(
                                           // color: Colors.red,
                                            width: size.width * 0.40,
                                            child: Text(
                                              'mentalStrengthEditProvider.goalsValue.title.toString()',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 3, // Set the maximum number of lines to 3
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              mentalStrengthEditProvider
                                                  .openGoalViewSheetFunction();
                                              mentalStrengthEditProvider
                                                  .fetchGoalDetails(
                                                goalId:
                                                    mentalStrengthEditProvider
                                                        .goalsValue.id
                                                        .toString(),
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: size.width * 0.04,
                                              backgroundColor: Colors.blue,
                                              child: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Colors.white,
                                                size: size.width * 0.03,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup29,
                                height: 33,
                                width: 5,
                              ),
                              SizedBox(height: size.height * 0.03),
                              Text(
                                "Select an action?",
                                style: theme.textTheme.bodyLarge,
                              ),
                              SizedBox(height: size.height * 0.03),
                              ElevatedButton(
                                onPressed: () {
                                  if (mentalStrengthEditProvider
                                          .goalsValue.id ==
                                      null) {
                                    showCustomSnackBar(
                                      context: context,
                                      message: "Please choose your goal",
                                    );
                                  } else {
                                    _isTokenExpired();
                                    mentalStrengthEditProvider
                                        .openChooseActionFunction();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  "Choose Action",
                                  style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              SizedBox(
                                height: mentalStrengthEditProvider
                                        .actionList.length *
                                    size.height *
                                    0.045,
                                width: size.width * 0.7,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: mentalStrengthEditProvider
                                      .actionList.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: size.height * 0.04,
                                      width: size.width * 0.7,
                                      padding: const EdgeInsets.only(
                                        bottom: 5,
                                        top: 5,
                                        left: 5,
                                        right: 5,
                                      ),
                                      margin: const EdgeInsets.only(
                                        bottom: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            100), // Makes it circular
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              customPopup(
                                                context: context,
                                                onPressedDelete: () async {
                                                  mentalStrengthEditProvider
                                                      .clearActionListSelected(
                                                    index: index,
                                                  );
                                                  Navigator.of(context).pop();

                                                  // Close the bottom sheet after deleting
                                                  //  Navigator.of(context).pop();  // This will close the galleryBottomSheet as well
                                                },
                                                yes: "Yes",
                                                title: 'Do you Need Delete',
                                                content: 'Are you sure do you need delete',
                                              );

                                            },
                                            child: CircleAvatar(
                                              radius: size.width * 0.04,
                                              backgroundColor: Colors.blue,
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: size.width * 0.03,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            mentalStrengthEditProvider
                                                .actionList[index].title
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              mentalStrengthEditProvider
                                                  .openActionFullViewFunction();
                                              await mentalStrengthEditProvider
                                                  .fetchActionDetails(
                                                actionId:
                                                    mentalStrengthEditProvider
                                                        .actionList[index].id
                                                        .toString(),
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: size.width * 0.04,
                                              backgroundColor: Colors.blue,
                                              child: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                color: Colors.white,
                                                size: size.width * 0.03,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              CustomElevatedButton(
                                loading: mentalStrengthEditProvider
                                    .saveJournalLoading,
                                onPressed: () async {
                                  await mentalStrengthEditProvider
                                      .saveButtonFunction(context);
                                  _isTokenExpired();
                                },
                                height: 65,
                                text: "SAVE",
                                buttonStyle: CustomButtonStyles.fillBlueTL13,
                                buttonTextStyle:
                                    CustomTextStyles.titleLargeGray50,
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                            ],
                          ),
                        ),
                      ),
                      mentalStrengthEditProvider.openChooseGoal
                          ? const ScreenChooseGoalMentalStrength()
                          : const SizedBox(),
                      mentalStrengthEditProvider.openAddGoal
                          ? const AddGoalsDreamsBottomSheet()
                          : const SizedBox(),
                      mentalStrengthEditProvider.openGoalViewSheet
                          ? mentalStrengthEditProvider.goalDetailModel == null
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: appTheme.gray50,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(
                                        25,
                                      ),
                                      topLeft: Radius.circular(
                                        25,
                                      ),
                                    ),
                                  ),
                                  margin: EdgeInsets.only(
                                    top: size.height * 0.15,
                                  ),
                                  child: shimmerList(
                                    height: size.height * 0.8,
                                    list: 10,
                                  ),
                                )
                              : GoalAndDreamFullViewBottomSheet(
                                  goalDetailModel: mentalStrengthEditProvider
                                      .goalDetailModel!,
                                )
                          : const SizedBox(),
                      mentalStrengthEditProvider.openChooseAction
                          ? ChooseActionMentalHelth(
                              goal: mentalStrengthEditProvider.goalsValue,
                            )
                          : const SizedBox(),
                      mentalStrengthEditProvider.openAddAction
                          ? AddActionMentalStrengthBottomSheet(
                              goalId: mentalStrengthEditProvider.goalsValue.id
                                  .toString(),
                            )
                          : const SizedBox(),
                      mentalStrengthEditProvider.openActionFullView
                          ? const ActionFullViewJournalCreateBottomSheet()
                          : const SizedBox()
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    ):
      const TokenExpireScreen();
  }

  /// Section Widget
  Widget _buildDescriptionEditText(BuildContext context,
      MentalStrengthEditProvider mentalStrengthEditProvider) {
    return CustomTextFormField(
      textAlign: TextAlign.center,
      controller: mentalStrengthEditProvider.descriptionEditTextController,
      hintText: "I just feel excited now, hope it will be an amazing day.",
      hintStyle: CustomTextStyles.bodySmallGray700,
      textInputAction: TextInputAction.done,
      maxLines: 4,
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
      // ], // Ensure this is correctly passed
    );
  }




  Widget _buildAddMediaColumn(BuildContext context, Size size) {
    return Consumer<MentalStrengthEditProvider>(
        builder: (context, mentalStrengthEditProvider, _) {
      return Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Media",
              style: theme.textTheme.titleSmall,
            ),
            const SizedBox(
              height: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height * 0.09,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _isTokenExpired();
                          mentalStrengthEditProvider.selectedMedia(0);
                          await audioBottomSheet(
                            context: context,
                            title: 'Record Audio',
                          );
                        },
                        child: Container(
                          height: size.height * 0.08,
                          width: size.height * 0.08,
                          decoration: BoxDecoration(
                            color: mentalStrengthEditProvider.mediaSelected == 0
                                ? Colors.blue
                                : Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage(ImageConstant.imgMenu),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                50.0,
                              ),
                            ),
                            border: Border.all(
                              color: appTheme.blue300,
                              width: 1.0,
                            ),
                          ),
                          child: Icon(
                            Icons.mic,
                            size: 30,
                            color: mentalStrengthEditProvider.mediaSelected == 0
                                ? Colors.white
                                : Colors.blue,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        right: 10,
                        child: Consumer<MentalStrengthEditProvider>(
                            builder: (context, mentalStrengthEditProvider, _) {
                          if (mentalStrengthEditProvider
                              .recordedFilePath.isEmpty) {
                            return const SizedBox();
                          } else {
                            return Container(
                              width: size.height * 0.04,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(ImageConstant.imgMenu),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50.0,
                                  ),
                                ),
                                border: Border.all(
                                  color: appTheme.blue300,
                                  width: 2.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  mentalStrengthEditProvider
                                      .recordedFilePath.length
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      )
                    ],
                  ),
                ),
                // const AudioRecorderMentalStrengthBuild(),
                SizedBox(
                  height: size.height * 0.09,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          _isTokenExpired();
                          mentalStrengthEditProvider.selectedMedia(1);
                          await galleryBottomSheet(
                            context: context,
                            title: 'Gallery',
                          );
                        },
                        child: buildAvatarImage(
                          widget: Icon(
                            Icons.image,
                            size: 30,
                            color: mentalStrengthEditProvider.mediaSelected == 1
                                ? Colors.white
                                : Colors.blue,
                          ),
                          imagePath: ImageConstant.imgThumbsUp,
                          size: size,
                          isSelected:
                              mentalStrengthEditProvider.mediaSelected == 1
                                  ? true
                                  : false,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        right: 10,
                        child: Consumer<MentalStrengthEditProvider>(
                            builder: (context, mentalStrengthEditProvider, _) {
                          if (mentalStrengthEditProvider.pickedImages.isEmpty) {
                            return const SizedBox();
                          } else {
                            return Container(
                              width: size.height * 0.04,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(ImageConstant.imgMenu),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50.0,
                                  ),
                                ),
                                border: Border.all(
                                  color: appTheme.blue300,
                                  width: 2.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  mentalStrengthEditProvider.pickedImages.length
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.09,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _isTokenExpired();
                          mentalStrengthEditProvider.selectedMedia(2);
                          cameraBottomSheet(
                            context: context,
                            title: "Camera",
                          );
                        },
                        child: buildAvatarImage(
                          widget: Icon(
                            Icons.camera_alt_outlined,
                            size: 30,
                            color: mentalStrengthEditProvider.mediaSelected == 2
                                ? Colors.white
                                : Colors.blue,
                          ),
                          imagePath: ImageConstant.imgCamera,
                          size: size,
                          isSelected:
                              mentalStrengthEditProvider.mediaSelected == 2
                                  ? true
                                  : false,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        right: 10,
                        child: Consumer<MentalStrengthEditProvider>(
                            builder: (context, mentalStrengthEditProvider, _) {
                          if (mentalStrengthEditProvider.takedImages.isEmpty) {
                            return const SizedBox();
                          } else {
                            return Container(
                              width: size.height * 0.04,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(ImageConstant.imgMenu),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50.0,
                                  ),
                                ),
                                border: Border.all(
                                  color: appTheme.blue300,
                                  width: 2.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  mentalStrengthEditProvider.takedImages.length
                                      .toString(),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.09,
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _isTokenExpired();
                          mentalStrengthEditProvider.selectedMedia(
                            3,
                          );
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(20),
                                child: const MentalGoogleMap(),
                              );
                            },
                          );
                          // mentalStrengthEditProvider.mediaSelected == 3
                          //     ? const MentalGoogleMap()
                          //     : const SizedBox(),
                        },
                        child: buildAvatarImage(
                          widget: Icon(
                            Icons.location_on,
                            size: 30,
                            color: mentalStrengthEditProvider.mediaSelected == 3
                                ? Colors.white
                                : Colors.blue,
                          ),
                          imagePath: ImageConstant.imgLinkedin,
                          size: size,
                          // wi
                          isSelected:
                              mentalStrengthEditProvider.mediaSelected == 3
                                  ? true
                                  : false,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        right: 10,
                        child: Consumer<MentalStrengthEditProvider>(
                            builder: (context, mentalStrengthEditProvider, _) {
                          if (mentalStrengthEditProvider
                              .selectedLocationName.isEmpty) {
                            return const SizedBox();
                          } else {
                            return Container(
                              width: size.height * 0.04,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  image: AssetImage(ImageConstant.imgMenu),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50.0,
                                  ),
                                ),
                                border: Border.all(
                                  color: appTheme.blue300,
                                  width: 2.0,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

Widget buildAvatarImage(
    {required String imagePath,
    required Size size,
    Widget? widget,
    bool isSelected = false}) {
  return Container(
    height: size.height * 0.08,
    width: size.height * 0.08,
    decoration: BoxDecoration(
      color: isSelected ? Colors.blue : Colors.transparent,
      image: DecorationImage(
        image: AssetImage(
          imagePath,
        ),
        fit: BoxFit.cover,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(
          50.0,
        ),
      ),
      border: Border.all(
        color: appTheme.blue300,
        width: 1.0,
      ),
    ),
    child: widget ??
        CustomIconButton(
          height: size.height * 0.08,
          width: size.height * 0.08,
          padding: const EdgeInsets.all(18),
          child: CustomImageView(
            imagePath: imagePath,
            color: isSelected ? Colors.white : Colors.blue,
          ),
        ),
  );
}
