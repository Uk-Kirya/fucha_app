//
//  NotificationDelegate.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 09.07.2026.
//

import Foundation
import UserNotifications


class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {


    static let shared = NotificationDelegate()


    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void
    ) {

        completionHandler([
            .banner,
            .sound,
            .badge
        ])

    }

}
