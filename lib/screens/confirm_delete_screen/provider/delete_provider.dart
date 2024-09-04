import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentalhelth/utils/core/url_constant.dart';
import 'package:mentalhelth/utils/logic/shared_prefrence.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';

import '../../auth/sign_in/screen_sign_in.dart';

class DeleteProvider extends ChangeNotifier {
  // SignUpModel? signUpModel;
  bool deleteAccountLoading = false;

  Future<void> deleteAccount({required BuildContext context}) async {
    try {
      String? token = await getUserTokenSharePref();
      deleteAccountLoading = true;
      notifyListeners();
      var body = {
        'type': "delete",
      };
      final response = await http.post(
        Uri.parse(
          UrlConstant.accountUrl,
        ),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': token.toString()
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        await removeUserDetailsSharePref(context: context);
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => ScreenSignIn(),
          ),
          (route) => false,
        );

        showCustomSnackBar(context: context, message: 'Account Deleted');
      } else {
        showCustomSnackBar(context: context, message: 'failed.');
      }
      deleteAccountLoading = false;
      notifyListeners();
    } catch (error) {
      deleteAccountLoading = false;
      notifyListeners();
      showCustomSnackBar(context: context, message: error.toString());
    }
  }
}
