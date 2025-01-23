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
//    func searchMovie(query: String) -> AnyPublisher<MovieResponse, APIError>
//    func fetchMovieDetails(movie_id: Int) -> AnyPublisher<MovieDetailResponse, APIError>
}

protocol HasGameRepository {
    var gameRepository: GameRepository { get }
}
