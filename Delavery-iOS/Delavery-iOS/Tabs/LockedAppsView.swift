//
//  LockedAppsView.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import SwiftUI
import FamilyControls

struct LockedAppsView: View {
    
    @State var selection = FamilyActivitySelection()
    @State var isPlusSheetPresented: Bool = false
    @State var isUnlockTimeSettingSheetPresented: Bool = false
    @Binding var isModalPresented: Bool // 특정 인덱스? 값을 지정
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                Header()
                List {
                    ForEach(selection.applicationTokens.compactMap { $0 }, id: \.self) { item in
                        Button {
                            Task {
                                isModalPresented = true
                                await DelaveryAPIService().request(api: .tryUnlock)
                            }
                        } label: {
                            Label(item)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }.listStyle(.plain)
                    .frame(height: 100) // itemCount, 화면 크기 비교
                    .padding(.top, 22)
                
                Button {
                    Task {
                        isModalPresented = true
                        await DelaveryAPIService().request(api: .tryUnlock)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.init(uiColor: UIColor(hex: 0xFF453A)))
                        .overlay {
                            Text("Unlock all apps")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(width: 156, height: 40)
                        .padding(.top, 10)
                        .padding(.bottom, 22)
                }
                
                Button {
                    isUnlockTimeSettingSheetPresented = true
                } label: {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(UIColor(hex: 0xD2D2D2)), lineWidth: 1)
                        .frame(height: 53)
                        .overlay {
                            HStack {
                                Text("Unlock Time Settings")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(Color(uiColor: UIColor(hex: 0xCECDD2)))
                                    .frame(width: 4, height: 9)
                            }
                            .padding(.horizontal, 15)
                        }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: $isPlusSheetPresented) {
                AppPickerView(selection: $selection, isSheetPresented: $isPlusSheetPresented)
            }
            .sheet(isPresented: $isUnlockTimeSettingSheetPresented) {
                UnlockTimeSettingsView(isSheetPresented: $isUnlockTimeSettingSheetPresented)
                    .presentationDetents([
                        .height(477)
                    ])
            }
        }
    }
    
    @ViewBuilder
    private func Header() -> some View {
        HStack {
            Text("Locked Apps")
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Button {
                isPlusSheetPresented = true
            } label: {
                Image(systemName: "plus")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.init(uiColor: UIColor(hex: 0x666666)))
                    .frame(width: 30, height: 30)
            }
            
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation { // TODO: -
//            for index in offsets {
//                items.remove(at: index)
//            }
        }
    }
}
