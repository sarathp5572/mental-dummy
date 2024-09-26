import UIKit
import Flutter
import GoogleMaps
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        GeneratedPluginRegistrant.register(with: self)
        GMSServices.provideAPIKey("AIzaSyB_mUl0uBmISnObRAdQEF-Ffaa4mxq1LpQ")
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category")
        }
        var filePath: String!




        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
