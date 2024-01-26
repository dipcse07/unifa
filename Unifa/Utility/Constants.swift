//
//  Constants.swift
//  Unifa
//
//  Created by intel on 2024/01/25.
//

import Foundation

// MARK: - Constants
struct Constants {
    
    // MARK: - Text
    static let searchPlaceholder = "Search for anything ..."
    static let imageSearch = "Image Search"
}

// MARK: - Constants.Networking
extension Constants {
    struct Networking {
        static let baseUrl = "https://api.pexels.com/v1"
        static let searchPath = "/search"
        static let apiKey = "MJlKqUnW7qc73bgy71Xs2HWOdl2sFX7rWZaRJnjGYmTmXB3M4Bpew1ns"
        static let authorization = "Authorization"
    }
}

// MARK: - Constants.Errors
extension Constants {
    struct Errors {
        static let unknownError = "Unknown Error!"
    }
}

