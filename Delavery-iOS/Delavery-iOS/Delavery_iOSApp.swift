//
//  Delavery_iOSApp.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/10/24.
//

import SwiftUI

@main
struct Delavery_iOSApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: MyAppDelegate
    
    var body: some Scene {
        WindowGroup {
            SavingView2()
        }
    }
}
