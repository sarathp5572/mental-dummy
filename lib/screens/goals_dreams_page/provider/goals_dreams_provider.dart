import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mentalhelth/utils/core/url_constant.dart';

import '../../../utils/logic/shared_prefrence.dart';
import '../../../widgets/functions/snack_bar.dart';
import '../model/goals_and_dreams_model.dart';

class GoalsDreamsProvider extends ChangeNotifier {
  bool isScrolling = false;

  void scrollTrue({required bool value}) {
    isScrolling = value;
    notifyListeners();
  }

  int curselIndex = 0;

  void changeValue({required int index}) {
    curselIndex = index;
    notifyListeners();
  }

  int openBox = 0;

  void openBoxFunction({required int index}) {
    openBox = index;
    notifyListeners();
  }

  GoalsAndDreamsModel? goalsAndDreamsModel;
  bool goalsAndDreamsModelLoading = false;
  List<Goalsanddream> goalsanddreams = [];

  int pageLoad = 1;

  Future fetchGoalsAndDreams({bool initial = false}) async {
    // try {
    // goalsAndDreamsModel = null;
    String? token = await getUserTokenSharePref();
    goalsAndDreamsModelLoading = true;
    notifyListeners();
    Map<String, String> headers = {
      'authorization': token!, // Assuming token is not null
    };
    if (initial) {
      pageLoad = 1;
      goalsanddreams.clear();
      notifyListeners();
    } else {
      pageLoad += 1;
      notifyListeners();
    }

    notifyListeners();
    Uri url = Uri.parse(
      UrlConstant.goalsanddreamsUrl(
        page: pageLoad.toString(),
      ),
    );
    final response = await http.get(
      url,
      headers: headers,
    );

    log(response.body.toString(), name: " fetchGoalsAndDreams");
    if (response.statusCode == 200) {
      goalsAndDreamsModel = goalsAndDreamsModelFromJson(response.body);

      if (initial) {
        goalsanddreams.clear();

        if (goalsAndDreamsModel != null) {
          if (goalsAndDreamsModel!.goalsanddreams != null) {
            goalsanddreams.addAll(goalsAndDreamsModel!.goalsanddreams!);
          }
        }
      } else {
        if (goalsAndDreamsModel != null) {
          if (goalsAndDreamsModel!.goalsanddreams != null) {
            goalsanddreams.addAll(goalsAndDreamsModel!.goalsanddreams!);
          }
        }
      }

      notifyListeners();
    } else {
      goalsAndDreamsModelLoading = false;
      notifyListeners();
    }
    goalsAndDreamsModelLoading = false;
    notifyListeners();
    // } catch (e) {
    //   log(e.toString());
    //   goalsAndDreamsModelLoading = false;
    //   notifyListeners();
    // }
  }

  //update goal status
  bool updateGoalStatusLoading = false;

  Future<void> updateGoalsStatus(BuildContext context,
      {required String goalId, required String status}) async {
    try {
      String? token = await getUserTokenSharePref();
      // log(phone);
      updateGoalStatusLoading = true;
      notifyListeners();

      var body = {
        'goal_id': goalId,
        'status': status,
      };
      final response = await http.post(
        Uri.parse(
          UrlConstant.updateGoalstatusUrl,
        ),
        headers: <String, String>{
          // 'Content-Type': 'application/x-www-form-urlencoded',
          'authorization': token!,
        },
        body: body,
      );

      if (response.statusCode == 200) {
        showCustomSnackBar(context: context, message: 'goal update success.');
      } else {
        showCustomSnackBar(context: context, message: 'goal update failed.');
      }
      updateGoalStatusLoading = false;
      notifyListeners();
    } catch (error) {
      updateGoalStatusLoading = false;
      notifyListeners();
    }
  }

  //delete goal
  bool deleteGoalsLoading = false;

  Future<bool> deleteGoalsFunction({required String deleteId}) async {
    try {
      deleteGoalsLoading = true;
      notifyListeners();
      String? token = await getUserTokenSharePref();

      Map<String, String> headers = {
        'authorization': token!, // Assuming token is not null
      };
      notifyListeners();
      Uri url = Uri.parse(
        UrlConstant.deleteGoal(
          goal: deleteId,
        ),
      );
      final response = await http.delete(
        url,
        headers: headers,
      );

      notifyListeners();
      if (response.statusCode == 200) {
        // notifyListeners();
        fetchGoalsAndDreams(
          initial: true,
        );
        deleteGoalsLoading = false;

        notifyListeners();
        return true;
      } else {
        deleteGoalsLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      deleteGoalsLoading = false;
      notifyListeners();
      return false;
    }
  }
}
