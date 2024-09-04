import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/addgoals_dreams_screen/widget/audio_widgets/add_action_audio_recorder.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/widgets/audio_widgets/mental_strength_audio_player.dart';
import 'package:provider/provider.dart';

import '../../../../utils/core/image_constant.dart';
import '../../../../widgets/custom_image_view.dart';
import '../../provider/ad_goals_dreams_provider.dart';

Future audioBottomSheetAddGoals({
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
                      imagePath: ImageConstant.imgClosePrimaryNew,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Consumer<AdDreamsGoalsProvider>(
                builder: (context, adDreamsGoalsProvider, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AudioRecorderAddGoals(),
                      SizedBox(height: size.height * 0.01),
          
                      if (adDreamsGoalsProvider.mediaSelected == 0)
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: adDreamsGoalsProvider.alreadyRecordedFilePath.length,
                            itemBuilder: (context, index) {
                              return MentalStrengthAudioPlayer(
                                url: adDreamsGoalsProvider.alreadyRecordedFilePath[index].value,
                                index: index,
                                already: true,
                                id: adDreamsGoalsProvider.alreadyRecordedFilePath[index].id,
                                type: "goal",
                              );
                            },
                          ),
                        ),
          
                      if (adDreamsGoalsProvider.mediaSelected == 0)
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: adDreamsGoalsProvider.recordedFilePath.length,
                            itemBuilder: (context, index) {
                              return MentalStrengthAudioPlayer(
                                url: adDreamsGoalsProvider.recordedFilePath[index],
                                index: index,
                                type: "goal",
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
