//
//  FixturesViewModelTests.swift
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

class FixturesViewModelTests: XCTest {
    
    var scheduler: ConcurrentDispatchQueueScheduler!
    var mockService: FixturesServiceType!
    var viewModel: FixturesViewModel!
    private let delay: TimeInterval = 2.0
    
    override func setUp() {
        
        let mockProvider = MoyaProvider<FixturesTarget>(
            stubClosure: MoyaProvider.delayedStub(delay)
        )
        
        mockService = FixturesService(provider: mockProvider)
        viewModel = FixturesViewModel(service: mockService)
        scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    }
    
    override func tearDown() {
        scheduler = nil
        mockService = nil
    }
    
    func testGetTeamsService() {
        
        // Given
        let fetchMatches = viewModel.inputs.fetchMatches
        
        // When
        fetchMatches.execute()
        
        let cellViewModels = try! viewModel.outputs.matchCellViewModels.asObservable().toBlocking(timeout: delay + 1).first()
        
        let firstMatch = cellViewModels?.first?.match
        XCTAssertNotNil(firstMatch)
        XCTAssertEqual(firstMatch!.id, 268927, "First match id")
        XCTAssertEqual(firstMatch!.score.fullTime!.homeTeam, 2, "First match home team score must be 2")

    }
}
