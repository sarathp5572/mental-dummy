import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/dash_borad_screen/provider/dash_board_provider.dart';
import 'package:mentalhelth/screens/edit_add_profile_screen/provider/edit_provider.dart';
import 'package:mentalhelth/utils/theme/custom_button_style.dart';
import 'package:mentalhelth/widgets/background_image/background_imager.dart';
import 'package:mentalhelth/widgets/custom_elevated_button.dart';
import 'package:mentalhelth/widgets/custom_text_form_field.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';
import 'package:provider/provider.dart';

import '../../utils/theme/app_decoration.dart';
import '../../utils/theme/custom_text_style.dart';
import '../../utils/theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/custom_image_view.dart';
import 'model/get_category.dart';

class EditAddProfileScreen extends StatelessWidget {
  EditAddProfileScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: backGroundImager(
        size: size,
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            buildAppBar(context, size),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Form(
                  key: _formKey,
                  child: Container(
                    width: double.maxFinite,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.1,
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(left: 1, bottom: 5),
                                  padding: const EdgeInsets.all(
                                    18,
                                  ),
                                  decoration: BoxDecoration(
                                    color: appTheme.gray200,
                                    borderRadius: BorderRadius.circular(
                                      30,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 40),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Name *",
                                            style: CustomTextStyles
                                                .bodyMediumGray700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      _buildMyProfile(context),
                                      const SizedBox(height: 11),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            "Phone",
                                            style: CustomTextStyles
                                                .bodyMediumGray700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      _buildPhone(context),
                                      const SizedBox(height: 9),
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text("Email *",
                                                  style: CustomTextStyles
                                                      .bodyMediumGray700))),
                                      const SizedBox(height: 2),
                                      _buildEmail(context),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Date Of Birth",
                                            style: CustomTextStyles
                                                .bodyMediumGray700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Consumer<EditProfileProvider>(builder:
                                          (context, editProfileProvider, _) {
                                        return GestureDetector(
                                          onTap: () {
                                            editProfileProvider
                                                .selectDate(context);
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            decoration: AppDecoration
                                                .outlineGray700
                                                .copyWith(
                                              borderRadius: BorderRadiusStyle
                                                  .roundedBorder4,
                                              color: Colors.transparent,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  editProfileProvider
                                                      .selectedDate,
                                                  style: CustomTextStyles
                                                      .bodyMediumOnPrimary,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                      const SizedBox(height: 14),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Interests",
                                            style: CustomTextStyles
                                                .bodyMediumGray700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      // _buildInterestsValue(context),
                                      Consumer<EditProfileProvider>(builder:
                                          (context, editProfileProvider, _) {
                                        return Container(
                                          height: size.height * 0.05,
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          decoration: const ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1.0,
                                                  style: BorderStyle.solid),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                            ),
                                          ),
                                          child: DropdownButton<Category>(
                                            items: editProfileProvider
                                                .getCategoryModel!.category!
                                                .map((Category value) {
                                              return DropdownMenuItem<Category>(
                                                value: value,
                                                child: Text(value.categoryName
                                                    .toString()),
                                              );
                                            }).toList(),
                                            hint: Text(
                                              editProfileProvider
                                                      .interestsValueController
                                                      .text
                                                      .isEmpty
                                                  ? 'Music, Badminton'
                                                  : editProfileProvider
                                                      .interestsValueController
                                                      .text,
                                            ),
                                            iconSize: 0,
                                            icon: null,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            underline: const SizedBox(),
                                            isExpanded: true,
                                            onChanged: (value) {
                                              if (value != null) {
                                                editProfileProvider
                                                    .selectCategory(
                                                  value: value.categoryName
                                                      .toString(),
                                                  mainCategory: value,
                                                );
                                              }
                                            },
                                          ),
                                        );
                                      }),
                                      const SizedBox(height: 8),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 9,
                                          ),
                                          child: Text(
                                            "About You",
                                            style: CustomTextStyles
                                                .bodyMediumGray700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      _buildAboutYouValue(context),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      _buildSave(
                                        context,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Consumer<EditProfileProvider>(
                            builder: (context, editProfileProvider, _) {
                          return Positioned(
                            top: size.height * 0.045,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              margin: const EdgeInsets.all(
                                0,
                              ),
                              color: theme.colorScheme.primary.withOpacity(
                                1,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusStyle.circleBorder54,
                              ),
                              child: Container(
                                height: size.height * 0.12,
                                width: size.height * 0.12,
                                decoration: AppDecoration.fillPrimary.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.circleBorder54,
                                ),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        editProfileProvider.getImageFromGallery(
                                            context: context);
                                      },
                                      child: editProfileProvider.images != null
                                          ? Image.file(
                                              editProfileProvider.images!,
                                              height: 200,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            )
                                          : CustomImageView(
                                              imagePath: editProfileProvider
                                                  .profileUrl
                                                  .toString(),
                                              height: size.height * 0.13,
                                              width: size.height * 0.13,
                                              radius: BorderRadius.circular(54),
                                              alignment: Alignment.center,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          bottom: size.height * 0.01,
                                        ),
                                        child: Text(
                                          "Change Photo",
                                          style: CustomTextStyles
                                              .blackTextStyleCustomWhiteW800(
                                            size: size.width * 0.03,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMyProfile(BuildContext context) {
    return Consumer<EditProfileProvider>(
        builder: (context, editProfileProvider, _) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 1),
        child: CustomTextFormField(
          controller: editProfileProvider.myProfileController,
          hintText: "Josh_Peter",
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      );
    });
  }

  /// Section Widget
  Widget _buildPhone(BuildContext context) {
    return Consumer<EditProfileProvider>(
        builder: (context, editProfileProvider, _) {
      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 1),
        child: CustomTextFormField(
          isValids: editProfileProvider.phoneIsValid,
          textInputType: TextInputType.phone,
          controller: editProfileProvider.phoneController,
          hintText: "+00 0000000000",
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
          onChanged: (value) {
            editProfileProvider.phoneValidate(
              editProfileProvider.validatePhoneNumber(value),
            );
          },
        ),
      );
    });
  }

  Widget _buildEmail(BuildContext context) {
    return Consumer<EditProfileProvider>(
        builder: (context, editProfileProvider, _) {
      return Padding(
          padding: const EdgeInsets.only(left: 10, right: 1),
          child: CustomTextFormField(
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            controller: editProfileProvider.emailController,
            hintText: "Josh_Peter@gmail.com",
            textInputType: TextInputType.emailAddress,
          ));
    });
  }

  /// Section Widget
  // Widget _buildInterestsValue(BuildContext context) {
  //   return Consumer<EditProfileProvider>(
  //     builder: (context, editProfileProvider, _) {
  //       return Padding(
  //         padding: const EdgeInsets.only(left: 10),
  //         child: CustomTextFormField(
  //           hintStyle: const TextStyle(
  //             color: Colors.black,
  //           ),
  //           controller: editProfileProvider.interestsValueController,
  //           hintText: "Music, Badminton",
  //         ),
  //       );
  //     },
  //   );
  // }

  /// Section Widget
  Widget _buildAboutYouValue(BuildContext context) {
    return Consumer<EditProfileProvider>(
        builder: (context, editProfileProvider, _) {
      return Padding(
          padding: const EdgeInsets.only(left: 9, right: 1),
          child: CustomTextFormField(
              controller: editProfileProvider.aboutYouValueController,
              hintText:
                  "I am working as a designer, I love to make User interfaces with a better UX and flexibility",
              hintStyle: CustomTextStyles.bodyMediumGray70013,
              textInputAction: TextInputAction.done,
              maxLines: 4));
    });
  }

  /// Section Widget
  Widget _buildSave(BuildContext context) {
    return Consumer2<EditProfileProvider, DashBoardProvider>(
        builder: (contexts, editProfileProvider, dashBoardProvider, _) {
      return CustomElevatedButton(
        loading: editProfileProvider.editLoading,
        buttonStyle: CustomButtonStyles.outlinePrimary,
        width: 104,
        text: "Save",
        onPressed: () async {
          if (editProfileProvider.myProfileController.text.isEmpty) {
            showToast(context: context, message: 'Please enter your name');
          } else if (!editProfileProvider.phoneIsValid) {
            showToast(context: context, message: 'Invalid phone number');
          } else if (editProfileProvider.selectedDate.isEmpty) {
            showToast(context: context, message: 'Select your date of birth');
          } else {
            await editProfileProvider.editProfileFunction(
              firstName: editProfileProvider.myProfileController.text,
              note: editProfileProvider.aboutYouValueController.text,
              profileimg: editProfileProvider.profileUrl.toString(),
              dob: editProfileProvider.date.toString(),
              phone: editProfileProvider.phoneController.text,
              context: context,
              intrestId: editProfileProvider.categorys == null
                  ? "1"
                  : editProfileProvider.categorys!.id.toString(),
            );
            dashBoardProvider.changeCommentPage(
              index: 8,
            );
          }
        },
      );
    });
  }
}