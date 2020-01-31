//
//  StoryboardIdentifiable.swift
//  Fixtures
//
//  Created by Olgu on 31.01.2020.
//  Copyright © 2020 InCrowd Sports. All rights reserved.
//

import UIKit

protocol StoryboardIdentifiable: ClassIdentifiable {
    static var storyboardName: String { get }
}

extension StoryboardIdentifiable {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: reuseId) as? Self else {
            fatalError(reuseId + " cannot be instantiated via storyboard")
        }
        return viewController
    }
}
