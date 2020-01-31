//
//  Match.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation

// MARK: - Match
struct Match: Codable {
    
    static let empty = Match(id: 0, competition: .empty, season: .empty, utcDate: Date(), status: .finished, matchday: 0, stage: "", group: "", lastUpdated: Date(), score: .empty, homeTeam: .empty, awayTeam: .empty, referees: [])

    let id: Int
    let competition: Competition
    let season: Season
    let utcDate: Date
    let status: Status
    let matchday: Int
    let stage, group: String
    let lastUpdated: Date
    let score: Score
    var homeTeam: Team
    var awayTeam: Team
    let referees: [Referee]
    
    enum CodingKeys: String, CodingKey {
        case id
        case competition
        case season
        case utcDate
        case status
        case matchday
        case stage
        case group
        case lastUpdated
        case score
        case homeTeam
        case awayTeam
        case referees
    }
}
