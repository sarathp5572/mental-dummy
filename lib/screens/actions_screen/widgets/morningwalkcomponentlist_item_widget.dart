import 'package:flutter/material.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/utils/theme/app_decoration.dart';
import 'package:mentalhelth/utils/theme/custom_text_style.dart';
import 'package:mentalhelth/widgets/custom_image_view.dart';

// ignore: must_be_immutable
class MorningwalkcomponentlistItemWidget extends StatelessWidget {
  const MorningwalkcomponentlistItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 13,
      ),
      decoration: AppDecoration.outlineGray200.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgImage5,
            height: 63,
            width: 64,
            radius: BorderRadius.circular(
              31,
            ),
            margin: const EdgeInsets.only(bottom: 4),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              top: 13,
              bottom: 13,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Morning walk",
                  style: CustomTextStyles.titleMedium16,
                ),
                const SizedBox(height: 2),
                Text(
                  "30 Sep 2023",
                  style: CustomTextStyles.bodySmallGray700_1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
