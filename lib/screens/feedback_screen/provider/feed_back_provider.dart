import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mentalhelth/utils/core/url_constant.dart';
import 'package:mentalhelth/utils/logic/shared_prefrence.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';

class FeedBackProvider extends ChangeNotifier {
  TextEditingController nameEditTextController = TextEditingController();

  TextEditingController emailEditTextController = TextEditingController();

  TextEditingController messageEditTextController = TextEditingController();

  bool saveFeedBackLoading = false;

  Future<void> saveFeedBack(BuildContext context,
      {required String name,
      required String email,
      required String message}) async {
    try {
      saveFeedBackLoading = true;
      notifyListeners();
      String? token = await getUserTokenSharePref();
      var body = {
        'name': name,
        'email': email,
        'msg': message,
      };
      final response = await http.post(
        Uri.parse(
          UrlConstant.feedbackUrl,
        ),
        headers: <String, String>{"authorization": "$token"},
        body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
            context: context, message: json.decode(response.body)["text"]);
        Navigator.of(context).pop();
        nameEditTextController.clear();
        emailEditTextController.clear();
        messageEditTextController.clear();
      } else {
        showCustomSnackBar(
            context: context, message: json.decode(response.body)["text"]);
      }
      saveFeedBackLoading = false;
      notifyListeners();
    } catch (error) {
      saveFeedBackLoading = false;
      notifyListeners();
    }
  }
}
