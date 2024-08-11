//
//  Delavery_iOSApp.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/10/24.
//

import SwiftUI
import FamilyControls

@main
struct Delavery_iOSApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: MyAppDelegate
    
    var body: some Scene {
        WindowGroup {
            DelaveryTabView()
                .onAppear {
                    Task {
                        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                    }
                }
        }
    }
}
