//
//  DelaveryDTOType.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import Foundation

protocol DelaveryDTOType: Codable {
    func toEntity() -> DelaveryEntityType
}
