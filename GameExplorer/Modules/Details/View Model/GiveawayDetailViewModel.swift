//
//  GiveawayDetailViewModel.swift
//  GameExplorer
//
//  Created by Taha Hussein on 23/01/2025.
//

import Foundation

class GiveawayDetailViewModel: ObservableObject {
    @Published var giveaway: GiveawayDetails
    
    init(game: Giveaway) {
        self.giveaway = GiveawayDetails(
            name: game.title,
            imageUrl: game.thumbnail,
            gameType: game.type,
            expiryDate: game.publishedDate,
            numberOfUsers: game.users,
            description: game.description
        )
    }
    
    func fetchGiveawayDetails(game: Giveaway) {
        self.giveaway = GiveawayDetails(
            name: game.title,
            imageUrl: game.thumbnail,
            gameType: game.type,
            expiryDate: game.publishedDate,
            numberOfUsers: game.users,
            description: game.description
        )
    }
}


struct GiveawayDetails {
    let name: String
    let imageUrl: String
    let gameType: String
    let expiryDate: String
    let numberOfUsers: Int
    let description: String
}
