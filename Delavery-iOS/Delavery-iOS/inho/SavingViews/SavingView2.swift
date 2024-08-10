//
//  SavingView2.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/11/24.
//

import SwiftUI

struct SavingView2: View {
    @State var accountNumber = ""
    @State var showBankModal = false
    
    var body: some View {
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
                // FIXME: Add Action 은행 나오는 모달
            }) {
                HStack {
                    Text("Select a bank")
                    Spacer()
                    Image(systemName: "chevron.down")
                }
            }
            .foregroundStyle(Color.gray)
            Rectangle().frame(height: 1).foregroundStyle(Color.gray)
            
            Spacer()
            
            Button("Next") {
                // Do something
            }
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.lightBlue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding(.horizontal, 40)
        .sheet(isPresented: $showBankModal, content: {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Sheet Content")/*@END_MENU_TOKEN@*/
        })
    }
}

#Preview {
    SavingView2()
}
