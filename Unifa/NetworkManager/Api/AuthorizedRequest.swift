//
//  AuthorizedRequest.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import Alamofire

// MARK: - Authorized Request Protocol
protocol AuthorizedRequest: APIRequestProtocol {}

extension AuthorizedRequest {
    
    var baseURL: URL {
        URL(string: Constants.Networking.baseUrl)!
    }
    
    var headers: HTTPHeaders? {
        [
            HTTPHeader(name: Constants.Networking.authorization, value: Constants.Networking.apiKey)
        ]
    }
}
