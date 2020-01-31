//
//  Filters.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation

// MARK: - Filters
struct Filters: Codable {
    let permission: String?
    let limit: Int?
    
    init(permission: String? = nil, limit: Int? = nil) {
        self.permission = permission
        self.limit = limit
    }
    
    enum CodingKeys: String, CodingKey {
        case permission
        case limit
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.permission = try container.decodeIfPresent(String.self, forKey: .permission)
        self.limit = try container.decodeIfPresent(Int.self, forKey: .limit)
    }
}
