//
//  Score.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

// MARK: - Score
struct Score: Codable {
    
    static let empty = Score(winner: "", duration: "")
    
    let winner: String?
    let duration: String?
    let fullTime: ExtraTime?
    let halfTime: ExtraTime?
    let extraTime: ExtraTime?
    let penalties: ExtraTime?
    
    init(winner: String,
         duration: String,
         fullTime: ExtraTime? = nil,
         halfTime: ExtraTime? = nil,
         extraTime: ExtraTime? = nil,
         penalties: ExtraTime? = nil) {
        
        self.winner = winner
        self.duration = duration
        self.fullTime = fullTime
        self.halfTime = halfTime
        self.extraTime = extraTime
        self.penalties = penalties
    }
    
    enum CodingKeys: String, CodingKey {
        case winner
        case duration
        case fullTime
        case halfTime
        case extraTime
        case penalties
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.winner = try container.decodeIfPresent(String.self, forKey: .winner)
        self.duration = try container.decodeIfPresent(String.self, forKey: .duration)
        self.fullTime = try container.decodeIfPresent(ExtraTime.self, forKey: .fullTime)
        self.halfTime = try container.decodeIfPresent(ExtraTime.self, forKey: .halfTime)
        self.extraTime = try container.decodeIfPresent(ExtraTime.self, forKey: .extraTime)
        self.penalties = try container.decodeIfPresent(ExtraTime.self, forKey: .penalties)
    }
}
