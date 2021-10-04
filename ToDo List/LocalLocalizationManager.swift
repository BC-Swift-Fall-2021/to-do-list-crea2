//
//  LocalLocalizationManager.swift
//  ToDo List
//
//  Created by Christopher Rea on 10/4/21.
//

import UIKit
import UserNotifications
    
struct LocalNotificationManager {
    
    static func authorizeLocalNotifications(viewController: UIViewController) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error)
            in
            guard error == nil else {
                print(" ERROR: \(error!.localizedDescription)")
                return
            }
            if granted {
                print("Notifications Authorization Granted")
            } else {
                print("The user has denied notifications")
                DispatchQueue.main.async {
                    viewController.oneButtonAlert(Title: "User Has Not Allowed Notifications", message: "To recieve alerts for reminders, open the setting app and change")
                }
            }
        }
    }
    static func isAuthorized(completed: @escaping (Bool)->() ) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error)
            in
            guard error == nil else {
                print(" ERROR: \(error!.localizedDescription)")
                completed(false)
                return
            }
            if granted {
                print("Notifications Authorization Granted")
                completed(true)
            } else {
                print("The user has denied notifications")
                completed(false)
                }
            }
        }
    }

func setCalendarNotification(tile: String, subtitle: String, body: String, badgeNumber: NSNumber?, sound: UNNotificationSound?, date: Date) ->
// changed static func
    String {
    let content = UNMutableNotificationContent()
    
    // content.title = title
    content.subtitle = subtitle
    content.body = body
    content.sound = sound
    content.badge = badgeNumber
    
    var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
    dateComponents.second = 00
    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
    let notificationID = UUID().uuidString
    let request = UNNotificationRequest(identifier: notificationID, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request) {(error) in
        if let error = error {
            print("ERROR: \(error.localizedDescription) Yikes")
        } else {
            print("Notification scheduled \(notificationID), title: \(content.title)")
        }
    }
    return notificationID
  }


