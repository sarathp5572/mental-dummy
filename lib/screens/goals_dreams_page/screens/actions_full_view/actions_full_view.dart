import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/addactions_screen/model/alaram_info.dart';
import 'package:mentalhelth/screens/addactions_screen/provider/add_actions_provider.dart';
import 'package:mentalhelth/screens/goals_dreams_page/model/actions_details_model.dart';
import 'package:mentalhelth/screens/goals_dreams_page/provider/goals_dreams_provider.dart';
import 'package:mentalhelth/screens/goals_dreams_page/screens/edit_actions/edit_actions_screen.dart';
import 'package:mentalhelth/screens/journal_view_screen/widgets/jouranl_view_google_map.dart';
import 'package:mentalhelth/screens/journal_view_screen/widgets/journal_audio_player.dart';
import "package:mentalhelth/screens/mental_strength_add_edit_screen/model/list_goal_actions.dart"
    as actions;
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/provider/mental_strenght_edit_provider.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/utils/logic/logic.dart';
import 'package:mentalhelth/utils/theme/custom_text_style.dart';
import 'package:mentalhelth/widgets/app_bar/appbar_leading_image.dart';
import 'package:mentalhelth/widgets/custom_checkbox_button.dart';
import 'package:mentalhelth/widgets/custom_image_view.dart';
import 'package:mentalhelth/widgets/video_player.dart';
import 'package:mentalhelth/widgets/widget/shimmer.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/app_bar/appbar_subtitle.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';

class ActionsFullView extends StatefulWidget {
  const ActionsFullView(
      {Key? key,
      required this.id,
      required this.indexs,
      required this.action,
      required this.goalId})
      : super(
          key: key,
        );
  final actions.Action action;
  final String id;
  final int indexs;
  final String goalId;

  @override
  State<ActionsFullView> createState() => _ActionsFullViewState();
}

class _ActionsFullViewState extends State<ActionsFullView> {
  bool isCompleted = false;
  AlarmInfo? alarmInfo;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    MentalStrengthEditProvider mentalStrengthEditProvider =
        Provider.of<MentalStrengthEditProvider>(
      context,
      listen: false,
    );
    AddActionsProvider addActionsProvider = Provider.of<AddActionsProvider>(
      context,
      listen: false,
    );
    await mentalStrengthEditProvider.fetchActionDetails(
      actionId: widget.id,
    );
    addAudio(
        actionsDetailsModel: mentalStrengthEditProvider.actionsDetailsModel!);
    addImage(
        actionsDetailsModel: mentalStrengthEditProvider.actionsDetailsModel!);
    addVideo(
        actionsDetailsModel: mentalStrengthEditProvider.actionsDetailsModel!);
    alarmInfo = await addActionsProvider.getDataByIdFromHiveBox(
      int.parse(
          mentalStrengthEditProvider.actionsDetailsModel!.actions!.actionId!),
    );
    setState(() {});
  }

  int sliderIndex = 1;

  PageController photoController = PageController();

  int photoCurrentIndex = 0;
  PageController videoController = PageController();

  int videoCurrentIndex = 0;
  List<String> audioList = [];

  List<String> imageList = [];

  List<String> videoList = [];

  void addAudio({required ActionsDetailsModel actionsDetailsModel}) {
    for (int i = 0; i < actionsDetailsModel.actions!.gemMedia!.length; i++) {
      if (actionsDetailsModel.actions!.gemMedia![i].mediaType == 'audio') {
        audioList.add(actionsDetailsModel.actions!.gemMedia![i].gemMedia!);
      }
    }
  }

  void addImage({required ActionsDetailsModel actionsDetailsModel}) {
    for (int i = 0; i < actionsDetailsModel.actions!.gemMedia!.length; i++) {
      if (actionsDetailsModel.actions!.gemMedia![i].mediaType == 'image') {
        // setState(() {
        imageList.add(actionsDetailsModel.actions!.gemMedia![i].gemMedia!);
        // });
      }
    }
  }

  void addVideo({required ActionsDetailsModel actionsDetailsModel}) {
    for (int i = 0; i < actionsDetailsModel.actions!.gemMedia!.length; i++) {
      if (actionsDetailsModel.actions!.gemMedia![i].mediaType == 'video') {
        // setState(() {
        videoList.add(actionsDetailsModel.actions!.gemMedia![i].gemMedia!);
        // });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Consumer<MentalStrengthEditProvider>(
          builder: (context, mentalStrengthEditProvider, _) {
        return Scaffold(
          appBar: mentalStrengthEditProvider.actionsDetailsModel == null
              ? AppBar()
              : buildAppBarActionView(context, size,
                  heading: capitalText(mentalStrengthEditProvider
                      .actionsDetailsModel!.actions!.actionTitle
                      .toString()),
                  id: mentalStrengthEditProvider
                      .actionsDetailsModel!.actions!.actionId
                      .toString()),
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
                  mentalStrengthEditProvider.actionsDetailsModel == null
                      ? shimmerView(size: size)
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            mentalStrengthEditProvider.actionsDetailsModel ==
                                    null
                                ? const SizedBox()
                                : _buildUntitledOne(
                                    context,
                                    size,
                                    category: mentalStrengthEditProvider
                                        .actionsDetailsModel!.actions!.goalTitle
                                        .toString(),
                                    createDate: mentalStrengthEditProvider
                                        .actionsDetailsModel!
                                        .actions!
                                        .actionDatetime
                                        .toString(),
                                    achiveDate: mentalStrengthEditProvider
                                        .actionsDetailsModel!
                                        .actions!
                                        .actionDatetime
                                        .toString(),
                                    status: mentalStrengthEditProvider
                                        .actionsDetailsModel!
                                        .actions!
                                        .actionStatus
                                        .toString(),
                                  ),
                            const SizedBox(height: 10),
                            mentalStrengthEditProvider.actionsDetailsModel ==
                                    null
                                ? shimmerList(
                                    height: 50,
                                  )
                                : Container(
                              //color: Colors.amber,
                                  width: size.width * 0.75,
                                  child: Text(
                                      capitalText(mentalStrengthEditProvider
                                          .actionsDetailsModel!
                                          .actions!
                                          .actionDetails
                                          .toString()),
                                      maxLines: mentalStrengthEditProvider
                                          .actionsDetailsModel!
                                          .actions!
                                          .actionDetails?.length,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyles
                                          .blackText15GreyTextW400(),
                                    ),
                                ),
                            const SizedBox(height: 15),
                            audioList.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Text(
                                      "Audio",
                                      style: CustomTextStyles
                                          .blackText16000000W700(),
                                    ),
                                  ),
                            audioList.isEmpty
                                ? const SizedBox()
                                : const SizedBox(
                                    height: 2,
                                  ),
                            audioList.isEmpty
                                ? const SizedBox()
                                : SizedBox(
                                    height:size.height * 0.25,
                                    child: ListView.builder(
                                      itemCount: audioList.length,
                                      itemBuilder: (context, index) {
                                        return JournalAudioPlayer(
                                          url: audioList[index],
                                        );
                                      },
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            imageList.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Text(
                                      "Photo",
                                      style: CustomTextStyles
                                          .blackText16000000W700(),
                                    ),
                                  ),
                            imageList.isEmpty
                                ? const SizedBox()
                                : const SizedBox(height: 4),
                            imageList.isEmpty
                                ? const SizedBox()
                                : SizedBox(
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
                                            width: imageList.length *
                                                size.width *
                                                0.1,
                                            child: buildIndicators(
                                              imageList.length,
                                              photoCurrentIndex,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            videoList.isEmpty
                                ? const SizedBox()
                                : const SizedBox(
                                    height: 10,
                                  ),
                            videoList.isEmpty
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 2),
                                    child: Text(
                                      "Video",
                                      style: CustomTextStyles
                                          .blackText16000000W700(),
                                    ),
                                  ),
                            videoList.isEmpty
                                ? const SizedBox()
                                : const SizedBox(height: 4),
                            videoList.isEmpty
                                ? const SizedBox()
                                : SizedBox(
                                    height: size.height * 0.3,
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
                                            width: videoList.length *
                                                size.width *
                                                0.1,
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
                                child: mentalStrengthEditProvider
                                            .actionsDetailsModel ==
                                        null
                                    ? const SizedBox()
                                    : JournalGoogleMapWidgets(
                                        latitude: mentalStrengthEditProvider
                                                    .actionsDetailsModel!
                                                    .actions!
                                                    .location ==
                                                null
                                            ? 0
                                            : double.parse(mentalStrengthEditProvider
                                                            .actionsDetailsModel!
                                                            .actions!
                                                            .location!
                                                            .locationLatitude ==
                                                        null ||
                                                    mentalStrengthEditProvider
                                                            .actionsDetailsModel!
                                                            .actions!
                                                            .location!
                                                            .locationLatitude ==
                                                        ""
                                                ? "0.0"
                                                : mentalStrengthEditProvider
                                                    .actionsDetailsModel!
                                                    .actions!
                                                    .location!
                                                    .locationLatitude!),
                                        longitude: mentalStrengthEditProvider
                                                    .actionsDetailsModel!
                                                    .actions!
                                                    .location ==
                                                null
                                            ? 0
                                            : mentalStrengthEditProvider
                                                        .actionsDetailsModel!
                                                        .actions!
                                                        .location!
                                                        .locationLongitude ==
                                                    ""
                                                ? 0
                                                : double.parse(
                                                    mentalStrengthEditProvider
                                                        .actionsDetailsModel!
                                                        .actions!
                                                        .location!
                                                        .locationLongitude!),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Consumer<AddActionsProvider>(
                                builder: (context, addActionsProvider, _) {
                              return Column(
                                children: [
                                  alarmInfo == null
                                      ? const SizedBox()
                                      : Row(
                                          children: [
                                            Checkbox(
                                              value: addActionsProvider
                                                  .setRemainder,
                                              onChanged: (value) {
                                                addActionsProvider
                                                    .changeSetRemainder(value!);
                                              },
                                            ),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            const Text(
                                              "Reminder",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: size.width * 0.04,
                                      bottom: 10,
                                    ),
                                    child: addActionsProvider.setRemainder
                                        ? alarmInfo == null
                                            ? const SizedBox()
                                            : SizedBox(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Date",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            ": ${alarmInfo!.startDate} to ${alarmInfo!.endDate}"),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Time",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            ": ${alarmInfo!.startTime} to ${alarmInfo!.endTime}"),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                          "Repeat",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                            ": ${alarmInfo!.repeat}"),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                        : const SizedBox(),
                                  )
                                ],
                              );
                            }),

                            const SizedBox(height: 20),
                            widget.action.actionStatus == "1"
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
                                : Consumer2<AddActionsProvider,
                                        MentalStrengthEditProvider>(
                                    builder: (context, addActionsProvider,
                                        mentalStrengthEditProvider, _) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.04,
                                        bottom: 10,
                                      ),
                                      child: CustomCheckboxButton(
                                        text: "Mark this goal as Completed",
                                        value: isCompleted,
                                        onChange: (value) async {
                                          setState(() {
                                            isCompleted = true;
                                          });
                                          await addActionsProvider
                                              .updateActionStatusFunction(
                                            context,
                                            goalId: widget.goalId.toString(),
                                            actionId:
                                                widget.action.id.toString(),
                                          );
                                          mentalStrengthEditProvider
                                              .fetchGoalActions(
                                            goalId: widget.goalId.toString(),
                                          );
                                        },
                                      ),
                                    );
                                  }),
                            const SizedBox(height: 30),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  /// Section Widget
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
              "Status : ",
              style: CustomTextStyles.blackText16000000W700(),
            ),
            SizedBox(
             // color: Colors.blue,
              width: size.width * 0.60,
              child: Text(
                status == "0" ? "Active" : "DeActive",
                style: CustomTextStyles.bodyLargeGray700,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "Goal : ",
              style: CustomTextStyles.blackText16000000W700(),
            ),
            SizedBox(
             // color: Colors.blue,
              width: size.width * 0.60,
              child: Text(
                category,
                style: CustomTextStyles.bodyLargeGray700,
              ),
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

  PreferredSizeWidget buildAppBarActionView(BuildContext context, Size size,
      {String? heading, required String id}) {
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
        Consumer3<MentalStrengthEditProvider, AddActionsProvider,
            GoalsDreamsProvider>(
          builder: (context, mentalStrengthEditProvider, addActionsProvider,
              goalsDreamsProvider, _) {
            return PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditActionScreen(
                            actionsDetailsModel:
                                mentalStrengthEditProvider.actionsDetailsModel!,
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
                    onTap: () async {
                      await addActionsProvider.deleteActionFunction(
                        deleteId: id,
                      );
                      goalsDreamsProvider.fetchGoalsAndDreams(
                        initial: true,
                      );
                      Navigator.of(context).pop();
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
