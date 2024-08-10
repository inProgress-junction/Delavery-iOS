//
//  AppDelegate.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/11/24.
//

import UIKit

class MyAppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        requestNotiAuth()
        
        return true
    }
    
    private func requestNotiAuth() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
            
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { isSuccess, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
     }
}

extension MyAppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 보내기 전에 노티피케이션을 핸들링할 수 있다.
        completionHandler([.banner, .list, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let targetScene = response.notification.request.content.userInfo["targetScene"]
        
        completionHandler()
    }
}

