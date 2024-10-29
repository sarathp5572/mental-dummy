import UIKit
import Flutter
import GoogleMaps
import AVFoundation
import FirebaseCore
import FirebaseMessaging
import UserNotifications


@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseConfiguration.shared.setLoggerLevel(.debug) // Change to .min for less logging
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        GeneratedPluginRegistrant.register(with: self)
        GMSServices.provideAPIKey("AIzaSyB_mUl0uBmISnObRAdQEF-Ffaa4mxq1LpQ")
        UNUserNotificationCenter.current().delegate = self
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        print("notification registered")
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        print("notification registered 2")
    }
}




