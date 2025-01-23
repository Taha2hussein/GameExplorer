//
//  Requests.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Combine
import Foundation

struct MovieAPI: GameRepository {
    
    let client: Client
    
    init(client: Client = moyaProvider) {
        self.client = client
    }
    
    func fetchGamesList() -> AnyPublisher<[Giveaway], APIError> {
        return self.client.performRequest(api: GamesExplorerPIEndPoint.gamesList, decodeTo: [Giveaway].self)

    }

    func searchGame(query: String) -> AnyPublisher<[Giveaway], APIError> {
        return self.client.performRequest(api: GamesExplorerPIEndPoint.gameSearch(query: query), decodeTo: [Giveaway].self)

    }
    
    
}
