//
//  ShieldActionExtension.swift
//  DelaverySheildAction
//
//  Created by Inho Choi on 8/10/24.
//
import Foundation
import ManagedSettings
import UserNotifications

// Override the functions below to customize the shield actions used in various situations.
// The system provides a default response for any functions that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldActionExtension: ShieldActionDelegate {
    override func handle(action: ShieldAction, for application: ApplicationToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        switch action {
        case .primaryButtonPressed:
            let calendar = Calendar.current
            let newDate = calendar.date(byAdding: DateComponents(second: 5), to: .now)
            let components = calendar.dateComponents([.hour, .minute, .second], from: newDate!)
            UNUserNotificationCenter.current().addNotificationRequest(by: components, id: UUID().uuidString)
            completionHandler(.defer)
        case .secondaryButtonPressed:
            completionHandler(.close)
        @unknown default:
            fatalError()
        }
    }
    
    override func handle(action: ShieldAction, for webDomain: WebDomainToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        completionHandler(.close)
    }
    
    override func handle(action: ShieldAction, for category: ActivityCategoryToken, completionHandler: @escaping (ShieldActionResponse) -> Void) {
        // Handle the action as needed.
        completionHandler(.close)
    }
}

extension UNUserNotificationCenter {
    func addNotificationRequest(by date: DateComponents, id: String) {
        
        // content 만들기
        let content = UNMutableNotificationContent()
        content.title = "알림 제목입니다"
        content.body = "알림 바디입니다. 여기 내용이 들어갑니다."
        content.sound = .default
        content.badge = 1
        
        // trigger 만들기
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        // request 만들기
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
}
