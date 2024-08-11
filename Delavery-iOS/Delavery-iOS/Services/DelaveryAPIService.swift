//
//  DelaveryAPIService.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import Foundation
import Alamofire

enum DelaveryAPIError: Error {
    case unknown
}

final class DelaveryAPIService {
    func request<T: DelaveryDTOType>(api: DelaveryAPI, dtoType: T.Type) async -> Result<DelaveryEntityType?, DelaveryAPIError> {
        let responseData = await request(api: api)
        guard let responseData else {
            return .failure(.unknown)
        }
        let result = self.handleResponse(data: responseData, dtoType: T.self)
        
        return .success(result?.toEntity())
    }
    
    @discardableResult
    func request(api: DelaveryAPI) async -> Data? {
        let result = await afSession.request(
            api.route,
            method: api.method,
            parameters: api.parameters,
            headers: api.headers
        ).serializingData().result
        
        switch result {
        case .success(let success):
            return success
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
    @discardableResult
    func requestWithBody(api: DelaveryAPI) async -> Data? {
        var request = URLRequest(url: api.route)
        request.httpMethod = api.method.rawValue
        request.headers = api.headers ?? []
        request.httpBody = try? JSONSerialization.data(withJSONObject: api.parameters ?? [], options: [])
        return await withCheckedContinuation { continuation in
            afSession.request(request)
                .responseData { response in
                    continuation.resume(returning: response.data)
                }
        }
    }
    
    private func handleResponse<T: DelaveryDTOType>(data: Data, dtoType: T.Type) -> T? {
        try? JSONDecoder().decode(T.self, from: data)
    }
    
    private let afSession: Alamofire.Session
    
    init(afSession: Alamofire.Session = AF) {
        self.afSession = afSession
    }
}
