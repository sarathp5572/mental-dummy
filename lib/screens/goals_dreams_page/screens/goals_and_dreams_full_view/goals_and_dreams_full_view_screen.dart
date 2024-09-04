import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/addgoals_dreams_screen/provider/ad_goals_dreams_provider.dart';
import 'package:mentalhelth/screens/goals_dreams_page/model/goals_and_dreams_model.dart';
import 'package:mentalhelth/screens/goals_dreams_page/provider/goals_dreams_provider.dart';
import 'package:mentalhelth/screens/goals_dreams_page/screens/actions_full_view/actions_full_view.dart';
import 'package:mentalhelth/screens/goals_dreams_page/screens/edit_goals_and_dreams/edit_goals_and_dreams.dart';
import 'package:mentalhelth/screens/journal_view_screen/widgets/jouranl_view_google_map.dart';
import 'package:mentalhelth/screens/journal_view_screen/widgets/journal_audio_player.dart';
import "package:mentalhelth/screens/mental_strength_add_edit_screen/model/list_goal_actions.dart"
    as actionss;
import 'package:mentalhelth/utils/core/date_time_utils.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/utils/theme/custom_text_style.dart';
import 'package:mentalhelth/widgets/app_bar/appbar_leading_image.dart';
import 'package:mentalhelth/widgets/custom_checkbox_button.dart';
import 'package:mentalhelth/widgets/custom_image_view.dart';
import 'package:mentalhelth/widgets/video_player.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/functions/popup.dart';

class GoalAndDreamFullViewScreen extends StatefulWidget {
  const GoalAndDreamFullViewScreen(
      {Key? key, required this.goalsanddream, required this.indexs})
      : super(
          key: key,
        );

  final Goalsanddream goalsanddream;

  final int indexs;

  @override
  State<GoalAndDreamFullViewScreen> createState() =>
      _GoalAndDreamFullViewScreenState();
}

class _GoalAndDreamFullViewScreenState
    extends State<GoalAndDreamFullViewScreen> {
  bool isCompleted = false;

  @override
  void initState() {
    addAudio();
    addImage();
    addVideo();
    super.initState();
  }

  int sliderIndex = 1;

  PageController photoController = PageController();

  int photoCurrentIndex = 0;
  PageController videoController = PageController();

  int videoCurrentIndex = 0;
  List<String> audioList = [];

  List<String> imageList = [];

  List<String> videoList = [];

  void addAudio() {
    for (int i = 0; i < widget.goalsanddream.gemMedia!.length; i++) {
      if (widget.goalsanddream.gemMedia![i].mediaType == 'audio') {
        // setState(() {
        audioList.add(widget.goalsanddream.gemMedia![i].gemMedia!);
        // });
      }
    }
  }

  void addImage() {
    for (int i = 0; i < widget.goalsanddream.gemMedia!.length; i++) {
      if (widget.goalsanddream.gemMedia![i].mediaType == 'image') {
        // setState(() {
        imageList.add(widget.goalsanddream.gemMedia![i].gemMedia!);
        // });
      }
    }
  }

  void addVideo() {
    for (int i = 0; i < widget.goalsanddream.gemMedia!.length; i++) {
      if (widget.goalsanddream.gemMedia![i].mediaType == 'video') {
        // setState(() {
        videoList.add(widget.goalsanddream.gemMedia![i].gemMedia!);
        // });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBarGoalView(context, size,
            heading: widget.goalsanddream.goalTitle.toString(),
            id: widget.goalsanddream.goalId.toString()),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUntitledOne(
                  context,
                  size,
                  category: widget.goalsanddream.goalTitle.toString(),
                  createDate: widget.goalsanddream.createdAt.toString(),
                  achiveDate: widget.goalsanddream.goalEnddate.toString(),
                  status: widget.goalsanddream.goalStatus.toString(),
                ),

                const SizedBox(height: 15),
                audioList.isEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          "Audio",
                          style: CustomTextStyles.blackText16000000W700(),
                        ),
                      ),
                const SizedBox(height: 4),
                audioList.isEmpty?
                const SizedBox() :
                SizedBox(
                  height: size.height * 0.25,
                  child: ListView.builder(
                 //   physics: const NeverScrollableScrollPhysics(),
                    itemCount: audioList.length,
                    itemBuilder: (context, index) {
                      return JournalAudioPlayer(
                        url: audioList[index],
                      );
                    },
                  ),
                ),
                imageList.isNotEmpty
                    ? const SizedBox(
                        height: 23,
                      )
                    : const SizedBox(),
                imageList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          "Photo",
                          style: CustomTextStyles.blackText16000000W700(),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 4),
                SizedBox(
                  height: imageList.isNotEmpty ? size.height * 0.3 : 0,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: photoController,
                        itemCount: imageList.length,
                        itemBuilder: (context, index) {
                          return CustomImageView(
                            fit: BoxFit.cover,
                            imagePath: imageList[index],
                            height: size.height * 0.30,
                            width: size.width,
                            alignment: Alignment.center,
                          );
                        },
                        onPageChanged: (int pageIndex) {
                          setState(() {
                            photoCurrentIndex = pageIndex;
                          });
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          width: imageList.length * size.width * 0.1,
                          child: buildIndicators(
                            imageList.length,
                            photoCurrentIndex,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                videoList.isNotEmpty
                    ? const SizedBox(
                        height: 10,
                      )
                    : const SizedBox(),
                videoList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(
                          "Video",
                          style: CustomTextStyles.blackText16000000W700(),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 4),
                SizedBox(
                  height: videoList.isNotEmpty ? size.height * 0.3 : 0,
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: videoController,
                        itemCount: videoList.length,
                        itemBuilder: (context, index) {
                          return VideoPlayerWidget(
                            videoUrl: videoList[index],
                          );
                        },
                        onPageChanged: (int pageIndex) {
                          setState(() {
                            videoCurrentIndex = pageIndex;
                          });
                        },
                      ),
                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          width: videoList.length * size.width * 0.1,
                          child: buildIndicators(
                            videoList.length,
                            videoCurrentIndex,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // _buildGrid(
                //   context,
                //   size,
                // ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(
                    "Your Location",
                    style: CustomTextStyles.blackText16000000W700(),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: size.height * 0.35,
                  child: Center(
                    child: JournalGoogleMapWidgets(
                      latitude: widget.goalsanddream.location == null
                          ? 0
                          : double.parse(
                              widget.goalsanddream.location!.locationLatitude ==
                                          null ||
                                      widget.goalsanddream.location!
                                              .locationLatitude ==
                                          ""
                                  ? "0.0"
                                  : widget.goalsanddream.location!
                                      .locationLatitude!),
                      longitude: widget.goalsanddream.location == null
                          ? 0
                          : widget.goalsanddream.location!.locationLongitude ==
                                  ""
                              ? 0
                              : double.parse(widget
                                  .goalsanddream.location!.locationLongitude!),
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 2,
                //   ),
                //   child: Text(
                //     "Actions to achieve the goal",
                //     style: theme.textTheme.titleSmall,
                //   ),
                // ),
                // const SizedBox(
                //   height: 3,
                // ),
                // _buildAddActionsButton(
                //   context,
                // ),
                const SizedBox(height: 20),
                Consumer<AdDreamsGoalsProvider>(
                  builder: (context, adDreamsGoalsProvider, _) {
                    return SizedBox(
                      height: widget.goalsanddream.action!.length *
                          size.height *
                          0.06,
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.goalsanddream.action!.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ActionsFullView(
                                        id: widget.goalsanddream.action![index]
                                            .actionId
                                            .toString(),
                                        indexs: index,
                                        action: actionss.Action(
                                          id: widget.goalsanddream
                                              .action![index].actionId,
                                          title: widget.goalsanddream
                                              .action![index].actionTitle,
                                          actionStatus: widget.goalsanddream
                                              .action![index].actionStatus,
                                          actionDate: widget.goalsanddream
                                              .action![index].actionDatetime,
                                        ),
                                        goalId: widget.goalsanddream.goalId
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      bottom: 4,
                                    ),
                                    height: size.height * 0.04,
                                    width: size.width * 0.87,
                                    padding: const EdgeInsets.only(
                                      bottom: 5,
                                      top: 5,
                                      left: 0,
                                      right: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        100,
                                      ),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.04,
                                        ),
                                        Text(
                                          widget.goalsanddream.action![index]
                                              .actionTitle
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        CircleAvatar(
                                          radius: size.width * 0.04,
                                          backgroundColor: Colors.blue,
                                          child: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Colors.white,
                                            size: size.width * 0.03,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );

                          // _buildCloseEditText(
                          //   context,
                          //   content:
                          //       adDreamsGoalsProvider.goalModelIdName[index].name,
                          //   onTap: () {
                          //     adDreamsGoalsProvider
                          //         .getAddActionIdAndNameClear(index);
                          //   },
                          // );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                widget.goalsanddream.goalStatus == "1"
                    ? const Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                          bottom: 10,
                        ),
                        child: Text(
                          "Completed",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          // style: theme.textTheme.titleSmall,
                        ),
                      )
                    : Consumer<GoalsDreamsProvider>(
                        builder: (context, goalsDreamsProvider, _) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 13,
                            bottom: 10,
                          ),
                          child: CustomCheckboxButton(
                            text: "Mark this goal as Completed",
                            value: isCompleted,
                            onChange: (value) async {
                              customPopup(
                                context: context,
                                onPressedDelete: () async {
                                  await goalsDreamsProvider.updateGoalsStatus(
                                    context,
                                    goalId:
                                        widget.goalsanddream.goalId.toString(),
                                    status: "1",
                                  );
                                  goalsDreamsProvider.fetchGoalsAndDreams(
                                    initial: true,
                                  );
                                  setState(() {
                                    isCompleted = true;
                                  });
                                  Navigator.of(context).pop();
                                },
                                yes: "Yes",
                                title: 'Goal Completed',
                                content:
                                    'Are you sure You want to mark this goal as completed?',
                              );
                            },
                          ),
                        );
                      }),
                // _buildSaveButton(context),
                SizedBox(
                  height: size.height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildSaveButton(BuildContext context) {
  //   return Consumer<AdDreamsGoalsProvider>(
  //       builder: (context, adDreamsGoalsProvider, _) {
  //     return CustomElevatedButton(
  //       loading: adDreamsGoalsProvider.saveAddActionsLoading,
  //       onPressed: () async {
  //         List<GoalModelIdName> actionIds = [];
  //         actionIds.addAll(adDreamsGoalsProvider.goalModelIdName);
  //
  //         await adDreamsGoalsProvider.updateGoalFunction(
  //           context,
  //           title: widget.goalsanddream.goalTitle.toString(),
  //           details: widget.goalsanddream.goalDetails.toString(),
  //           mediaName: [],
  //           locationName:
  //               widget.goalsanddream.location!.locationName.toString(),
  //           locationLatitude:
  //               widget.goalsanddream.location!.locationLatitude.toString(),
  //           locationLongitude:
  //               widget.goalsanddream.location!.locationLongitude.toString(),
  //           locationAddress:
  //               widget.goalsanddream.location!.locationAddress.toString(),
  //           categoryId: "",
  //           gemEndDate: widget.goalsanddream.goalEnddate.toString(),
  //           actionId: adDreamsGoalsProvider.goalModelIdName,
  //         );
  //         GoalsDreamsProvider goalsDreamsProvider =
  //             Provider.of<GoalsDreamsProvider>(
  //           context,
  //           listen: false,
  //         );
  //         goalsDreamsProvider.fetchGoalsAndDreams(initial: true);
  //       },
  //       height: 40,
  //       text: "Update",
  //       margin: const EdgeInsets.only(left: 2),
  //       buttonStyle: CustomButtonStyles.outlinePrimaryTL5,
  //       buttonTextStyle:
  //           CustomTextStyles.titleSmallHelveticaOnSecondaryContainer,
  //     );
  //   });
  // }
  //
  // Widget _buildCloseEditText(
  //   BuildContext context, {
  //   required String content,
  //   void Function()? onTap,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 2),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(),
  //         borderRadius: BorderRadius.circular(
  //           1,
  //         ),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(content),
  //           CustomImageView(
  //             onTap: onTap,
  //             imagePath: ImageConstant.imgCloseGray700,
  //             height: 30,
  //             width: 30,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildAddActionsButton(BuildContext context) {
  //   return CustomElevatedButton(
  //     onPressed: () {
  //       Navigator.of(context).push(
  //         MaterialPageRoute(
  //           builder: (context) => const AddactionsScreen(),
  //         ),
  //       );
  //     },
  //     height: 40,
  //     text: "Add Actions",
  //     margin: const EdgeInsets.only(left: 2),
  //     buttonStyle: CustomButtonStyles.outlinePrimary,
  //     buttonTextStyle: CustomTextStyles.titleSmallOnSecondaryContainer_1,
  //   );
  // }

  Widget _buildUntitledOne(BuildContext context, Size size,
      {required String category,
      required String createDate,
      required String achiveDate,
      required String status}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Text(
              "Category : ",
              style: CustomTextStyles.blackText16000000W700(),
            ),
            SizedBox(
              width: size.width * 0.6,
              child: Text(
                category,
                style: CustomTextStyles.bodyLargeGray700,
                maxLines: 1,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          children: [
            Text(
              "Created Date : ",
              style: CustomTextStyles.blackText16000000W700(),
            ),
            Text(
              formatDate(int.parse(createDate)),
              style: CustomTextStyles.bodyLargeGray700,
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          children: [
            Text(
              "Achievement Date : ",
              style: CustomTextStyles.blackText16000000W700(),
            ),
            Text(
              achiveDate == "" ? "" : formatDate2(int.parse(achiveDate)),
              style: CustomTextStyles.bodyLargeGray700,
            ),
          ],
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          children: [
            Text(
              "Status : ",
              style: CustomTextStyles.blackText16000000W700(),
            ),
            Text(
              status == "0" ? "Active" : "DeActive",
              style: CustomTextStyles.bodyLargeGray700,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildIndicators(int pageCount, int currentIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
        pageCount,
        (index) {
          return Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentIndex ? Colors.blue : Colors.grey,
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget buildAppBarGoalView(
    BuildContext context,
    Size size, {
    String? heading,
    required String id,
  }) {
    return CustomAppBar(
      leadingWidth: 36,
      leading: AppbarLeadingImage(
        onTap: () {
          Navigator.of(context).pop();
        },
        imagePath: ImageConstant.imgTelevision,
        margin: const EdgeInsets.only(
          left: 20,
          top: 19,
          bottom: 23,
        ),
      ),
      title: AppbarSubtitle(
        text: heading ?? "",
        margin: const EdgeInsets.only(
          left: 11,
        ),
      ),
      actions: [
        Consumer<GoalsDreamsProvider>(
          builder: (contexts, goalsDreamsProvider, _) {
            return PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditGoalsScreen(
                            goalsanddream: widget.goalsanddream,
                          ),
                        ),
                      );
                    },
                    value: 'Edit',
                    child: Text(
                      'Edit',
                      style: CustomTextStyles.bodyMedium14,
                    ),
                  ),
                  PopupMenuItem<String>(
                    onTap: () {
                      customPopup(
                        context: context,
                        onPressedDelete: () {
                          goalsDreamsProvider.deleteGoalsFunction(
                            deleteId: id,
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        title: 'Confirm Delete',
                        content: 'Are you sure You want to Delete this Goal ?',
                      );
                    },
                    value: 'Delete',
                    child: Text(
                      'Delete',
                      style: CustomTextStyles.bodyMedium14,
                    ),
                  ),
                ];
              },
            );
          },
        ),
      ],
    );
  }
}