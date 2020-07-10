//
//  Response.swift
//  KaKaoImageSearcher
//
//  Created by TaeWon Seo on 2020/07/10.
//  Copyright © 2020 NOWEAT. All rights reserved.
//

import Foundation

struct ImageResponse: Codable, Equatable {
    var meta: Meta
    var documents: [Document]
}

struct Meta: Codable, Equatable {
    var is_end: Bool
    var pageable_count: Int
    var total_count: Int
}

struct Document: Codable, Equatable {
    let collection: String
    let datetime: String
    let display_sitename: String
    let doc_url: String
    let height: Int
    let image_url: String
    let thumbnail_url: String
    let width: Int
}
