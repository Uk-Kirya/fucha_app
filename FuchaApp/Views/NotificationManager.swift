//
//  NotificationManager.swift
//  FuchaApp
//
//  Created by Kirill Lossev on 09.07.2026.
//

import Foundation
import UserNotifications


class NotificationManager {

    static let shared = NotificationManager()


    func requestPermission() {

        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(
            options: [
                .alert,
                .sound,
                .badge
            ]
        ) { granted, error in

            if let error {
                print(error)
            }

            print("Permission:", granted)
        }

    }


    func sendTestNotification() {


        let content = UNMutableNotificationContent()

        content.title = "Fucha"
        content.body = "Пора выполнить челлендж 💪"
        content.sound = .default



        let trigger =
        UNTimeIntervalNotificationTrigger(
            timeInterval: 10,
            repeats: false
        )



        let request =
        UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )


        UNUserNotificationCenter.current()
            .add(request) { error in

                if let error {
                    print(error)
                }

            }

    }

}
