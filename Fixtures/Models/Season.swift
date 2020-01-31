//
//  Season.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

// MARK: - Season
struct Season: Codable {
    
    static let empty = Season(id: 0, startDate: "", endDate: "", currentMatchday: 0)
    
    let id: Int
    let startDate, endDate: String
    let currentMatchday: Int
    
    init(id: Int, startDate: String, endDate: String, currentMatchday: Int) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.currentMatchday = currentMatchday
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case startDate
        case endDate
        case currentMatchday
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.endDate = try container.decode(String.self, forKey: .endDate)
        self.currentMatchday = try container.decode(Int.self, forKey: .currentMatchday)
    }
}
