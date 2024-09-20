//
//  PushNotificationsSender.swift
//  Runner
//
//  Created by Eyal on 07/05/2024.
//  Copyright © 2024 The Chromium Authors. All rights reserved.
//

import Foundation
import CoreLocation
import CoreBluetooth

/// PushNotificationsSender class is responsible for sending push notifications
/// to the user
/// - Note: This class is a singleton class
class PushNotificationsSender: NSObject, UNUserNotificationCenterDelegate {

    private override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    
    private static let logger = NativeLogger.build(className: "PushNotificationsSender")

    /// Setup a notification
    /// - Parameters:
    ///   - id: The identifier of the notification (default is nil)
    ///   - title: The title of the notification
    ///   - msg: The message of the notification
    static func setupNotification(id: String? = nil, title: String, msg: String) {
        logger.log(eventName: "setupNotification()")

        let content = UNMutableNotificationContent()
        content.title = title
        content.body = msg
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "categoryIdentifier
    
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(1), repeats: false)
        let request = UNNotificationRequest(identifier: notificationId!, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()

        center.add(request) { (error : Error?) in
            if let theError = error {
                logger.log(eventName: "theError \(theError)")
            }
        }
    }
    
    /// This method will be called when app received push notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
}
