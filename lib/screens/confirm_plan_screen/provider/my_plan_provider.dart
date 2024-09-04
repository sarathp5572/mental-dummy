import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentalhelth/screens/confirm_plan_screen/model/subscribe_plan_model.dart';
import 'package:mentalhelth/screens/flutter_stripe_webview/flutter_stripe_webview.dart';
import 'package:mentalhelth/utils/core/url_constant.dart';
import 'package:mentalhelth/utils/logic/shared_prefrence.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';

class ConfirmPlanProvider extends ChangeNotifier {
  TextEditingController nameEditTextController = TextEditingController();

  TextEditingController phoneEditTextController = TextEditingController();

  TextEditingController emailEditTextController = TextEditingController();

  TextEditingController priceEditTextController = TextEditingController();
  SubScribePlanModel? subScribePlanModel;
  bool subScribePlanModelLoading = false;

  Future<void> subScribePlanFunction(
    BuildContext context, {
    required String planId,
    required String firstname,
    required String email,
    required String phone,
  }) async {
    try {
      String? userId = await getUserIdSharePref();
      String? token = await getUserTokenSharePref();
      // String? subscribeId = await getUserSubScribeSharePref();
      subScribePlanModelLoading = true;
      notifyListeners();

      var body = {
        'plan_id': planId,
        // 'is_subscribed': subscribeId,
        'user_id': userId,
        'firstname': firstname,
        'email': email,
        'phone': phone,
      };

      final response = await http.post(
        Uri.parse(
          UrlConstant.subscribePlanUrl,
        ),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          "authorization": token.toString()
        },
        body: body,
      );

      if (response.statusCode == 200) {
        subScribePlanModel = subScribePlanModelFromJson(
          response.body,
        );
        String? phone = await getUserPhoneSharePref();
        if (subScribePlanModel!.subscription!.url != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StripeWebView(
                url: subScribePlanModel!.subscription!.url.toString(),
                phone: phone == null || phone == "" ? false : true,
              ),
            ),
          );
        }
      } else {
        showCustomSnackBar(context: context, message: 'subscribing failed.');
      }
      subScribePlanModelLoading = false;
      notifyListeners();
    } catch (error) {
      subScribePlanModelLoading = false;
      notifyListeners();
      showCustomSnackBar(context: context, message: error.toString());
    }
  }

  void clearSignupControllers() {
    nameEditTextController.clear();
    phoneEditTextController.clear();
    emailEditTextController.clear();
    priceEditTextController.clear();
    subScribePlanModel = null;
    print("success fully removed data");
    notifyListeners();
  }
}
