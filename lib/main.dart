import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
// var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmInfoAdapter());
  await Hive.openBox<AlarmInfo>("alarm");
  await Firebase.initializeApp(); // Initialize Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await LocalNotifications.init();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  // Stripe.publishableKey = "pk_test_24PsRoB2O46Bxxxxxxxxxxxxxxxxxxxxxxxx";
  ThemeHelper().changeTheme(
    'primary',
  );
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
        // ChangeNotifierProvider(
        //   create: (_) => EditGoalsProvider(),
        // ),
      ],
      child: const MyApp(),
    ),
  );
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
    // _checkPermissionStatus();
    // _requestPermission();
    // requestExactAlarmPermission();
  }

  Future<void> _checkPermissionStatus() async {
    final status = await Permission.locationWhenInUse.status;
    setState(() {
      permissionStatus = status;
    });
  }

  Future<void> _requestPermissions() async {
    final locationStatus = await Permission.locationWhenInUse.request();
    setState(() {
      permissionStatus = locationStatus;
    });
    await Permission.notification.request();
  }

  //
  // Future<void> _checkPermissionStatus() async {
  //   final status = await Permission.locationWhenInUse.status;
  //   setState(() {
  //     permissionStatus = status;
  //   });
  // }

  // Future<void> requestExactAlarmPermission() async {
  //   await Permission.notification.request();
  // }

  // Future<void> _requestPermission() async {
  //   final status = await Permission.locationWhenInUse.request();
  //   setState(() {
  //     permissionStatus = status;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
