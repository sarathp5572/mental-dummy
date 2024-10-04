import 'package:flutter/material.dart';
import 'package:mentalhelth/screens/auth/sign_in/provider/sign_in_provider.dart';
import 'package:mentalhelth/screens/auth/sign_in/widget/sign_in_widget.dart';
import 'package:mentalhelth/screens/edit_add_profile_screen/provider/edit_provider.dart';
import 'package:mentalhelth/screens/home_screen/provider/home_provider.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/utils/theme/custom_text_style.dart';
import 'package:mentalhelth/widgets/background_image/background_imager.dart';
import 'package:mentalhelth/widgets/custom_image_view.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';
import 'package:provider/provider.dart';

import 'forgot_password/forgot_password_screen.dart';

class ScreenSignIn extends StatelessWidget {
  ScreenSignIn({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: backGroundImager(
          size: size,
          padding: EdgeInsets.zero,
          child: Center(
              child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgLogo,
                      height: 68,
                      width: 280,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Consumer<SignInProvider>(
                        builder: (context, signInProvider, _) {
                      return PopScope(
                        canPop: true,
                        onPopInvoked: (value) {
                          signInProvider.clearTextEditingController();
                        },
                        child: buildEmailField(
                          context,
                          emailFieldController:
                              signInProvider.emailFieldController,
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 12,
                    ),
                    Consumer<SignInProvider>(
                        builder: (context, signInProvider, _) {
                      return buildPasswordField(
                        context,
                        passwordFieldController:
                            signInProvider.passwordFieldController,
                      );
                    }),
                    const SizedBox(
                      height: 14,
                    ),
                    Consumer3<SignInProvider, HomeProvider,
                            EditProfileProvider>(
                        builder: (context, signInProvider, homeProvider,
                            editProfileProvider, _) {
                      return buildSignInButton(
                        context,
                        isLoading: signInProvider.loginLoading,
                        buttonText: "Sign in",
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          await signInProvider.callSignInButton(context);
                          homeProvider.fetchChartView(context);
                        //  homeProvider.fetchJournals(initial: true);
                          editProfileProvider.fetchUserProfile();
                        },
                      );
                    }),
                    const SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<SignInProvider>(
                            builder: (context, signInProvider, _) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(
                                      ),
                                ),
                              );
                              // if (signInProvider
                              //     .emailFieldController.text.isEmpty) {
                              //
                              //   showToast(
                              //     context: context,
                              //     message: "Please enter your email",
                              //   );
                              // } else {
                              //   signInProvider.forgetPassword(
                              //     context,
                              //   );
                              // }
                            },
                            child: Text(
                              "Forgot your password ?",
                              style: CustomTextStyles.bodySmallOnPrimary,
                            ),
                          );
                        }),
                        Text(
                          "|",
                          style: CustomTextStyles.bodySmallOnPrimary,
                        ),
                        GestureDetector(
                          onTap: () {
                            onTapSignUpButton(context);
                          },
                          child: Text(
                            "Sign up",
                            style: CustomTextStyles.bodySmallOnPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 44,
                    ),
                    Consumer<SignInProvider>(
                        builder: (context, signInProvider, _) {
                      return buildContinueWithPhoneButton(
                        context,
                        message: "Continue with Phone ",
                        imageMessage: ImageConstant.imgMobilelight,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          signInProvider.clearTextEditingController();
                          onTapContinueWithPhoneButton(context);
                        },
                      );
                    }),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Consumer<SignInProvider>(
                    //     builder: (context, signInProvider, _) {
                    //   return buildContinueWithPhoneButton(
                    //     context,
                    //     message: "Continue with Facebook",
                    //     imageMessage: ImageConstant.imgFacebook,
                    //     onPressed: () {
                    //       signInProvider.signInWithFacebook();
                    //     },
                    //   );
                    // }),
                    // const SizedBox(
                    //   height: 8,
                    // // ),
                    // Consumer<SignInProvider>(
                    //   builder: (context, signInProvider, _) {
                    //     return buildContinueWithPhoneButton(
                    //       context,
                    //       message: "Continue with Google",
                    //       imageMessage: ImageConstant.imgGoogle,
                    //       onPressed: () async {
                    //         await signInProvider.loginWithGoogle();
                    //       },
                    //     );
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 8,
                    // ),
                    // Consumer<SignInProvider>(
                    //   builder: (context, signInProvider, _) {
                    //     return buildContinueWithPhoneButton(
                    //       context,
                    //       message: "Continue with Apple",
                    //       imageMessage: ImageConstant.imgPath4,
                    //       onPressed: () {
                    //         signInProvider.googleSignOut();
                    //       },
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
