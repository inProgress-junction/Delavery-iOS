//
//  SearchAccountEntity.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import Foundation

struct SearchAccountEntity: DelaveryEntityType {
    let id: String
    let userId: String
    let money: Int
    let accountNumber: Int
    let bankType: String
    let bankAccountType: String
}
