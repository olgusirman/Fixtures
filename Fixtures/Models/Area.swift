//
//  Area.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

// MARK: - Area
struct Area: Codable {
    let id: Int?
    let name: String
    let code: String?
    let ensignURL: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case code
        case ensignURL
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.ensignURL = try container.decodeIfPresent(String.self, forKey: .ensignURL)
    }
}

