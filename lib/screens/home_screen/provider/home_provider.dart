import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:mentalhelth/screens/home_screen/model/jounals_model.dart';
import 'package:mentalhelth/utils/core/date_time_utils.dart';
import 'package:mentalhelth/utils/core/url_constant.dart';
import 'package:mentalhelth/utils/logic/shared_prefrence.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';

import '../../token_expiry/token_expiry.dart';
import '../model/chart_view_model.dart';
import '../model/journal_details.dart';
import '../model/reminder_details.dart';

class HomeProvider extends ChangeNotifier {
  ChartViewModel? chartViewModel;
  List<Chart> chartList = [];
  bool chartViewLoading = false;
  var logger = Logger();

  Future<void> fetchChartView(BuildContext context) async {
    try {
      chartViewModel = null;
      // String? userId = await getUserIdSharePref();
      String? token = await getUserTokenSharePref();
      chartViewLoading = true;
      notifyListeners();

      Map<String, String> headers = {
        'authorization': token!, // Assuming token is not null
      };
      Uri url = Uri.parse(
        UrlConstant.chartviewUrl,
      );
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        chartViewModel = chartViewModelFromJson(response.body);
        logger.w("chartViewModel ${chartViewModel?.chart}");
        for (int i = 0; i < chartViewModel!.chart!.length; i++) {
          chartList.add(
            Chart(
              emotionValue: chartViewModel!.chart![i].emotionValue,
              driveValue: chartViewModel!.chart![i].driveValue,
              score: chartViewModel!.chart![i].score,
              dateTime: formatDateToString(
                int.parse(
                  chartViewModel!.chart![i].dateTime,
                ),
              ),
            ),
          );
        }
        chartViewLoading = false;
        notifyListeners();
      }
///commented on 04-09-2024 sarath p
      // else if (response.statusCode == 403) {
      //   await removeUserDetailsSharePref(context: context);
      //   showCustomSnackBar(context: context, message: "Token Expired");
      //   chartViewLoading = false;
      //   notifyListeners();
      // }
      else {
        chartViewLoading = false;
        notifyListeners();
      }
      if(response.statusCode == 401){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      if(response.statusCode == 403){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      chartViewLoading = false;
      notifyListeners();
    } catch (e) {
      chartViewLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }

  //get the journels
  JournalsModel? journalsModel;
  List<Journal> journalsModelList = [];
  int pageLoad = 1;
  bool journalsModelLoading = false;

  Future fetchJournals({bool initial = false}) async {
    try {
      String? token = await getUserTokenSharePref();
      journalsModelLoading = true;
      notifyListeners();

      Map<String, String> headers = {
        'authorization': token!, // Assuming token is not null
      };

      if (initial) {
        pageLoad = 1;
        journalsModelList.clear();
        notifyListeners();
      } else {
        pageLoad += 1;
        notifyListeners();
      }

      Uri url = Uri.parse(
        UrlConstant.journalsUrl(
          page: pageLoad.toString(),
        ),
      );
      logger.w("url $url");

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        journalsModel = journalsModelFromJson(response.body);
        logger.w("journalsModel ${journalsModelFromJson(response.body)}");

        // Add new items without duplication
        final newJournals = journalsModel!.journals ?? [];

        // Ensure uniqueness by checking for duplicates based on a unique field like id
        for (var journal in newJournals) {
          if (!journalsModelList.any((existingJournal) => existingJournal.journalId == journal.journalId)) {
            journalsModelList.add(journal);
          }
        }

        journalsModelLoading = false;
        notifyListeners();
      } else {
        logger.w("journalsModelelse ${journalsModelFromJson(response.body)}");
        journalsModelLoading = false;
        journalsModelList.clear();
        notifyListeners();
      }

      // Handle token expiry (401, 403)
      if (response.statusCode == 401 || response.statusCode == 403) {
        TokenManager.setTokenStatus(true);
        // CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }

      journalsModelLoading = false;
      notifyListeners();
    } catch (e) {
      logger.w("catch $e");
      journalsModelLoading = false;
      notifyListeners();
    }
    notifyListeners();
  }


  //get journal details
  JournalDetails? journalDetails;
  bool journalDetailsLoading = false;



  Future<void> fetchJournalDetails({required String journalId}) async {
    try {
      journalDetails = null;
      String? token = await getUserTokenSharePref();
      journalDetailsLoading = true;
      notifyListeners();
      Map<String, String> headers = {
        'authorization': token ?? '', // Assuming token is not null
      };
      Uri url = Uri.parse(
        UrlConstant.fetchJournalDetails(journalId: journalId),
      );
      logger.w("fetchJournalDetailsUri${url}");
      final response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        journalDetails = journalDetailsFromJson(response.body);
        logger.w("journalDetails ${journalDetails}");
        notifyListeners();
      } else {
        journalDetailsLoading = false;
        logger.w("journalDetailsElse ${journalDetails}");
        notifyListeners();
      }
      if(response.statusCode == 401){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      if(response.statusCode == 403){
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      journalDetailsLoading = false;
      notifyListeners();
    } catch (e) {
      logger.w("errorCatch ${e}");
      journalDetailsLoading = false;
      notifyListeners();
    }
  }

  ReminderDetails? remindersDetails;
  bool remindersDetailsLoading = false;
  int reminderStatusCode = 0;
  TextEditingController descriptionEditTextController = TextEditingController();
  TextEditingController titleEditTextController = TextEditingController();



  Future<void> fetchRemindersDetails() async {
    try {
      remindersDetails = null;
      String? token = await getUserTokenSharePref();
      remindersDetailsLoading = true;
      notifyListeners();
      Map<String, String> headers = {
        'authorization': token ?? '', // Assuming token is not null
      };
      Uri url = Uri.parse(
        UrlConstant.fetchRemindersDetails(),
      );
      logger.w("fetchRemindersDetailsUri${url}");
      final response = await http.get(
        url,
        headers: headers,
      );
      reminderStatusCode = response.statusCode;
      if (response.statusCode == 200) {
        remindersDetails = reminderDetailsFromJson(response.body);
        logger.w("remindersDetails ${remindersDetails}");
        notifyListeners();
        reminderStatusCode = response.statusCode;
      } else {
        remindersDetailsLoading = false;
        logger.w("remindersDetailsElse ${remindersDetails}");
        notifyListeners();
        reminderStatusCode = response.statusCode;
      }
      if(response.statusCode == 401){
        reminderStatusCode = response.statusCode;
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      if(response.statusCode == 403){
        reminderStatusCode = response.statusCode;
        TokenManager.setTokenStatus(true);
        //CacheManager.setAccessToken(CacheManager.getUser().refreshToken);
      }
      remindersDetailsLoading = false;
      reminderStatusCode = response.statusCode;
      notifyListeners();
    } catch (e) {
      logger.w("errorCatch ${e}");
      remindersDetailsLoading = false;
      notifyListeners();
    }
  }

  String reminderStartDate = '';
  String reminderEndDate = '';
  TimeOfDay? reminderStartTime;
  TimeOfDay? reminderEndTime;
  String repeat = "Never";
  DateTime? date;
  TimeOfDay? remindTime;

  void reminderStartDateFunction(BuildContext context) async {
    reminderStartDate = await selectReminder(
      context,
    );
    notifyListeners();
  }

  void reminderEndDateFunction(BuildContext context) async {
    reminderEndDate = await selectReminder(
      context,
      reminderStartDates: DateFormat('d MMM y').parse(reminderStartDate),
    );
    notifyListeners();
  }


  Future<String> selectReminder(BuildContext context,
      {DateTime? reminderStartDates}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: reminderStartDates ?? DateTime.now(),
      firstDate: reminderStartDates ?? DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != date) {
      // reminderStartDate = ;
      // selectedDate = dateFormatter(date: picked.toString());
      // log(formattedDate.toString(), name: "formattedDate");
      notifyListeners();
    }
    return formatPickedDateFor2(picked!);
  }

  Future<TimeOfDay?> selectReminderTime(BuildContext context,
      {TimeOfDay? reminderStartTimes}) async {
    TimeOfDay? pickedTime;
    TimeOfDay? adjustedInitialTime;
    if (reminderStartTimes != null) {
      final DateTime adjustedInitialDateTime = DateTime(
          0, 0, 0, reminderStartTimes.hour, reminderStartTimes.minute + 1);
      adjustedInitialTime = TimeOfDay.fromDateTime(adjustedInitialDateTime);
      // Loop until the picked time is after the start time
      do {
        pickedTime = await showTimePicker(
          context: context,
          initialTime: adjustedInitialTime,
        );

        // Check if the picked time is not null and is before or equal to the start time
        if (pickedTime != null &&
            (pickedTime.hour < reminderStartTimes.hour ||
                (pickedTime.hour == reminderStartTimes.hour &&
                    pickedTime.minute <= reminderStartTimes.minute))) {
          // Show a warning Snackbar
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('End time must be after start time.'),
          ));
        }
      } while (pickedTime != null &&
          (pickedTime.hour < reminderStartTimes.hour ||
              (pickedTime.hour == reminderStartTimes.hour &&
                  pickedTime.minute <= reminderStartTimes.minute)));
    } else {
      // If no start time is provided, show the TimePicker with the current time
      pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
    }

    return pickedTime;
  }

  void reminderStartTimeFunction(BuildContext context) async {
    reminderStartTime = await selectReminderTime(
      context,
    );
    reminderEndTime = null;
    notifyListeners();
  }

  void reminderEndTimeFunction(BuildContext context) async {
    reminderEndTime = await selectReminderTime(
      context,
      reminderStartTimes: reminderStartTime,
    );
    notifyListeners();
  }

  void addRepeatValue(String value) {
    repeat = value;
    notifyListeners();
  }



  Future<void> remindTimeFunction(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null && picked != remindTime) {
      remindTime = picked;
      notifyListeners();
    }
  }



  /// NO DATA ITEMS
  PageController noDataPageController = PageController();

  List<String> noDataImageList = [
    'assets/images/home/slide1.jpg',
    'assets/images/home/slide2.jpg',
    'assets/images/home/slide3.jpg',
  ];

  int noDataCurrentIndex = 0;

  void noDataIndexChangeFunction(int index) {
    noDataCurrentIndex = index;
    notifyListeners();
  }
}
