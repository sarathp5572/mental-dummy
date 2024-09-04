import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/widgets/audio_widgets/mental_strength_audio_player.dart';
import 'package:provider/provider.dart';

import '../../../../utils/core/image_constant.dart';
import '../../../../widgets/custom_image_view.dart';
import '../../provider/add_actions_provider.dart';
import '../audio_widgets/add_action_audio_recorder.dart';

Future audioBottomSheetAction({
  required BuildContext context,
  required String title,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(); // Close the bottom sheet
                    },
                    child: CustomImageView(
                      imagePath: ImageConstant.imgClosePrimary,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Consumer<AddActionsProvider>(
                builder: (context, addActionsProvider, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AudioRecorderAddAction(),
                      SizedBox(height: size.height * 0.01),
                      if(addActionsProvider.mediaSelected == 0)
                        Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: addActionsProvider
                                  .alreadyRecordedFilePath.length,
                              itemBuilder: (context, index) {
                                return MentalStrengthAudioPlayer(
                                  url: addActionsProvider
                                      .alreadyRecordedFilePath[index].value,
                                  index: index,
                                  already: true,
                                  id: addActionsProvider
                                      .alreadyRecordedFilePath[index].id,
                                  type: "action",
                                );
                              },
                            ),
                          ),
                      if(addActionsProvider.mediaSelected == 0)
                        Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  addActionsProvider.recordedFilePath.length,
                              itemBuilder: (context, index) {
                                return MentalStrengthAudioPlayer(
                                  url: addActionsProvider
                                      .recordedFilePath[index],
                                  index: index,
                                  type: "action",
                                );
                              },
                            ),
                          ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
