import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/auth/subscribe_plan_page/model/subscribe_plan_model.dart';
import 'package:mentalhelth/utils/theme/app_decoration.dart';
import 'package:mentalhelth/utils/theme/colors.dart';
import 'package:mentalhelth/utils/theme/custom_button_style.dart';
import 'package:mentalhelth/utils/theme/custom_text_style.dart';

import 'custom_plan_button.dart';

// ignore: must_be_immutable
class SubscribePlanItemWidget extends StatelessWidget {
  SubscribePlanItemWidget({
    Key? key,
    this.onPressed,
    required this.plan,
  }) : super(
          key: key,
        );

  VoidCallback? onPressed;
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // height: 87,
      padding: const EdgeInsets.symmetric(
        horizontal: 19,
        vertical: 23,
      ),
      decoration: AppDecoration.fillBlue.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 1),
                  child: Text(
                    "Monthly \$${plan.price}",
                    style: CustomTextStyles.bodyLargeRobotoOnSecondaryContainer,
                  ),
                ),
                // const SizedBox(height: 2),
                Text(
                  "Plan validity ${plan.planValidity} days",
                  style: CustomTextStyles.bodyMediumRobotoOnSecondaryContainer,
                ),
              ],
            ),
          ),
          CustomPlanButton(
            onPressed: onPressed,
            height: size.height * 0.04,
            width: size.width * 0.30,
            text: "Buy Now",
            margin: const EdgeInsets.only(
              top: 9,
              right: 8,
            ),
            buttonTextStyle:
                CustomTextStyles.bodySmallRobotoOnSecondaryContainer,
            buttonStyle: CustomButtonStyles.buttonBorder4,
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorsContent.whiteText,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
