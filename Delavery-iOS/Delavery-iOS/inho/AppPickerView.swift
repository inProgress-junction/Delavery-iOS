//
//  AppPickerView.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/11/24.
//

import SwiftUI
import ManagedSettings
import DeviceActivity
import FamilyControls

struct AppPickerView: View {
    @Binding var selection: FamilyActivitySelection
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    isSheetPresented = false
                }
                .foregroundStyle(Color.red)
                Spacer()
                Button("Confirm") {
                    registerBlocked()
                    isSheetPresented = false
                    
                    // UserDefaults(suiteName: "com.delavery.app")
                }
                .foregroundStyle(Color.blue)
            }
            .padding()
            
            FamilyActivityPicker(selection: $selection)
        }
        .background(.listBackground)
    }
    
    private func registerBlocked() {
        let deviceActivityCenter = DeviceActivityCenter()
        let blockSchedule = DeviceActivitySchedule(
            intervalStart: DateComponents(hour: 0, minute: 0),
            intervalEnd: DateComponents(hour: 23, minute: 59),
            repeats: true
        )
        
        store.shield.applications = selection.applicationTokens
        
        do {
            try deviceActivityCenter.startMonitoring(.daily, during: blockSchedule)
        } catch {
            print(error.localizedDescription)
        }
        print("FLAG")
    }
}

extension DeviceActivityName {
    static let daily = Self("daily")
}


let store = ManagedSettingsStore()
