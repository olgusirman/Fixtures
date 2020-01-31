//
//  Config.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
import Alamofire

// This also can get from buildSettings via info.plist
enum Environment: String {
    case development = ""
    case production = "http://api.football-data.org/v2"
}

final class Config: URLConvertible {
    
    static let shared = Config()
    static let token = "009381170d524d58b5c68a71b03d5ed1"
    
    var baseUrl: URL {
        return try! Config().asURL()
    }
    
    func asURL() throws -> URL {
        return try Environment.production.rawValue.asURL()
    }
        
    // Block the Initializastion
    private init() {
    }
    
}
