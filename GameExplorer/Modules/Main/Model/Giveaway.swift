//
//  Giveaway.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import Foundation

import Foundation

// Giveaway Model
struct Giveaway: Codable {
    let id: Int
    let title: String
    let worth: String
    let thumbnail: String
    let image: String
    let description: String
    let instructions: String
    let openGiveawayURL: String
    let publishedDate: String
    let type: String
    let platforms: String
    let endDate: String
    let users: Int
    let status: String
    let gamerpowerURL: String
    let openGiveaway: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case worth
        case thumbnail
        case image
        case description
        case instructions
        case openGiveawayURL = "open_giveaway_url"
        case publishedDate = "published_date"
        case type
        case platforms
        case endDate = "end_date"
        case users
        case status
        case gamerpowerURL = "gamerpower_url"
        case openGiveaway = "open_giveaway"
    }
}
