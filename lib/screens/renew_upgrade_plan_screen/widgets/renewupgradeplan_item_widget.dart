import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/auth/subscription_success_screen/subscription_success_screen.dart';
import 'package:mentalhelth/widgets/custom_outlined_button.dart';

import '../../../utils/theme/app_decoration.dart';
import '../../../utils/theme/custom_text_style.dart';

// ignore: must_be_immutable
class RenewUpgradePlanItemWidget extends StatelessWidget {
  const RenewUpgradePlanItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 5,
      ),
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
                    "Monthly 1",
                    style: CustomTextStyles.bodyLargeRobotoOnSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Plan validity 30 days",
                  style: CustomTextStyles.bodyMediumRobotoOnSecondaryContainer,
                ),
              ],
            ),
          ),
          CustomOutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SubscriptionSuccessScreen(),
                ),
              );
            },
            height: 29,
            width: 90,
            text: "Renew",
            margin: const EdgeInsets.only(
              top: 9,
              right: 8,
            ),
            buttonTextStyle:
                CustomTextStyles.bodySmallRobotoOnSecondaryContainer,
          ),
        ],
      ),
    );
  }
}
