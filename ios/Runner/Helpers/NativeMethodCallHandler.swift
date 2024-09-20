//
//  NativeMethodCallHandler.swift
//  Runner
//
//  Created by Eyal on 09/05/2024.
//  Copyright © 2024 The Chromium Authors. All rights reserved.
//

import Foundation
import CoreBluetooth

/// NativeMethodCallHandler is a singleton class that handles the method calls from the Flutter side.
/// It is responsible for invoking the appropriate methods based on the method name.
class NativeMethodCallHandler {
    
    static var logger = NativeLogger.build(className: "NativeMethodCallHandler")

    static var intNumber = -1

    /// This method is responsible for invoking the appropriate methods based on the method name.
    static func invoke(call: FlutterMethodCall, result: FlutterResult){
        switch call.method {
            case NativeMethods.sendNotification:
                guard let args = call.arguments else {
                    result(-1)
                    return
                }
                if let myArgs = args as? [String: Any] {
                    print(eventName: "showing notification: \(myArgs["title"] as! String)")
                    PushNotificationsSender.setupNotification(id: myArgs["id"] as! String, title: myArgs["title"] as! String, msg: myArgs["text"] as! String)
                }
                result(1)
                return
            case NativeMethods.clearAllNotifications:
                print(eventName: "starting clearAllNotifications")
                let center = UNUserNotificationCenter.current()
                center.removeAllDeliveredNotifications()
                result(1)
                return
            case NativeMethods.setInt:
                print(eventName: "starting setInt")
                guard let args = call.arguments else {
                  result(-1)
                  return
                }
                if let myArgs = args as? [String: Any],
                   intNumber = myArgs["number"] as? String {
                   print(eventName: "set Int to \(intNumber)")
                }
                return
            case NativeMethods.getInt:
                print(eventName: "starting getInt")
                result(intNumber)
                return
            case NativeMethods.login:
                print(eventName: "starting login")
                result(1)
                return
            case NativeMethods.logout:
                print(eventName: "starting logout")
                result(1)
                return
            case NativeMethods.openUrl:
                print(eventName: "starting openUrl")
                guard let args = call.arguments else {
                    return
                }
                if let myArgs = args as? [String: Any] {
                    print(eventName: "opening url: \(myArgs["url"] as! String)")
                    if let url = URL(string: myArgs["url"] as! String) {
                        UIApplication.shared.open(url)
                    }
                }
                return
            default:
                result(FlutterMethodNotImplemented)
                return
        }
    }
}