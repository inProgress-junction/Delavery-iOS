//
//  SavingView2.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/11/24.
//

import SwiftUI

struct SavingView2: View {
    @State var totalBalance: Int = 0
    @State var accountNumber = ""
    @State var showBankModal = false
    @State var bankType: BankType?
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Spacer().frame(height: 56)
                
                Text("Which account\nshould I send it to?")
                    .font(.system(size: 24, weight: .bold))
                Spacer().frame(height: 33)
                Text("Please enter your account number")
                    .foregroundStyle(Color.gray)
                
                HStack {
                    VStack {
                        TextField("", text: $accountNumber)
                            .textFieldStyle(.plain)
                            .keyboardType(.numberPad)
                        Rectangle().frame(height: 1).foregroundStyle(Color.gray)
                    }
                    if accountNumber.count > 0 {
                        Button(action: {
                            accountNumber = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        })
                    }
                }
                
                Spacer().frame(height: 40)
                
                Button(action: {
                    withAnimation {
                        showBankModal.toggle()
                    }
                }) {
                    HStack {
                        if let bankType {
                            Text(bankType.englishFullName)
                                .foregroundStyle(Color.black)
                        } else {
                            Text("Select a bank")
                        }
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                }
                .foregroundStyle(Color.gray)
                Rectangle().frame(height: 1).foregroundStyle(Color.gray)
                
                Spacer()
                if showBankModal {
                    SelectBankView(bank: $bankType, showModal: $showBankModal)
                } else {
                    NavigationLink {
                        SavingView1(totalBalance: $totalBalance, isWithdrawal: true)
                            .onAppear {
                                Task {
                                    let result = await DelaveryAPIService().request(api: .searchAccount(true), dtoType: SearchAccountDTO.self)
                                    switch result {
                                    case .success(let success):
                                        if let account = success as? SearchAccountEntity {
                                            withAnimation {
                                                self.totalBalance = account.money
                                            }
                                        }
                                    case .failure:
                                        return
                                    }
                                }
                            }
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.lightBlue)
                            .frame(height: 50)
                            .padding(.vertical, 12)
                            .overlay {
                                Text("Next")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                    }
                    
                }
            }
            .padding(.horizontal, 40)
        }
    }
}
