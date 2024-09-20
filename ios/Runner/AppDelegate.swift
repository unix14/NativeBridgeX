import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  var devicesChannel: FlutterMethodChannel? = nil



  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    devicesChannel = FlutterMethodChannel(name: GeneralConstants.AppBundle + GeneralConstants.FlutterMethodChannelMainActivity,
        binaryMessenger: controller.binaryMessenger)
    devicesChannel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        // Note: this method is invoked on the UI thread.
        NativeMethodCallHandler.invoke(call: call, result: result)
    })

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
