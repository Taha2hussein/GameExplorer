//
//  MockGamesRepository.swift
//  GameExplorerTests
//
//  Created by Taha Hussein on 23/01/2025.
//

import Foundation
import Combine
@testable import GameExplorer

class MockGamesRepository: GamesRepository {
    var games: [Giveaway] = []
    var shouldFail: Bool = false
    
    func fetchGamesList() async throws -> [Giveaway] {
        if shouldFail {
            throw APIError.noInternet
        }
        return games
    }
    
    func searchGame(query: String) -> Future<[Giveaway], Error> {
        return Future { promise in
            if self.shouldFail {
                promise(.failure(APIError.noInternet))
            } else {
                let filteredGames = self.games.filter { $0.title.contains(query) }
                promise(.success(filteredGames))
            }
        }
    }

}
