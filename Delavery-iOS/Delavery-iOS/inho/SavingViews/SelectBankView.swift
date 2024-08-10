//
//  SelectBankView.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/11/24.
//

import SwiftUI

enum BankType: String, Identifiable, CaseIterable {
    var id: String {
        self.rawValue
    }
    
    case nh
    case kakao
    case kb
    case toss
    case shinhan
    case woori
    case ibk
    case hana
    case mg
    
    var englishFullName: String {
        return switch self {
        case .nh: "NH Bank"
        case .kakao: "Kakao Bank"
        case .kb: "KB Bank"
        case .toss: "Toss Bank"
        case .shinhan: "Shin Han Bank"
        case .woori: "Woori Bank"
        case .ibk: "IBK Bank"
        case .hana: "Hana Bank"
        case .mg: "MG Bank"
        }
    }
}

struct SelectBankView: View {
    @Binding var bank: BankType?
    @Binding var showModal: Bool
    
    var body: some View {
        VStack  {
            HStack {
                Text("Please select a bank")
                    .font(.system(size: 20, weight: .bold))
                
                Spacer()
                
                Button(action: {
                    showModal.toggle()
                }) {
                    Image(systemName: "xmark")
                }
                .foregroundStyle(Color.black)
            }
            .padding()
            Spacer()
            
            LazyHGrid(rows: [GridItem](repeating: .init(), count: 3)) {
                LazyVGrid(columns: [GridItem](repeating: .init(), count: 3), content: {
                    ForEach(BankType.allCases, id: \.self) { bankType in
                        Button(action: {
                            bank = bankType
                            showModal.toggle()
                        }, label: {
                            Image(bankType.rawValue)
                        })
                    }
                })
            }
        }
    }
}

#Preview {
    SelectBankView(bank: .constant(nil), showModal: .constant(false))
}
