//
//  MainViewModel.swift
//  GameExplorerTests
//
//  Created by Taha Hussein on 23/01/2025.
//

import Foundation
import XCTest
import Combine
@testable import GameExplorer

@MainActor
final class MainViewModelTests: XCTestCase {
    var viewModel: MainViewModel!
    var mockRepository: MockGamesRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockGamesRepository()
        viewModel = MainViewModel(gameRepository: mockRepository)
    }
    
    override func tearDown() {
        mockRepository = nil
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Helper Methods
    private func setupMockGames(_ games: [Giveaway]) {
        mockRepository.games = games
        viewModel.gameList = games
    }
    
    private func validateFilteredGames(expectedCount: Int, expectedTitles: [String]? = nil, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(viewModel.filteredGames.count, expectedCount, file: file, line: line)
        if let titles = expectedTitles {
            XCTAssertEqual(viewModel.filteredGames.map { $0.title }, titles, file: file, line: line)
        }
    }
    
    // MARK: - Test Cases
    
    func testFetchGamesListSuccess() async {
        // Given
        setupMockGames([
            Giveaway(id: 1, title: "Game 1", worth: "$10", thumbnail: "", image: "", description: "", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "PC", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: "")
        ])
        
        // When
        await viewModel.fetchGamesList()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        validateFilteredGames(expectedCount: 1, expectedTitles: ["Game 1"])
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchGamesListFailure() async {
        // Given
        mockRepository.shouldFail = true
        
        // When
        await viewModel.fetchGamesList()
        
        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.gameList.isEmpty)
        XCTAssertTrue(viewModel.filteredGames.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, APIError.noInternet.localizedDescription)
    }
    
    func testPerformSearch() {
        // Given
        setupMockGames([
            Giveaway(id: 1, title: "Game 1", worth: "$10", thumbnail: "", image: "", description: "", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "PC", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: ""),
            Giveaway(id: 2, title: "Game 2", worth: "$20", thumbnail: "", image: "", description: "", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "iOS", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: "")
        ])
        viewModel.searchText = "Game 1"
        
        // When
        viewModel.performSearch()
        
        // Then
        validateFilteredGames(expectedCount: 1, expectedTitles: ["Game 1"])
    }
    
    func testFilterGamesByCategory_PC() {
        // Given
        setupMockGames([
            Giveaway(id: 1, title: "Game 1", worth: "$10", thumbnail: "", image: "", description: "", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "PC", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: ""),
            Giveaway(id: 2, title: "Game 2", worth: "$20", thumbnail: "", image: "", description: "", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "iOS", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: "")
        ])
        viewModel.selectedCategory = .pc
        
        // When
        viewModel.filterGamesByCategory()
        
        // Then
        validateFilteredGames(expectedCount: 1, expectedTitles: ["Game 1"])
    }
    
    func testFilterGamesByCategory_All() {
        // Given
        setupMockGames([
            Giveaway(id: 1, title: "Game 1", worth: "$10", thumbnail: "", image: "", description: "", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "PC", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: ""),
            Giveaway(id: 2, title: "Game 2", worth: "$20", thumbnail: "", image: "", description: "", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "iOS", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: "")
        ])
        viewModel.selectedCategory = .all
        
        // When
        viewModel.filterGamesByCategory()
        
        // Then
        validateFilteredGames(expectedCount: 2)
    }
    
    func testSearchFailure_NoMatchingGames() {
        // Given
        setupMockGames([
            Giveaway(id: 1, title: "Game 1", worth: "$10", thumbnail: "", image: "", description: "", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "PC", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: ""),
            Giveaway(id: 2, title: "Game 2", worth: "$20", thumbnail: "", image: "", description: "", instructions: "", openGiveawayURL: "", publishedDate: "", type: "", platforms: "iOS", endDate: "", users: 0, status: "", gamerpowerURL: "", openGiveaway: "")
        ])
        viewModel.searchText = "Non-existent Game"
        
        // When
        viewModel.performSearch()
        
        // Then
        validateFilteredGames(expectedCount: 0)
    }
}
