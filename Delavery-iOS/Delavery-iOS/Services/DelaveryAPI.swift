//
//  DelaveryAPI.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import Foundation
import Alamofire

enum DelaveryAPI {
    case searchAccount
    case withdrawal(Int)
    case transfer(Int)
    case challengeState
    case tryUnlock
    case unlock
}

// MARK: - API

extension DelaveryAPI {
    
    var baseURL: URL {
        return URL(string: "https://glance.nazku.com")!
    }
    
    var path: String? {
        switch self {
        case .searchAccount:
            "/bank-accounts"
        case .withdrawal:
            "/bank-accounts/withdrawal"
        case .transfer:
            "/bank-accounts/transfer"
        case .challengeState:
            "/challenges/percentile"
        case .tryUnlock:
            "/challenges/unlock-trial-count"
        case .unlock:
            "/challenges/unlock-done-count"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .searchAccount, .challengeState:
            return .get
        case .withdrawal, .transfer:
            return .post
        case .tryUnlock, .unlock:
            return .patch
        }
    }
    
    var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .transfer, .withdrawal:
            HTTPHeaders([
            "Content-Type": "application/json",
            "X-USER-ID": "930af6a3-1fa4-48ea-a175-5bf35a301aa7"
            ])
        default:
            HTTPHeaders([
                "X-USER-ID": "930af6a3-1fa4-48ea-a175-5bf35a301aa7"
            ])
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .searchAccount:
            return [
                "type": "saving"
            ]
        case .withdrawal(let amount):
            return [
                "money": amount
            ]
        case .transfer(let amount):
            return [
                "money": amount
            ]
        default:
            return nil
        }
    }
    
    var route: URL {
        guard let path = path else { return baseURL }
        return baseURL.appendingPathComponent(path)
    }
}
