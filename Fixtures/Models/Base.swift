//
//  Base.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

// MARK: - Base
struct Base: Codable {
    let count: Int
    let filters: Filters?
    let matches: [Match]?
    
    let competition: Competition?
    let season: Season?
    let teams: [Team]?
    
    enum CodingKeys: String, CodingKey {
        case count
        case filters
        case matches
        case competition
        case season
        case teams
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        
        self.filters = try container.decodeIfPresent(Filters.self, forKey: .filters)
        self.matches = try container.decodeIfPresent([Match].self, forKey: .matches)
        
        self.competition = try container.decodeIfPresent(Competition.self, forKey: .competition)
        self.season = try container.decodeIfPresent(Season.self, forKey: .season)
        self.teams = try container.decodeIfPresent([Team].self, forKey: .teams)
    }
    
}
// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
