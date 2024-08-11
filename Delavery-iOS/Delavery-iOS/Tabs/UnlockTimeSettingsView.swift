//
//  UnlockTimeSettingsView.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import SwiftUI

struct UnlockTimeSettingsView: View {
    @Binding var isSheetPresented: Bool
    var body: some View {
        Header()
        TimerPickerView()
            .frame(height: 247)
        Button {
            isSheetPresented = false
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(uiColor: UIColor(hex: 0x5E84E7)))
                .frame(height: 50)
                .padding(.horizontal, 22)
                .overlay {
                    Text("Completion")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                }
        }
        
        Spacer()
    }
    
    @ViewBuilder
    private func Header() -> some View {
        HStack {
            Text("Unlock Time Settings")
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Button {
                isSheetPresented = false
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.black)
                    .frame(width: 14, height: 14)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
    }
}

struct TimerPickerView: View {
    @State private var selectedHour: Int = 0
    @State private var selectedMinute: Int = 0
    @State private var selectedSecond: Int = 0
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(spacing: 0) {
                    Spacer()
                    Picker("Selected Hour", selection: $selectedHour) {
                        ForEach(0..<24, id: \.self) { hour in
                            Text("\(hour)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width/5, height: 200)
                    .clipped()
                    Text(":")
                    
                    Picker("Select Period", selection: $selectedMinute) {
                        ForEach(0..<60, id: \.self) { minute in
                            Text("\(minute)")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: geometry.size.width/4, height: 200)
                    .clipped()
                    Spacer()
                }
            }
        }
    }
}
