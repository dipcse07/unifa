//
//  SearchImageRequest.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import Alamofire

// MARK: - Search Image Request 
struct SearchImageRequest: AuthorizedRequest {
    
    var path: String {
        Constants.Networking.searchPath
    }
    
    var parameters: Parameters? {
        [
            "query" : query,
            "page"  : page
        ]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameterEncodering: ParameterEncoding {
        URLEncoding()
    }
    
    private let query: String
    private let page: Int
    
    init(query: String, page: Int) {
        self.query = query
        self.page = page
    }
}
