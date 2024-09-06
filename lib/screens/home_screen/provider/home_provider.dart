import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:mentalhelth/screens/home_screen/model/jounals_model.dart';
import 'package:mentalhelth/utils/core/date_time_utils.dart';
import 'package:mentalhelth/utils/core/url_constant.dart';
import 'package:mentalhelth/utils/logic/shared_prefrence.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';

import '../../token_expiry/token_expiry.dart';
import '../model/chart_view_model.dart';
import '../model/journal_details.dart';

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
