//
//  Repository.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Combine
import Foundation

protocol GameRepository {
    func fetchGamesList() -> AnyPublisher<[Giveaway], APIError>
    func searchGame(query: String) -> AnyPublisher<[Giveaway], APIError>
}

protocol HasGameRepository {
    var gameRepository: GameRepository { get }
}
