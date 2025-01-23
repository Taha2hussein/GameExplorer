//
//  DetailsViewModelTests.swift
//  GameExplorerTests
//
//  Created by Taha Hussein on 23/01/2025.
//

import XCTest
@testable import GameExplorer

final class GiveawayDetailViewModelTests: XCTestCase {
    func testViewModelInitialization() {
        // Given
        let giveaway = Giveaway(id: 1, title: "Game 1", worth: "$10", thumbnail: "", image: "", description: "", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "PC", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: "")
        
        // When
        let viewModel = GiveawayDetailViewModel(game: giveaway)
        
        // Then
        XCTAssertEqual(viewModel.giveaway.name, giveaway.title)
        XCTAssertEqual(viewModel.giveaway.imageUrl, giveaway.thumbnail)
        XCTAssertEqual(viewModel.giveaway.gameType, giveaway.type)
        XCTAssertEqual(viewModel.giveaway.expiryDate, giveaway.publishedDate)
        XCTAssertEqual(viewModel.giveaway.numberOfUsers, giveaway.users)
        XCTAssertEqual(viewModel.giveaway.description, giveaway.description)
    }
    
    func testViewModelDataUpdate() {
        // Given
        let initialGame = Giveaway(id: 1, title: "Game 13", worth: "$10", thumbnail: "https://www.gamerpower.com/offers/1b/67094edb54dd5.jpg", image: "", description: "no capture needed", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "PC", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: "")
        
        let updatedGame = Giveaway(id: 2, title: "Game 144", worth: "$130", thumbnail: "", image: "", description: "here im in", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "PC", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: "")
        
        let viewModel = GiveawayDetailViewModel(game: initialGame)
        
        // When
        viewModel.fetchGiveawayDetails(game: updatedGame)
        
        // Then
        XCTAssertEqual(viewModel.giveaway.name, updatedGame.title)
        XCTAssertEqual(viewModel.giveaway.imageUrl, updatedGame.thumbnail)
        XCTAssertEqual(viewModel.giveaway.gameType, updatedGame.type)
        XCTAssertEqual(viewModel.giveaway.expiryDate, updatedGame.publishedDate)
        XCTAssertEqual(viewModel.giveaway.numberOfUsers, updatedGame.users)
        XCTAssertEqual(viewModel.giveaway.description, updatedGame.description)
    }
}
