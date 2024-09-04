import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mentalhelth/screens/auth/sign_in/model/login_model.dart';
import 'package:mentalhelth/screens/auth/sign_in/model/social_media_login.dart';
import 'package:mentalhelth/screens/dash_borad_screen/dash_board_screen.dart';
import 'package:mentalhelth/utils/core/url_constant.dart';
import 'package:mentalhelth/utils/logic/shared_prefrence.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';

import '../../../token_expiry/token_expiry.dart';
import '../../subscribe_plan_page/subscribe_plan_page.dart';

class SignInProvider extends ChangeNotifier {
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();

  //stripe webview functions

  void clearTextEditingController() {
    emailFieldController.clear();
    passwordFieldController.clear();
    notifyListeners();
  }

  // bool isWebViewSuccessStarted = false;
  LoginModel? loginModel;
  bool loginLoading = false;

  Future<void> loginUser(BuildContext context,
      {required String email, required String password}) async {
    try {
      loginLoading = true;
      notifyListeners();
      var body = {
        'email': email,
        'password': password,
      };
      final response = await http.post(
        Uri.parse(
          UrlConstant.loginUrl,
        ),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        TokenManager.setTokenStatus(false);
        loginModel = loginModelFromJson(
          response.body,
        );
        addUserIdSharePref(
          userId: loginModel!.userId!,
        );
        addUserTokenSharePref(
          token: loginModel!.userToken!,
        );
        addUserStatusSharePref(
          token: loginModel!.status!,
        );
        await addUserSubScribeSharePref(
            subscribe: loginModel!.isSubscribed.toString());
        addUserEmailSharePref(
          email: email,
        );
        addUserPasswordSharePref(
          password: password,
        );
        if (loginModel!.status!) {
          if (loginModel!.isSubscribed == "0") {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => SubscribePlanPage(),
              ),
              (route) => false,
            );
          } else {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const DashBoardScreen(),
              ),
              (route) => false,
            );
          }
        }
      } else {
        showCustomSnackBar(
          context: context,
          message: 'Login failed.',
        );
      }
      if(response.statusCode == 401){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      if(response.statusCode == 403){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      loginLoading = false;
      notifyListeners();
      emailFieldController.clear();
      passwordFieldController.clear();
    } catch (error) {
      emailFieldController.clear();
      passwordFieldController.clear();
      loginLoading = false;
      notifyListeners();
    }
  }

  bool forgetLoading = false;

  Future<void> forgetPassword(
    BuildContext context,
  ) async {
    try {
      forgetLoading = true;
      notifyListeners();
      var body = {
        'email': emailFieldController.text,
      };
      final response = await http.post(
        Uri.parse(
          UrlConstant.forgotPassword,
        ),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      var jsonResponse = jsonDecode(response.body);
      print('Decoded response: $jsonResponse');
      if (response.statusCode == 200 || response.statusCode == 201) {
        showToast(
          context: context,
          message: jsonResponse['text'] ??
              "Please check your mail to reset your password!",
        );
      } else {
        showToast(
          context: context,
          message: jsonResponse['text'] ?? 'Forget password failed',
        );
      }
      if(response.statusCode == 401){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      if(response.statusCode == 403){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      forgetLoading = false;
      notifyListeners();
      emailFieldController.clear();
      passwordFieldController.clear();
    } catch (error) {
      emailFieldController.clear();
      passwordFieldController.clear();
      forgetLoading = false;
      notifyListeners();
    }
  }

  void signInWithGoogle({required BuildContext context}) async {
    try {
      socialMediaModelLoading = true;
      notifyListeners();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      String? googleId = googleUser?.id;
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User user = userCredential.user!;

      String? firebaseRegistrationId = await user.getIdToken();
      String os = Platform.operatingSystem;
      await socialMediaFunction(
        context,
        googleid: googleId,
      );
      await saveFirebaseToken(context,
          registrationId: firebaseRegistrationId.toString(), deviceOs: os);
    } catch (e) {
      return null;
    }
  }

  void signInWithFacebook() async {
    try {
      socialMediaModelLoading = true;
      notifyListeners();
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult.status == LoginStatus.success) {
        final AccessToken? accessToken = loginResult.accessToken;
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken!.token);
        await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }

  void googleSignOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // ignore: empty_catches
    } catch (e) {}
  }

// social MediaLoagin

  SocialMediaModel? socialMediaModel;
  bool socialMediaModelLoading = false;

  Future<void> socialMediaFunction(BuildContext context,
      {String? fbid, String? googleid, String? appleid}) async {
    try {
      // var body = {
      //   'fbid': email,
      //   'googleid': password,
      //   'appleid': appleid,
      // };
      var body = {};
      if (fbid != null) {
        body = {'fbid': fbid};
      } else if (googleid != null) {
        body = {'googleid': googleid};
      } else if (appleid != null) {
        body = {'appleid': appleid};
      }
      final response = await http.post(
        Uri.parse(
          UrlConstant.socialmedialoginUrl,
        ),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        socialMediaModel = socialMediaModelFromJson(
          response.body,
        );
        addUserIdSharePref(
          userId: socialMediaModel!.userId!,
        );
        addUserTokenSharePref(
          token: socialMediaModel!.userToken!,
        );
        addUserStatusSharePref(
          token: socialMediaModel!.status!,
        );
        addUserSubScribeSharePref(
            subscribe: socialMediaModel!.isSubscribed.toString());

        if (socialMediaModel!.status!) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SubscribePlanPage(),
            ),
          );
        }
      } else {
        showCustomSnackBar(context: context, message: 'Login failed.');
      }
      if(response.statusCode == 401){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      if(response.statusCode == 403){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      socialMediaModelLoading = false;
      notifyListeners();
    } catch (error) {
      socialMediaModelLoading = false;
      notifyListeners();
    }
  }

  //save firebase token
  bool saveFirebaseLoading = false;

  Future<void> saveFirebaseToken(BuildContext context,
      {required String registrationId, required String deviceOs}) async {
    try {
      saveFirebaseLoading = true;
      notifyListeners();
      String? token = await getUserTokenSharePref();
      var headers = {
        'Device-Type': 'android',
        'Version': '2.0',
        'authorization': token.toString()
      };
      var body = {
        'registration_id': registrationId,
        'device_os': deviceOs,
      };

      final response = await http.post(
        Uri.parse(
          UrlConstant.savefirebasetokenUrl,
        ),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
      } else {}
      if(response.statusCode == 401){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      if(response.statusCode == 403){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      saveFirebaseLoading = false;
      notifyListeners();
    } catch (error) {
      saveFirebaseLoading = false;
      notifyListeners();
    }
  }

  Future callSignInButton(BuildContext context) async {
    if (emailFieldController.text.isNotEmpty &&
        passwordFieldController.text.isNotEmpty) {
      await loginUser(
        context,
        email: emailFieldController.text,
        password: passwordFieldController.text,
      );
    } else if (emailFieldController.text.isEmpty) {
      showCustomSnackBar(
        context: context,
        message: "Enter your email and password",
      );
      emailFieldController.clear();
      passwordFieldController.clear();
    } else {
      showCustomSnackBar(
        context: context,
        message: "Enter your email and password",
      );
      emailFieldController.clear();
      passwordFieldController.clear();
    }
  }
}
