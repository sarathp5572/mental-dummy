import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/auth/signup_screen/signup_screen.dart';
import 'package:mentalhelth/screens/auth/subscribe_plan_page/provider/subscribe_plan_provider.dart';
import 'package:mentalhelth/screens/confirm_plan_screen/confirm_plan_screen.dart';
import 'package:mentalhelth/utils/logic/shared_prefrence.dart';
import 'package:mentalhelth/utils/theme/custom_text_style.dart';
import 'package:mentalhelth/widgets/app_bar/appbar_leading_image.dart';
import 'package:mentalhelth/widgets/background_image/background_imager.dart';
import 'package:mentalhelth/widgets/functions/popup.dart';
import 'package:mentalhelth/widgets/widget/shimmer.dart';
import 'package:provider/provider.dart';

import 'widgets/subscribeplan_item_widget.dart';

// ignore: must_be_immutable
class SubscribePlanPage extends StatefulWidget {
  SubscribePlanPage({
    Key? key,
    this.signed = false,
  }) : super(key: key);
  bool signed;

  @override
  State<SubscribePlanPage> createState() => _SubscribePlanPageState();
}

class _SubscribePlanPageState extends State<SubscribePlanPage> {
  @override
  void initState() {
    Future.microtask(() async {
      SubScribePlanProvider subScribePlanProvider =
          Provider.of<SubScribePlanProvider>(
        context,
        listen: false,
      );
      await subScribePlanProvider.fetchPlans();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(
          isSigned: widget.signed,
          onTap: () async {
            if (widget.signed) {
              Navigator.of(context).pop();
            } else {
              customPopup(
                context: context,
                onPressedDelete: () async {
                  await removeUserDetailsSharePref(context: context);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ),
                    (route) => false,
                  );
                },
                title: 'Confirm Logout',
                content: 'Are you sure You want to logout?',
                yes: "Logout",
              );
            }
          },
          context,
          size,
          heading: "Choose a Plans",
        ),
        body: backGroundImager(
          size: size,
          padding: EdgeInsets.zero,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 3,
                  ),
                  child: Text(
                    "Choose a plan to Sign up",
                    style: CustomTextStyles.blackText17000000W400(),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                _buildSubscribePlan(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSubscribePlan(BuildContext context) {
    return Consumer<SubScribePlanProvider>(
        builder: (context, subScribePlanProvider, _) {
      return subScribePlanProvider.getPlansModel == null
          ? shimmerList(
              height: 300,
            )
          : Padding(
              padding: const EdgeInsets.only(left: 3),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 5);
                },
                itemCount: subScribePlanProvider.getPlansModel!.plans!.length,
                itemBuilder: (context, index) {
                  return SubscribePlanItemWidget(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ConfirmPlanScreen(
                            planId: subScribePlanProvider
                                .getPlansModel!.plans![index].id
                                .toString(),
                          ),
                        ),
                      );
                    },
                    plan: subScribePlanProvider.getPlansModel!.plans![index],
                  );
                },
              ),
            );
    });
  }
//
// PreferredSizeWidget buildAppBar(BuildContext context, Size size,
//     {String? heading, Function? onTap}) {
//   return CustomAppBar(
//     leadingWidth: 36,
//     leading: AppbarLeadingImage(
//       onTap: onTap ??
//           () {
//             Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(
//                 builder: (context) =>  ScreenSignIn(),
//               ),
//               (route) => false,
//             );
//           },
//       imagePath: ImageConstant.imgTelevision,
//       margin: const EdgeInsets.only(
//         left: 20,
//         top: 19,
//         bottom: 23,
//       ),
//     ),
//     title: AppbarSubtitle(
//       text: heading ?? "My profile",
//       margin: const EdgeInsets.only(
//         left: 11,
//       ),
//     ),
//     actions: [
//       GestureDetector(
//         onTap: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) =>
//                 buildPopupDialog(context, size),
//           );
//         },
//         child: Padding(
//           padding: EdgeInsets.only(
//             right: size.width * 0.07,
//           ),
//           child: CircleAvatar(
//             radius: size.width * 0.04,
//             backgroundColor: PrimaryColors().blue300,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   height: size.height * 0.003,
//                   width: size.width * 0.03,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(
//                         10,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.005,
//                 ),
//                 Container(
//                   height: size.height * 0.003,
//                   width: size.width * 0.03,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(
//                         10,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
// }
}
