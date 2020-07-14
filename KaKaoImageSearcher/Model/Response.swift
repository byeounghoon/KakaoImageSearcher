//
//  Response.swift
//  KaKaoImageSearcher
//
//  Created by TaeWon Seo on 2020/07/10.
//  Copyright © 2020 NOWEAT. All rights reserved.
//

import Foundation
/**

1. Codable의 역할을 생각해보고 아래 코드를 리펙토링 해보세요~
2. is_end 같은 property 같은경우 Swift Style Guild에 맞지 않는 형식이에요.
카멜케이스로 바꿔서 저장하는 방법을 공부해보시면 좋을듯 합니다.
*/

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
