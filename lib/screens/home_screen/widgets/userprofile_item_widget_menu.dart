import 'package:flutter/material.dart' hide MenuController;

import '../../../utils/core/image_constant.dart';
import '../../../utils/theme/app_decoration.dart';
import '../../../utils/theme/custom_text_style.dart';
import '../../../utils/theme/theme_helper.dart';
import '../../../widgets/custom_image_view.dart';

// ignore: must_be_immutable
class UserprofileItemWidget extends StatelessWidget {
  const UserprofileItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      margin: const EdgeInsets.all(0),
      color: theme.colorScheme.primary.withOpacity(1),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: appTheme.gray100,
          width: 1,
        ),
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Container(
        height: 97,
        width: 162,
        decoration: AppDecoration.outlineGray100.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder4,
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgImage2,
              height: 97,
              width: 162,
              radius: BorderRadius.circular(
                5,
              ),
              alignment: Alignment.center,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 26,
                  bottom: 9,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Feeling good",
                      style: CustomTextStyles.bodyMediumOnSecondaryContainer,
                    ),
                    Text(
                      "01 Aug 2023, 09:30AM",
                      style: CustomTextStyles.bodySmallGray200,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
