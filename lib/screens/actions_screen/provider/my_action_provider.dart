import 'package:flutter/cupertino.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';

class MyActionProvider extends ChangeNotifier {
  bool completed = false;
  int curselIndex = 0;
  void changeValue({required int index}) {
    curselIndex = index;
    notifyListeners();
  }

  final List<String> imageList = [
    ImageConstant.imgThumbsUp,
    ImageConstant.imgThumbsUp,
    ImageConstant.imgThumbsUp,
    ImageConstant.imgThumbsUp,
    ImageConstant.imgThumbsUp
  ];
}
