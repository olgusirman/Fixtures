//
//  FixturesService.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
import RxSwift
import Moya

struct FixturesService: FixturesServiceType {
    
    private let provider:MoyaProvider<FixturesTarget>
    let decoder = JSONDecoder()
    
    init(provider: MoyaProvider<FixturesTarget> = MoyaProvider<FixturesTarget>(plugins: [
        NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration( logOptions: .verbose))
    ]) ) {
        self.provider = provider
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getFixtures( request: GetMatchesRequest = GetMatchesRequest()) -> Observable<FixturesServiceResult> {
        return provider.rx
            .request(.getMatches(request))
            .flatMap(FixturesError.configureResponseErrorHandler)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .map(Base.self, atKeyPath: nil, using: decoder, failsOnEmptyData: true)
            .asObservable()
            .map({ $0 })
            .unwrap()
            .map(FixturesServiceResult.success)
            .catchError(FixturesError.fixturesCatchErrorHandler)
            .observeOn(MainScheduler.asyncInstance)
    }
    
    func getTeams() -> Observable<FixturesServiceResult> {
        return provider.rx
            .request(.getTeams)
            .flatMap(FixturesError.configureResponseErrorHandler)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .map(Base.self, atKeyPath: nil, using: decoder, failsOnEmptyData: true)
            .asObservable()
            .map({ $0 })
            .unwrap()
            .map(FixturesServiceResult.success)
            .catchError(FixturesError.fixturesCatchErrorHandler)
            .observeOn(MainScheduler.asyncInstance)
    }
    
}
