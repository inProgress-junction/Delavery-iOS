//
//  AppPickerView.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/11/24.
//

import SwiftUI
import FamilyControls

struct AppPickerView: View {
    @State var selection = FamilyActivitySelection()
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    // Cancel -> Hide modal
                }
                .foregroundStyle(Color.red)
                Spacer()
                Button("Confirm") {
                    // Add something & API Connect
                    // UserDefaults(suiteName: "com.delavery.app")
                }
                .foregroundStyle(Color.blue)
            }
            .padding()
            
            FamilyActivityPicker(selection: $selection)
        }
        .background(.listBackground)
    }
}

#Preview {
    AppPickerView()
}
