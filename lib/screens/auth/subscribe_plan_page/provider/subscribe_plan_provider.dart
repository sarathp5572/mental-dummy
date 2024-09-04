import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mentalhelth/screens/auth/subscribe_plan_page/model/subscribe_plan_model.dart';
import 'package:mentalhelth/utils/core/url_constant.dart';

class SubScribePlanProvider extends ChangeNotifier {
  GetPlansModel? getPlansModel;
  bool getPlansLoading = false;

  Future<void> fetchPlans() async {
    try {
      getPlansLoading = true;
      notifyListeners();
      final response = await http.get(Uri.parse(UrlConstant.plansUrl));

      if (response.statusCode == 200) {
        getPlansModel = getPlansModelFromJson(response.body);
        notifyListeners();
      } else {}
      getPlansLoading = false;
      notifyListeners();
    } catch (e) {
      getPlansLoading = false;
      notifyListeners();
    }
  }
}
