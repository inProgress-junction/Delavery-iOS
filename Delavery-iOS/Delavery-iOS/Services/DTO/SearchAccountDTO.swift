//
//  SearchAccountDTO.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import Foundation

struct SearchAccountDTO: DelaveryDTOType {
    let id: String
    let userName: String
    let money: Int
    let accountNumber: Int
    let bankType: String
    let bankAccountType: String
    
    func toEntity() -> any DelaveryEntityType {
        SearchAccountEntity(id: id, userId: userName, money: money, accountNumber: accountNumber, bankType: bankType, bankAccountType: bankAccountType)
    }
}
