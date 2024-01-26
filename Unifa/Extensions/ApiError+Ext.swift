//
//  ApiError+Ext.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import Foundation

// MARK: - Api Error Extension
extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown Error!"
        }
    }
}
