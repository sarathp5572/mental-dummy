import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mentalhelth/screens/token_expiry/token_expiry.dart';
import '../../utils/logic/shared_prefrence.dart';
import '../../utils/theme/custom_text_style.dart';
import '../auth/sign_in/screen_sign_in.dart';




class TokenExpireScreen extends StatefulWidget {
  const TokenExpireScreen({super.key});

  @override
  State<TokenExpireScreen> createState() => _TokenExpireScreenState();
}

class _TokenExpireScreenState extends State<TokenExpireScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        TokenManager.setTokenStatus(false);
        addUserEmailSharePref(
          email: "",
        );
        addUserPasswordSharePref(
          password: "",
        );
        return false;
      },
      child: Scaffold(
          body: Container(
              height: height,
              width: width,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0, color: Colors.white),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(25),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue,
                            width: 0.5),
                        borderRadius: BorderRadius.circular(5),

                      ),
                      child: Column(
                        children: [
                          const Gap(15),
                          Image.asset(
                            'assets/images/timeout.png', // Path to your Lottie file
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Login timed out ,Please login again !!.',
                              style: CustomTextStyles.bodySmallGray500,
                            ),
                          ),
                          const Gap(30),
                          SizedBox(
                            width: width * 0.80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    TokenManager.setTokenStatus(false);
                                    addUserEmailSharePref(
                                      email: "",
                                    );
                                    addUserPasswordSharePref(
                                      password: "",
                                    );
                                    SystemNavigator.pop();
                                  },
                                  child: Container(
                                    width: width * 0.35,
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment(105.598, -73.2617),
                                        end: Alignment(-130.141, 80.5293),
                                        colors: [
                                          Colors.blue,
                                          Colors.blueAccent,
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Cancel',
                                          style:
                                          CustomTextStyles.bodySmallGray500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    TokenManager.setTokenStatus(false);
                                    addUserEmailSharePref(
                                      email: "",
                                    );
                                    addUserPasswordSharePref(
                                      password: "",
                                    );
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (_, __, ___) =>
                                         ScreenSignIn(),
                                        transitionDuration:
                                        const Duration(seconds: 0),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: width * 0.35,
                                    height: 40,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      gradient: const LinearGradient(
                                        begin: Alignment(105.598, -73.2617),
                                        end: Alignment(-130.141, 80.5293),
                                        colors: [
                                         Colors.blue,
                                          Colors.blueAccent,
                                        ],
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Login',
                                          style:
                                          CustomTextStyles.bodySmallGray500
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Gap(15),
                        ],
                      ),
                    ),

                  ],
                ),
              ))),
    );
  }
}
