import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mentalhelth/screens/auth/subscribe_plan_page/model/subscribe_plan_model.dart';
import 'package:mentalhelth/utils/core/url_constant.dart';

import '../../../token_expiry/token_expiry.dart';

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
      if(response.statusCode == 401){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      if(response.statusCode == 403){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      getPlansLoading = false;
      notifyListeners();
    } catch (e) {
      getPlansLoading = false;
      notifyListeners();
    }
  }
}
