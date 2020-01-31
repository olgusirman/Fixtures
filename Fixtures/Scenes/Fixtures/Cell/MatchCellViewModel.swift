//
//  MatchCellViewModel.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Differentiator
import Action

protocol MatchCellViewModelInput {
}

protocol MatchCellViewModelOutput {
    var matchObs: Driver<Match> { get }
    var match: Match { get }
}

protocol MatchCellViewModelType {
    var input: MatchCellViewModelInput { get }
    var output: MatchCellViewModelOutput { get }
}

final class MatchCellViewModel: MatchCellViewModelType,
    MatchCellViewModelInput,
MatchCellViewModelOutput {

    // MARK: Input & Output
    var input: MatchCellViewModelInput { return self }
    var output: MatchCellViewModelOutput { return self }

    // MARK: Output

    var matchObs: Driver<Match>
    let match: Match

    // MARK: Init
    init(match: Match) {
        self.match = match
        self.matchObs = Observable.just(match)
            .asDriver(onErrorJustReturn: Match.empty)
    }

}

extension MatchCellViewModel: IdentifiableType, Equatable {

    static func == (lhs: MatchCellViewModel, rhs: MatchCellViewModel) -> Bool {
        return lhs.identity == rhs.identity
    }

    typealias Identity = String

    var identity: String {
        return String(match.id)
    }

}
