//
//  SavingView1.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/11/24.
//

import SwiftUI

struct SavingView1: View {
    @State var balance = 0
    @State var balanceString = "0"
    private let moneyUnits = [10000, 20000, 30000, 50000, 100000]
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("From my savings account")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom, 8)
                    Text("Balacne of 500,000 won")
                        .foregroundStyle(Color.gray)
                    Spacer()
                        .frame(height: 26)
                    
                    Text("To my main bank")
                        .font(.system(size: 24, weight: .bold))
                        .padding(.bottom, 8)
                    Text("Kookmin 123456789")
                        .foregroundStyle(Color.gray)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            Spacer().frame(height: 42)
            
            if balance == 0 {
                Text("How mush money should I move?")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.littleGray)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                HStack(alignment: .bottom) {
                    TextField("", text: $balanceString)
                        .font(.system(size: 32, weight: .bold))
                        .multilineTextAlignment(.center)
                        .onChange(of: balance) {
                            balanceString = balance.toDemical()
                        }
                    
                    Text("won")
                        .font(.system(size: 20, weight: .bold))
                    
                }
                .foregroundStyle(Color.lightBlue)
                .padding()
            
            }
            

            Text("Current balnace of " + "300,000" + " won")
                .foregroundStyle(Color.darkGray)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 10, leading: 12, bottom: 10, trailing: 12))
                .background(Color.littleGray)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Spacer()
                .frame(height: 50)
            
            LazyHStack(alignment: .top) {
                ForEach(moneyUnits, id: \.self) {
                    MoneyUnitButton(money: $0)
                }
            }
            
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
        .padding(40)
    }
    
    func MoneyUnitButton(money: Int) -> some View {
        Button("+" + money.toDemical()) {
            balance += money
        }
        .font(.system(size: 12))
        .foregroundStyle(Color.darkGray)
        .padding(EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
        }
    }
}

#Preview {
    SavingView1()
}
