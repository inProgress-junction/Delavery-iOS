//
//  DelaveryTabView.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import SwiftUI

struct DelaveryTabView: View {
    @State var footerOffset = 1000
    @State var assetValue = 0
    @State var selectedTab = "home"
    @State var isModalPresented: Bool = false // 특정 인덱스? 값을 지정
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    TabView(selection: $selectedTab) {
                        HomeView(assetValue: $assetValue)
                            .tag("home")
                        LockedAppsView(isModalPresented: $isModalPresented)
                            .tag("apps")
                    }
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .shadow(radius: 10)
                        .ignoresSafeArea()
                        .frame(height: 80)
                        .overlay {
                            HStack {
                                Spacer()
                                Button {
                                    selectedTab = "home"
                                } label: {
                                    VStack {
                                        Image(systemName: "house")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                        Text("home")
                                    }
                                }
                                .foregroundColor(
                                    selectedTab == "home"
                                    ? .blue
                                    : .gray
                                )
                                Spacer()
                                Button {
                                    selectedTab = "apps"
                                } label: {
                                    VStack {
                                        Image(systemName: "square.split.2x2")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                        Text("Locked Apps")
                                    }
                                    .foregroundColor(
                                        selectedTab == "apps"
                                        ? .blue
                                        : .gray
                                    )
                                }
                                Spacer()
                            }
                        }
                        .offset(.init(width: 0, height: footerOffset))
                        .onAppear {
                            withAnimation {
                                footerOffset = 0
                            }
                        }
                }
                
                if isModalPresented {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    RoundedRectangle(cornerRadius: 14)
                        .fill(.white)
                        .frame(width: 270, height: 166)
                        .overlay {
                            VStack(spacing: 0) {
                                Text("선택하기 전에 생각하셨나요?")
                                    .font(.system(size: 17, weight: .semibold))
                                Text("이 버튼을 누른 순간 소비를 하게 됩니다.")
                                    .font(.system(size: 13, weight: .regular))
                                    .padding(.bottom, 17)
                                NavigationLink {
                                    SavingView1(totalBalance: $assetValue, isWithdrawal: true)
                                        .onAppear {
                                            isModalPresented = false
                                        }
                                } label: {
                                    VStack {
                                        Rectangle().fill(Color(uiColor: UIColor(hex: 0xB9B9B9)))
                                            .frame(height: 1)
                                        Spacer()
                                        Text("저축할래요")
                                            .foregroundColor(.black)
                                            .font(.system(size: 17, weight: .bold))
                                        Spacer()
                                    }
                                }
                                .frame(height: 44)
                                
                                Button {
                                    Task {
                                        store.shield.applications = []
                                        isModalPresented = false
                                        await DelaveryAPIService().request(api: .unlock)
                                    }
                                } label: {
                                    VStack {
                                        Rectangle().fill(Color(uiColor: UIColor(hex: 0xB9B9B9)))
                                            .frame(height: 1)
                                        Spacer()
                                        Text("소비할래요")
                                            .foregroundColor(.black)
                                            .font(.system(size: 17, weight: .regular))
                                        Spacer()
                                    }
                                }
                                .frame(height: 44)
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    DelaveryTabView()
}
