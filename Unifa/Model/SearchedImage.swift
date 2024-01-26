//
//  PhotoFeed.swift
//  Unifa
//
//  Created by intel on 2024/01/24.
//

import Foundation
import RxDataSources

// MARK: - Searched Image Data Struct
struct SearchedImage: Decodable {
    let page: Int
    let perPage: Int
    let photos: [Photo]
    let totalResults: Int
    let nextPage: String?
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case photos
        case totalResults = "total_results"
        case nextPage = "next_page"
    }
}

// MARK: - Photo Data Struct
struct Photo: Decodable {
    let id: String
    let url: String
    let photographer: String
    let src: Src
    
    enum CodingKeys: String, CodingKey {
        case id
        case url
        case photographer
        case src
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.url = try container.decode(String.self, forKey: .url)
        self.photographer = try container.decode(String.self, forKey: .photographer)
        self.src = try container.decode(Src.self, forKey: .src)
    }
}

// MARK: - Src Data Struct
struct Src: Decodable {
    let medium: String
    let large2x: String
    
    enum CodingKeys: String, CodingKey {
        case medium
        case large2x
    }
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id &&
            lhs.url == rhs.url &&
            lhs.photographer == rhs.photographer &&
            lhs.src == rhs.src
    }
}

extension Src: Equatable {
    static func == (lhs: Src, rhs: Src) -> Bool {
        return lhs.medium == rhs.medium &&
            lhs.large2x == rhs.large2x
    }
}

extension Photo: IdentifiableType {
    var identity: String {
        id
    }
}



