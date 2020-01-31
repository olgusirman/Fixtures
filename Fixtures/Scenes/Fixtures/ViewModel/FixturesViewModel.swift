//
//  FixturesViewModel.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Action
import RxDataSources

protocol FixturesViewModelInput {
    var fetchMatches: Action<Void, [MatchCellViewModel]> { get }
}

protocol FixturesViewModelOutput {
    var matchCellViewModels: Driver<[MatchCellViewModel]> { get }
}

protocol FixturesViewModelType {
    var inputs: FixturesViewModelInput { get }
    var outputs: FixturesViewModelOutput { get }
}

final class FixturesViewModel: FixturesViewModelType,
    FixturesViewModelInput,
FixturesViewModelOutput {
    
    var inputs: FixturesViewModelInput { return self }
    var outputs: FixturesViewModelOutput { return self }
    
    // MARK: - Inputs
    lazy var fetchMatches: Action<Void, [MatchCellViewModel]> = {
        return Action { [unowned self] in
            return self.getMatchesWithTeams()
                .mapMany { [unowned self] in MatchCellViewModel(match: $0) }
                .asDriver(onErrorJustReturn: [])
        }
    }()
    
    // MARK: - Outputs
    lazy var matchCellViewModels: Driver<[MatchCellViewModel]> = {
        return fetchMatches.execute().asDriver(onErrorJustReturn: [])
    }()
    
    private let service: FixturesServiceType
    
    init(service: FixturesServiceType = FixturesService()) {
        self.service = service
    }
}

// MARK: ViewModel Helpers
extension FixturesViewModel {
    
    fileprivate func mixTeamsWithMatches(matches: [Match], teams: [Team]) -> [Match] {
        
        // Iterate All matches
        // Find your team
        // Update your team inside the Matches object
        var updatedMatches: [Match] = []
        
        for match in matches {
            var updatedTeamMatch = match
            
            // Update Home Team
            let homeTeamId = match.homeTeam.id
            let awayTeamId = match.awayTeam.id
            
            if let homeTeam = teams.first(where: { $0.id == homeTeamId }) {
                updatedTeamMatch.homeTeam = homeTeam
            }
            
            // Update Away Team
            if let awayTeam = teams.first(where: { $0.id == awayTeamId }) {
                updatedTeamMatch.awayTeam = awayTeam
            }
            updatedMatches.append(updatedTeamMatch)
        }
        
        return updatedMatches
    }
    
    fileprivate func getMatchesWithTeams() -> Observable<[Match]> {
        
        let matches = Observable.zip(getMatches(), getTeams()) { matches, teams in
            return self.mixTeamsWithMatches(matches: matches, teams: teams)
        }
        
        return matches
    }
    
    fileprivate func getMatches() -> Observable<[Match]> {
        return service.getFixtures(request: GetMatchesRequest()).flatMap { (result) -> Observable<[Match]> in
            switch result {
            case .success(let base):
                return .just(base.matches ?? [])
            case .error(let error):
                return Observable.error(error)
            }
        }
    }
    
    fileprivate func getTeams() -> Observable<[Team]> {
        return service.getTeams().flatMap { (result) -> Observable<[Team]> in
            switch result {
            case .success(let base):
                return .just(base.teams ?? [])
            case .error(let error):
                return Observable.error(error)
            }
        }.share(replay: 0, scope: .forever)
    }
}

// MARK: - DataSource Helpers
struct FixturesSectionModel {
    var header: String
    var items: [MatchCellViewModel]
}

extension FixturesSectionModel: AnimatableSectionModelType {
    
    var identity: String {
        return header
    }
    
    init(original: FixturesSectionModel, items: [MatchCellViewModel]) {
        self = original
        self.items = items
    }
}

// MARK: DataSource
extension FixturesViewController {
    
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource<FixturesSectionModel> {
        return RxTableViewSectionedAnimatedDataSource<FixturesSectionModel>( configureCell: { dataSource, tableView, indexPath, viewModel in
            var cell: MatchCell = tableView.dequeueResuableCell(forIndexPath: indexPath)
            cell.bind(to: viewModel)
            return cell
        })
    }
    
}
