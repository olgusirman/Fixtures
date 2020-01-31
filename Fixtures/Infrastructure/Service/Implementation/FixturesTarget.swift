//
//  FixturesTarget.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
import Moya

enum FixturesTarget {
    case getMatches(GetMatchesRequest)
    case getTeams
}

extension FixturesTarget: TargetType {
    
    var baseURL: URL {
        return Config.shared.baseUrl
    }
    
    var path: String {
        switch self {
        case .getMatches(let request):
            return "/teams/\(request.iteamId)/matches/"
        case .getTeams:
            return "/competitions/ELC/teams"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMatches, .getTeams:
            return .get
        }
    }
    
    var sampleData: Data {
        
        let jsonPath: String
        
        switch self {
        case .getMatches: jsonPath = "getHullMatches"
        case .getTeams: jsonPath = "teams"
        }
        
        guard let url = Bundle.main.url(forResource: jsonPath, withExtension: "json"),
            let data = try? Data(contentsOf: url) else { return Data() }
        return data
    }
    
    var task: Task {
        switch self {
        case .getMatches, .getTeams:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var header: [String:String] = [:]
        header["Content-Type"] = "application/json"
        header["X-Auth-Token"] = Config.token
        return header
    }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
}
