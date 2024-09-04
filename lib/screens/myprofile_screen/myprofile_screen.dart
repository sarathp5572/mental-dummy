import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/dash_borad_screen/provider/dash_board_provider.dart';
import 'package:mentalhelth/screens/edit_add_profile_screen/provider/edit_provider.dart';
import 'package:mentalhelth/screens/phone_singin_screen/phone_sign_in_screen.dart';
import 'package:mentalhelth/screens/phone_singin_screen/provider/phone_sign_in_provider.dart';
import 'package:mentalhelth/utils/logic/date_format.dart';
import 'package:mentalhelth/utils/logic/logic.dart';
import 'package:mentalhelth/utils/theme/app_decoration.dart';
import 'package:mentalhelth/widgets/app_bar/appbar_leading_image.dart';
import 'package:mentalhelth/widgets/background_image/background_imager.dart';
import 'package:provider/provider.dart';

import '../../utils/theme/custom_text_style.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: backGroundImager(
        size: size,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            buildAppBar(
              context,
              size,
            ),
            Container(
              height: size.height * 0.8,
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 21,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            top: size.height * 0.055,
                          ),
                          child: Opacity(
                            opacity: 0.11,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: size.height * 0.64,
                                decoration: BoxDecoration(
                                  color: const Color(0xff666666),
                                  // color: theme.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Consumer<EditProfileProvider>(
                            builder: (context, editProfileProvider, _) {
                          return Container(
                            margin: const EdgeInsets.only(
                                // top: size.height * 0.004,
                                ),
                            height: size.height * 0.11,
                            width: size.height * 0.11,
                            decoration: AppDecoration.fillBlueGray.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder54,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(
                                editProfileProvider.getProfileModel?.profileurl
                                        .toString() ??
                                    "",
                              ),
                              radius: size.width * 0.1,
                            ),
                            // CustomImageView(
                            //   imagePath: editProfileProvider
                            //       .getProfileModel!.profileurl
                            //       .toString(),
                            //   height: size.height * 0.11,
                            //   width: size.height * 0.11,
                            //   radius: BorderRadius.circular(
                            //     54,
                            //   ),
                            //   alignment: Alignment.center,
                            // ),
                          );
                        }),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 22,
                            ),
                            child: Consumer2<EditProfileProvider,
                                    PhoneSignInProvider>(
                                builder: (context, editProfileProvider,
                                    phoneSignInProvider, _) {
                              return editProfileProvider.getProfileLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : editProfileProvider.getProfileModel == null
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              height: size.height * 0.13,
                                            ),
                                            Text(
                                              capitalText(
                                                editProfileProvider
                                                            .getProfileModel ==
                                                        null
                                                    ? ""
                                                    : editProfileProvider
                                                        .getProfileModel!
                                                        .firstname
                                                        .toString(),
                                              ),
                                              style:
                                                  CustomTextStyles.bodyLarge18,
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 53),
                                                child: Text(
                                                  "Member since ${editProfileProvider.getProfileModel?.dob == null || editProfileProvider.getProfileModel?.dob == null ? "" : dateFormatter(date: editProfileProvider.getProfileModel!.dob.toString())}",
                                                  style: CustomTextStyles
                                                      .bodyMediumGray700,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 27),
                                            Container(
                                              width: 238,
                                              margin: const EdgeInsets.only(
                                                left: 25,
                                                right: 27,
                                              ),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${editProfileProvider.getProfileModel!.phone}\n",
                                                      style: CustomTextStyles
                                                          .bodyLargeff000000,
                                                    ),
                                                    editProfileProvider
                                                                    .getProfileModel!
                                                                    .phone ==
                                                                null ||
                                                            editProfileProvider
                                                                    .getProfileModel!
                                                                    .phone ==
                                                                ""
                                                        ? const TextSpan(
                                                            text: "\n",
                                                          )
                                                        : editProfileProvider
                                                                    .getProfileModel!
                                                                    .phoneVerify ==
                                                                "1"
                                                            ? const TextSpan(
                                                                text: "\n",
                                                              )
                                                            : TextSpan(
                                                                text:
                                                                    "Verify Phone\n\n",
                                                                style: CustomTextStyles
                                                                    .labelLargeff59a9f2
                                                                    .copyWith(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                                recognizer:
                                                                    TapGestureRecognizer()
                                                                      ..onTap =
                                                                          () async {
                                                                        if (editProfileProvider.getProfileModel!.phone ==
                                                                            null) {
                                                                          Navigator.of(context)
                                                                              .push(
                                                                            MaterialPageRoute(
                                                                              builder: (context) => PhoneSignInScreen(),
                                                                            ),
                                                                          );
                                                                        } else {
                                                                          phoneSignInProvider.addPhoneNumber(editProfileProvider
                                                                              .getProfileModel!
                                                                              .phone
                                                                              .toString());
                                                                          await phoneSignInProvider
                                                                              .phoneLoginUser(
                                                                            context,
                                                                            phone:
                                                                                editProfileProvider.getProfileModel!.phone ?? '',
                                                                          );
                                                                        }
                                                                      },
                                                              ),
                                                    TextSpan(
                                                      text:
                                                          "${editProfileProvider.getProfileModel!.email}\n",
                                                      style: CustomTextStyles
                                                          .bodyLargeff000000,
                                                    ),
                                                    TextSpan(
                                                      text: "Verify Email\n\n",
                                                      style: CustomTextStyles
                                                          .labelLargeff59a9f2
                                                          .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: "Date Of Birth\n",
                                                      style: CustomTextStyles
                                                          .titleMediumff000000,
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${editProfileProvider.getProfileModel!.dob == null || editProfileProvider.getProfileModel!.dob == null ? "" : dateFormatter(date: editProfileProvider.getProfileModel!.dob.toString())}\n\n",
                                                      style: CustomTextStyles
                                                          .bodyLargeff000000,
                                                    ),
                                                    TextSpan(
                                                      text: "Interests\n",
                                                      style: CustomTextStyles
                                                          .titleMediumff000000,
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "${editProfileProvider.getProfileModel!.interests}",
                                                      style: CustomTextStyles
                                                          .titleMediumff000000
                                                          .copyWith(
                                                        height: 1.69,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            SizedBox(
                                              width: 291,
                                              child: Text(
                                                "${editProfileProvider.getProfileModel!.note}",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: CustomTextStyles
                                                    .bodyMediumGray700_1,
                                              ),
                                            ),
                                            SizedBox(
                                              height: size.height * 0.05,
                                            ),
                                            Consumer<DashBoardProvider>(builder:
                                                (context, dashBoardProvider,
                                                    _) {
                                              return GestureDetector(
                                                onTap: () {
                                                  dashBoardProvider
                                                      .changeCommentPage(
                                                    index: 9,
                                                  );
                                                },
                                                child: Text(
                                                  "Edit Profile",
                                                  style: CustomTextStyles
                                                      .titleSmallBlue300
                                                      .copyWith(
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        );
                            }),
                          ),
                        ),
                      ],
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

  /// Section Widget
}
