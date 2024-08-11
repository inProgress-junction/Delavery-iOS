//
//  MockDelaveryProtocol.swift
//  Delavery-iOS
//
//  Created by 김수환 on 8/11/24.
//

import Foundation

final class MockDelaveryProtocol: URLProtocol {
    
    // MARK: - Interface
    
    static func responseWithDTO(type: MockDTOType) {
        MockDelaveryProtocol.dtoType = type
    }
    
    static func responseWithStatusCode(code: Int) {
        MockDelaveryProtocol.responseType = MockDelaveryProtocol.ResponseType.success(
            HTTPURLResponse(
                url: URL(string: "https://stage.readingn.com")!,
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
        )
    }
    
    static func responseWithFailure() {
        MockDelaveryProtocol.responseType = MockDelaveryProtocol.ResponseType.error(MockError.none)
    }
    
    
    // MARK: - Attribute
    
    static var responseType: ResponseType!
    
    static var dtoType: MockDTOType!
    
    private lazy var session: URLSession = {
        let configuration: URLSessionConfiguration = URLSessionConfiguration.ephemeral
        return URLSession(configuration: configuration)
    }()
    
    private(set) var activeTask: URLSessionTask?
    
    
    // MARK: - Setup
    
    private func setUpMockResponse() -> HTTPURLResponse? {
        var response: HTTPURLResponse?
        switch MockDelaveryProtocol.responseType {
        case .error(let error)?:
            client?.urlProtocol(self, didFailWithError: error)
        case .success(let newResponse)?:
            response = newResponse
        default:
            fatalError("No fake responses found.")
        }
        return response!
    }
    
    private func setUpMockData() -> Data {
        MockDelaveryProtocol.dtoType.mockData
    }
    
    static func setUpMockDataFromFile(fileName: String) -> Data {
        guard let file = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            return Data()
        }
        return (try? Data(contentsOf: file)) ?? Data()
    }
    
    
    // MARK: - Override
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override class func requestIsCacheEquivalent(_ firstURLRequest: URLRequest, to secondURLRequest: URLRequest) -> Bool {
        false
    }
    
    
    // MARK: - Loading
    
    // swiftlint:disable:next call_super_method_inside_override_method
    override func startLoading() {
        let response = setUpMockResponse()
        let data = setUpMockData()
        
        client?.urlProtocol(self, didReceive: response!, cacheStoragePolicy: .notAllowed)
        
        client?.urlProtocol(self, didLoad: data)
        
        self.client?.urlProtocolDidFinishLoading(self)
        activeTask = session.dataTask(with: request.urlRequest!)
        activeTask?.cancel()
    }
    
    // swiftlint:disable:next call_super_method_inside_override_method
    override func stopLoading() {
        activeTask?.cancel()
    }
}


// MARK: - Constant

extension MockDelaveryProtocol {
    
    enum MockError: Error {
        
        case none
    }
    
    enum MockDTOType {
        
        case searchAccount
        case challengeState
        
        var mockData: Data {
            switch self {
            case .searchAccount:
                return searchAccountData
            case .challengeState:
                return challengeStateData
            }
        }
    }
    
    enum ResponseType {
        
        case error(Error)
        case success(HTTPURLResponse)
    }
    
    static let searchAccountData = setUpMockDataFromFile(fileName: "SearchAccountData.json")
    static let challengeStateData = setUpMockDataFromFile(fileName: "ChallengeStateData.json")
}
