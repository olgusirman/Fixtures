//
//  ExtraTime.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

// MARK: - ExtraTime
struct ExtraTime: Codable {
    let homeTeam: Int?
    let awayTeam: Int?
    
    init(homeTeam: Int? = nil, awayTeam: Int? = nil) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
    
    enum CodingKeys: String, CodingKey {
        case homeTeam
        case awayTeam
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.homeTeam = try container.decodeIfPresent(Int.self, forKey: .homeTeam)
        self.awayTeam = try container.decodeIfPresent(Int.self, forKey: .awayTeam)
    }
}
