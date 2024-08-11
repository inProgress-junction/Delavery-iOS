//
//  ChallengeStateDTO.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import Foundation

struct ChallengeStateDTO: DelaveryDTOType {
    
    let percentile: CGFloat
    
    func toEntity() -> any DelaveryEntityType {
        ChallengeStateEntity(percentile: percentile)
    }
}
