//
//  FixturesServiceTests.swift
//  FixturesTests
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import RxBlocking
import Moya
@testable import Fixtures

class FixturesServiceTests: XCTest {
    
    var scheduler: ConcurrentDispatchQueueScheduler!
    var mockService: FixturesServiceType!
    private let delay: TimeInterval = 2.0
    
    override func setUp() {
        
        let mockProvider = MoyaProvider<FixturesTarget>(
            stubClosure: MoyaProvider.delayedStub(delay)
        )
        
        mockService = FixturesService(provider: mockProvider)
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        
    }
    
    override func tearDown() {
        scheduler = nil
        mockService = nil
    }
    
    func testGetTeamsService() {
        
        // Given
        let getTeams = mockService.getTeams().subscribeOn(scheduler)
        
        // When
        let result = try! getTeams.toBlocking(timeout: (delay + 1)).first()
        
        // Then
        XCTAssertNotNil(result)
        switch result! {
        case .success(let base):
            
            guard let teams = base.teams,
                let firstTeam = teams.first else {
                    fatalError("Teams shouldn't be nil")
            }
            
            XCTAssertEqual(firstTeam.id, 59, "First team should be Blackburn Rovers ")
            XCTAssertEqual(firstTeam.shortName, "Blackburn", "First team should be Blackburn Rovers ")
            
            
        case .error(let error):
            XCTAssertNil(error)
        }
    }
    
    func testGetMatchesService() {
        
        // Given
        let getTeams = mockService.getFixtures(request: GetMatchesRequest()).subscribeOn(scheduler)
        
        // When
        let result = try! getTeams.toBlocking(timeout: (delay + 1)).first()
        
        // Then
        XCTAssertNotNil(result)
        switch result! {
        case .success(let base):
            
            guard let matches = base.matches,
                let firstMatch = matches.first else {
                    fatalError("Teams shouldn't be nil")
            }
            
            XCTAssertEqual(firstMatch.id, 268927, "First match id")
            XCTAssertEqual(firstMatch.score.fullTime?.homeTeam, 2, "First match home team score must be 2")
            
            
        case .error(let error):
            XCTAssertNil(error)
        }
    }
    
}
