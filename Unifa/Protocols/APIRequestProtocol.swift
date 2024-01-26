//
//  APIRequestProtocol.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//


import Alamofire

// MARK: - Api Request protocol
protocol APIRequestProtocol: URLRequestConvertible {
    var baseURL: URL { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameterEncodering: ParameterEncoding { get }
}

// MARK: - Extension for Api Request Protocol
extension APIRequestProtocol {
    
    var url: URL {
        if #available(iOS 16.0, *) {
            return baseURL.appending(path: path)
        } else {
            return baseURL.appendingPathComponent(path)
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let request = try URLRequest(url: url, method: method, headers: headers)
        return try parameterEncodering.encode(request, with: parameters)
    }
}
