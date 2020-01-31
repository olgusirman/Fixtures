//
//  FixtureServiceType.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
import RxSwift

enum FixturesServiceResult {
    case success(Base)
    case error(FixturesServiceError)
}

enum FixturesServiceError: Error {
    case generic(with: String)
}

protocol FixturesServiceType {
    func getFixtures( request: GetMatchesRequest) -> Observable<FixturesServiceResult>
    func getTeams() -> Observable<FixturesServiceResult>
}
