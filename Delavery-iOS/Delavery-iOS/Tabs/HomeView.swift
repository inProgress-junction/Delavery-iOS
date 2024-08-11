//
//  HomeView.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import SwiftUI
import Alamofire

struct HomeView: View {
    @State var headerOffset = -500
    @Binding var assetValue: Int
    @State var percentile: CGFloat = .zero
    let dateformatter = DateFormatter()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Header()
                .padding(.horizontal, -20)
            HStack {
                Spacer()
                Image("pig-icon")
                    .frame(width: 240, height: 120)
                    .padding(.bottom, 19)
                Spacer()
            }
            .padding(.horizontal, 16)
            NavigationLink {
                SavingView2(totalBalance: $assetValue)
            } label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(uiColor: UIColor(hex: 0x5E84E7)))
                    .stroke(Color(UIColor(hex: 0xB6BDFF)), lineWidth: 1)
                    .frame(height: 50)
                    .overlay {
                        Text("Withdrawal")
                            .bold()
                            .foregroundColor(.white)
                    }
            }
            
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .shadow(radius: 10)
                .frame(height: 67)
                .padding(.top, 20)
                .overlay {
                    HStack(spacing: 0) {
                        Text("\(assetValue)")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(Color(UIColor(hex: 0x5E84E7)))
                        
                        Text("won")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.top, 10)
                            .padding(.leading, 4)
                            .foregroundColor(Color(UIColor(hex: 0x5E84E7)))
                        Spacer()
                        Text("I saved as much as an iPhone!") // TODO: -
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.top, 10)
                            .padding(.leading, 14)
                            .foregroundColor(Color(UIColor(hex: 0xA9A9A9)))
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 12)
                }
            
            Image("tooltip")
                .resizable()
                .frame(width: 280, height: 47)
                .padding(.top, 37)
                .overlay {
                    let _ = dateformatter.dateFormat = "dd"
                    Text("\(dateformatter.string(from: Date()))th day of challenge! You're doing great!") // TODO: -
                        .foregroundColor(Color(UIColor(hex: 0xACB3C7)))
                        .font(.system(size: 13, weight: .bold))
                        .padding(.top, 16)
                }
            
            Capsule()
                .foregroundColor(Color(UIColor(hex: 0xACB3C7)))
                .frame(width: 349, height: 27)
                .padding(.top, 19)
                .padding(.bottom, 11)
                .overlay(alignment: .leading) {
                    Capsule()
                        .fill(LinearGradient(gradient: Gradient(colors: [
                            Color(uiColor: UIColor(hex: 0xCBDAFF)),
                            Color(uiColor: UIColor(hex: 0x5E84E7))
                            
                        ]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: 349 * percentile / 100, height: 27)
                        .padding(.bottom, -8)
                }
            
            Text("It's currently\nin the top \(Int(percentile))%.")
                .font(.system(size: 24, weight: .bold))
                .padding(.trailing, 67)
            
            Spacer()
        }
        .padding(.horizontal, 22)
        .ignoresSafeArea()
        .onAppear {
            MockDelaveryProtocol.responseWithDTO(type: .searchAccount)
            MockDelaveryProtocol.responseWithStatusCode(code: 200)
            
            let session: Session = {
                let configuration: URLSessionConfiguration = {
                    let configuration = URLSessionConfiguration.default
                    configuration.protocolClasses = [MockDelaveryProtocol.self]
                    return configuration
                }()
                return Session(configuration: configuration)
            }()
            
            let service = DelaveryAPIService()
            Task {
                let result = await service.request(api: .searchAccount, dtoType: SearchAccountDTO.self)
                switch result {
                case .success(let success):
                    if let account = success as? SearchAccountEntity {
                        withAnimation {
                            self.assetValue = account.money
                        }
                    }
                case .failure:
                    return
                }
                MockDelaveryProtocol.responseWithDTO(type: .challengeState)
                let result2 = await service.request(api: .challengeState, dtoType: ChallengeStateDTO.self)
                switch result2 {
                case .success(let success):
                    if let percentile = success as? ChallengeStateEntity {
                        withAnimation {
                            self.percentile = percentile.percentile
                        }
                    }
                case .failure:
                    return
                }
            }
        }
    }
    
    @ViewBuilder
    private func Header() -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(uiColor: UIColor(hex: 0xCBDAFF)))
            .frame(height: 200)
            .shadow(radius: 10)
            .overlay {
                VStack(spacing: 0) {
                    HStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 97, height: 33)
                        Spacer()
                        //                        Button {
                        //
                        //                        } label: {
                        //                            Image("gear")
                        //                                .renderingMode(.template)
                        //                                .foregroundColor(Color(UIColor(hex: 0x5E84E7)))
                        //                                .frame(width: 24, height: 24)
                        //                        }
                        
                    }
                    HStack{
                        Text("Have a\nhealthy consumption today, too!")
                            .bold()
                            .foregroundColor(Color(uiColor: UIColor(hex: 0x5E84E7)))
                        Spacer()
                    }
                }
                .offset(.init(width: 0, height: 33))
                .padding(.horizontal, 30)
            }
            .offset(.init(width: 0, height: headerOffset))
            .onAppear {
                withAnimation {
                    headerOffset = -33
                }
            }
    }
}
