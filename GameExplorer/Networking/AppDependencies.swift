//
//  AppDependencies.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Foundation
class AppDependencies:  HasGameRepository {
    var gameRepository: GameRepository

    init(gameRepository: GameRepository) {
        self.gameRepository = gameRepository

    }
}

extension AppDependencies {
    static var shared: AppDependencies {
        AppDependencies(
            gameRepository: MovieAPI()

        )
    }
}

// we make dependencies `var` when we are in debug mode, since changing dependencies should only be used for testing purposes only
#if DEBUG
var dependencies: AppDependencies = .shared
#else
let dependencies: AppDependencies = .shared
#endif
