import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mentalhelth/screens/edit_add_profile_screen/model/edit_profile_model.dart';
import 'package:mentalhelth/screens/edit_add_profile_screen/model/get_category.dart';
import 'package:mentalhelth/utils/core/url_constant.dart';
import 'package:mentalhelth/utils/logic/date_format.dart';
import 'package:mentalhelth/utils/logic/shared_prefrence.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController myProfileController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController interestsValueController = TextEditingController();

  TextEditingController aboutYouValueController = TextEditingController();
  String selectedDate = '';
  String profileUrl =
      'https://www.clevelanddentalhc.com/wp-content/uploads/2018/03/sample-avatar.jpg';
  GetProfileModel? getProfileModel;
  bool getProfileLoading = false;

  Future<void> fetchUserProfile() async {
    try {
      getProfileModel = null;
      String? userId = await getUserIdSharePref();
      String? token = await getUserTokenSharePref();
      getProfileLoading = true;
      notifyListeners();
      Uri url = Uri.parse(
        UrlConstant.profileUrl(
          userId: userId!,
        ),
      );
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          "authorization": "$token"
        },
      );
      log(response.body.toString(), name: " response");
      if (response.statusCode == 200) {
        getProfileModel = getProfileModelFromJson(response.body);
        notifyListeners();
        fetchCategory();
        editProfileAddValue();
        notifyListeners();
      } else {
        getProfileLoading = false;
        notifyListeners();
      }
      getProfileLoading = false;
      notifyListeners();
    } catch (e) {
      log(e.toString(), name: " response e");
      getProfileLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  void editProfileAddValue() {
    myProfileController.text = getProfileModel!.firstname.toString();

    phoneController.text = getProfileModel!.phone.toString();

    emailController.text = getProfileModel!.email.toString();
    date = getProfileModel?.dob;
    selectedDate = getProfileModel?.dob == null || getProfileModel?.dob == null
        ? ""
        : dateFormatter(
            date: getProfileModel!.dob.toString(),
          );
    interestsValueController.text = getProfileModel!.interests.toString();
    aboutYouValueController.text = getProfileModel!.note.toString();
    profileUrl = getProfileModel!.profileurl.toString();
  }

  DateTime? date;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != date) {
      date = picked;
      selectedDate = dateFormatter(date: picked.toString());
      notifyListeners();
    }
  }

  //image picker
  File? images;

  Future<void> getImageFromGallery({required BuildContext context}) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images = File(pickedFile.path);
      await saveMediaUpload(
        context,
        file: images!,
        type: "profile",
      );
      notifyListeners();
    }
  }

  //media upload function
  bool saveMediaUploadLoading = false;

  Future<void> saveMediaUpload(BuildContext context,
      {required File file, required String type}) async {
    try {
      String? token = await getUserTokenSharePref();
      saveMediaUploadLoading = true;
      notifyListeners();
      var headers = {
        "authorization": "$token",
      };
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          UrlConstant.mediauploadUrl,
        ),
      );
      request.fields.addAll({'type': type});
      request.files.add(
        await http.MultipartFile.fromPath(
          'media_name',
          file.path,
        ),
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      // print(await response.stream.bytesToString());
      String responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        String? mediaName = jsonResponse['media_name'];
        profileUrl = mediaName.toString();
      } else {}
      saveMediaUploadLoading = false;
      notifyListeners();
    } catch (error) {
      saveMediaUploadLoading = false;
      notifyListeners();
    }
  }

  //
  Future<void> getImageFromCamera() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      profileUrl = pickedFile.path;
      notifyListeners();
    }
  }

  //flutter put profile method
  bool editLoading = false;

  Future<void> editProfileFunction(
      {required String firstName,
      required String note,
      required String profileimg,
      required String dob,
      required String phone,
      required BuildContext context,
      required String intrestId}) async {
    try {
      editLoading = true;
      notifyListeners();
      String? userId = await getUserIdSharePref();
      String? token = await getUserTokenSharePref();
      final Map<String, String> headers = <String, String>{
        // 'Content-Type': 'application/json',
        "authorization": "$token"
      };
      late Map<String, dynamic> body;
      if (profileimg.startsWith("https") ||
          profileimg.startsWith("http") ||
          profileimg == "") {
        body = {
          'firstname': firstName,
          'note': note,
          'dob': dob,
          'phone': phone,
          'interest[0]': intrestId,
        };
      } else {
        body = {
          'firstname': firstName,
          'note': note,
          'profileimg': profileimg,
          'dob': dob,
          'phone': phone,
          'interest[0]': intrestId,
        };
      }

      final http.Response response = await http.put(
        Uri.parse(
          UrlConstant.profileUrl(userId: userId!),
        ),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        showCustomSnackBar(
          context: context,
          message: 'Successful.',
        );
        fetchUserProfile();
      } else {
        showCustomSnackBar(
          context: context,
          message: 'Edit request failed.',
        );
      }
      editLoading = false;
      notifyListeners();
    } catch (error) {
      editLoading = false;
      notifyListeners();
    }
  }

  bool saveIntrestsLoading = false;

  Future<void> saveIntrests(BuildContext context,
      {required String value}) async {
    try {
      saveIntrestsLoading = true;
      notifyListeners();
      String? token = await getUserTokenSharePref();
      var body = {
        'interest[0]': value,
      };
      final response = await http.post(
        Uri.parse(
          UrlConstant.interestsUrl,
        ),
        headers: <String, String>{
          // 'Content-Type': 'application/json',
          "authorization": "$token"
        },
        body: body,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {}
      saveIntrestsLoading = false;
      notifyListeners();
    } catch (error) {
      saveIntrestsLoading = false;
      notifyListeners();
    }
  }

  GetCategory? getCategoryModel;
  bool getCategoryLoading = false;

  Future<void> fetchCategory() async {
    try {
      getCategoryLoading = true;
      notifyListeners();
      String? token = await getUserTokenSharePref();
      final response = await http.get(
        Uri.parse(
          UrlConstant.categoryUrl,
        ),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "authorization": "$token"
        },
      );
      if (response.statusCode == 200) {
        getCategoryModel = getCategoryFromJson(response.body);
        notifyListeners();
      } else {}
      getCategoryLoading = false;
      notifyListeners();
    } catch (e) {
      getCategoryLoading = false;
      notifyListeners();
    }
  }

  Category? categorys;

  void selectCategory({required String value, required Category mainCategory}) {
    interestsValueController.text = value;
    categorys = mainCategory;
    notifyListeners();
  }

  bool phoneIsValid = true;

  void phoneValidate(bool value) async {
    phoneIsValid = value;
    notifyListeners();
  }

  bool validatePhoneNumber(String value) {
    final RegExp phoneRegex = RegExp(r'^(\d{3}[-\s]?\d{3}[-\s]?\d{4})$');
    return phoneRegex.hasMatch(value);
  }
}
