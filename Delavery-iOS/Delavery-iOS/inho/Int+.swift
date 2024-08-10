//
//  Int+.swift
//  Delavery-iOS
//
//  Created by Inho Choi on 8/11/24.
//

import Foundation

extension Int {
    func toDemical() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
            
        return numberFormatter.string(from: NSNumber(value: self)) ?? "NaN"
    }
}
