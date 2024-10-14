import 'dart:async'; // Import this for runZonedGuarded
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart'; // Import for Crashlytics
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentalhelth/firebase_options.dart';
import 'package:mentalhelth/screens/addactions_screen/model/alaram_info.dart';
import 'package:mentalhelth/screens/auth/signup_screen/provider/signup_provider.dart';
import 'package:mentalhelth/screens/auth/splash/splash.dart';
import 'package:mentalhelth/screens/auth/subscribe_plan_page/provider/subscribe_plan_provider.dart';
import 'package:mentalhelth/screens/dash_borad_screen/provider/dash_board_provider.dart';
import 'package:mentalhelth/screens/edit_add_profile_screen/provider/edit_provider.dart';
import 'package:mentalhelth/screens/goals_dreams_page/provider/goals_dreams_provider.dart';
import 'package:mentalhelth/screens/journal_list_screen/provider/journal_list_provider.dart';
import 'package:mentalhelth/screens/mental_strength_add_edit_screen/provider/mental_strenght_edit_provider.dart';
import 'package:mentalhelth/utils/core/local_notification.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'screens/actions_screen/provider/my_action_provider.dart';
import 'screens/addactions_screen/provider/add_actions_provider.dart';
import 'screens/addgoals_dreams_screen/provider/ad_goals_dreams_provider.dart';
import 'screens/auth/sign_in/provider/sign_in_provider.dart';
import 'screens/confirm_delete_screen/provider/delete_provider.dart';
import 'screens/confirm_plan_screen/provider/my_plan_provider.dart';
import 'screens/feedback_screen/provider/feed_back_provider.dart';
import 'screens/home_screen/provider/home_provider.dart';
import 'screens/phone_singin_screen/provider/phone_sign_in_provider.dart';
import 'screens/privacy_screen/provider/privacy_policy_provider.dart';
import 'utils/theme/theme_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmInfoAdapter());
  await Hive.openBox<AlarmInfo>("alarm");

  // Set up Firebase and Crashlytics
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp(); // Initialize Firebase
  }

  // Set up Crashlytics for Flutter errors
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Use runZonedGuarded for any uncaught asynchronous errors
  runZonedGuarded(() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => SignInProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SignUpProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => SubScribePlanProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PhoneSignInProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => EditProfileProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => DashBoardProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => GoalsDreamsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => JournalListProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ConfirmPlanProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => HomeProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => DeleteProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => PrivacyPolicyProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => FeedBackProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => AdDreamsGoalsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => AddActionsProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => MentalStrengthEditProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => MyActionProvider(),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }, FirebaseCrashlytics.instance.recordError);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PermissionStatus permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
    _requestPermissions();
  }

  Future<void> _checkPermissionStatus() async {
    // Check location permission status
    final status = await Permission.locationWhenInUse.status;
    setState(() {
      permissionStatus = status;
    });
  }

  Future<void> _requestPermissions() async {
    // Request location permission (Platform specific)
    if (Platform.isIOS) {
      await Permission.locationWhenInUse.request();
      await Permission.notification.request();
      await Permission.photos.request();
    } else if (Platform.isAndroid) {
      await Permission.locationWhenInUse.request();
      await Permission.notification.request();
      await Permission.storage.request(); // For storage permissions
      await Permission.manageExternalStorage.request(); // For Android 11 and above
    }

    // Check updated location permission status
    final locationStatus = await Permission.locationWhenInUse.status;
    setState(() {
      permissionStatus = locationStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
