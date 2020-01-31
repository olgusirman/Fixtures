//
//  Team.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation

// MARK: - Team
struct Team: Codable {
    static let empty = Team(id: 0, name: "")
    
    var id: Int = 0
    let area: Area?
    var name: String
    let shortName, tla: String?
    let crestUrl: String?
    let address: String?
    let phone: String?
    let website: String?
    let email: String?
    let founded: Int?
    let clubColors, venue: String?
    let lastUpdated: Date?
    
    init(id: Int, name: String) {
        self.id = 0
        self.area = nil
        self.name = ""
        self.shortName = nil
        self.tla = nil
        self.crestUrl = nil
        self.address = nil
        self.phone = nil
        self.website = nil
        self.email = nil
        self.founded = nil
        self.clubColors = nil
        self.venue = nil
        self.lastUpdated = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id, area, name, shortName, tla
        case crestUrl
        case address, phone, website, email, founded, clubColors, venue, lastUpdated
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.area = try container.decodeIfPresent(Area.self, forKey: .area)
        self.shortName = try container.decodeIfPresent(String.self, forKey: .shortName)
        self.tla = try container.decodeIfPresent(String.self, forKey: .tla)
        self.crestUrl = try container.decodeIfPresent(String.self, forKey: .crestUrl)
        self.address = try container.decodeIfPresent(String.self, forKey: .address)
        self.phone = try container.decodeIfPresent(String.self, forKey: .phone)
        self.website = try container.decodeIfPresent(String.self, forKey: .website)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
        self.founded = try container.decodeIfPresent(Int.self, forKey: .founded)
        self.clubColors = try container.decodeIfPresent(String.self, forKey: .clubColors)
        self.venue = try container.decodeIfPresent(String.self, forKey: .venue)
        self.lastUpdated = try container.decodeIfPresent(Date.self, forKey: .lastUpdated)
    }
    
}
