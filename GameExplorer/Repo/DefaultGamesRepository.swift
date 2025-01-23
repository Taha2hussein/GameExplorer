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
}

class DefaultGamesRepository: GamesRepository {
    private var cancellables = Set<AnyCancellable>()
    var gamesPublisher: PassthroughSubject<Result<[Giveaway], APIError>, Never> = PassthroughSubject()
    
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
}
