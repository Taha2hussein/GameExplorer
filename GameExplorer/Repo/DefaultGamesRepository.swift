//
//  DefaultGamesRepository.swift
//  GameExplorer
//
//  Created by Taha Hussein on 23/01/2025.
//

import Combine
import SwiftUI

protocol GamesRepository {
    func fetchGamesList() async throws -> [Giveaway]
    func searchGame(query: String) -> Future<[Giveaway], Error>
}

class DefaultGamesRepository: GamesRepository {
    private var cancellables = Set<AnyCancellable>()
    
    func fetchGamesList() async throws -> [Giveaway] {
        try await withCheckedThrowingContinuation { continuation in
            dependencies.gameRepository.fetchGamesList()
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error fetching games: \(error.localizedDescription)")
                        continuation.resume(throwing: APIError.otherError(message: error.localizedDescription))
                    }
                }, receiveValue: { response in
                    continuation.resume(returning: response)
                })
                .store(in: &cancellables)
        }
    }
    
    func searchGame(query: String) -> Future<[Giveaway], Error> {
        return Future { promise in
            dependencies.gameRepository.searchGame(query: query)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error searching for game: \(error.localizedDescription)")
                        promise(.failure(APIError.otherError(message: error.localizedDescription)))
                    }
                }, receiveValue: { response in
                    promise(.success(response))
                })
                .store(in: &self.cancellables)
        }
    }
}
