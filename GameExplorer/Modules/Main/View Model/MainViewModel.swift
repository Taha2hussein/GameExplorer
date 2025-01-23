//
//  MainViewModel.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import SwiftUI
import Combine

@MainActor
class MainViewModel: ObservableObject {
    private let gameRepository: GamesRepository
    @Published var searchText: String = ""
    @Published var categories: [CategoryType] = []
    @Published var gameList: [Giveaway] = []
    @Published var filteredGames: [Giveaway] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var selectedCategory: CategoryType = .all
    private var cancellables = Set<AnyCancellable>()

    // Injected Dependency for fetching games
    init(gameRepository: GamesRepository = DefaultGamesRepository()) {
        self.gameRepository = gameRepository
        loadCategories()
    }
    
    private func loadCategories() {
        categories = CategoryType.allCases
    }
    
    // Fetch games list and apply category filter
    func fetchGamesList() async {
        isLoading = true
        do {
            let games = try await gameRepository.fetchGamesList()
            gameList = games
            filterGamesByCategory() // Apply category filter after fetching
            print("result:", gameList)
        } catch {
            handleError(error)
        }
        isLoading = false
    }
    
    // Perform search logic
    func performSearch()  {
        isLoading = true
        gameRepository.searchGame(query: searchText)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }, receiveValue: { games in
                self.gameList = games
                self.filterGamesByCategory()
            })
            .store(in: &cancellables)

        isLoading = false
        print("searchedjjj",searchText)
    }
    
    func filterGamesByCategory() {
        if selectedCategory == .all {
            filteredGames = gameList
        } else {
            filteredGames = gameList.filter { $0.platforms.contains(selectedCategory.rawValue) == true }
        }
    }
    
    // Handle error
    private func handleError(_ error: Error) {
        if let apiError = error as? APIError {
            errorMessage = apiError.localizedDescription
        } else {
            errorMessage = "Unexpected error occurred: \(error.localizedDescription)"
        }
    }
}


enum CategoryType: String, Identifiable, CaseIterable {
    case all = "all"
    case pc = "PC"
    case ios = "iOS"
    case android = "Android"
    case more = "More"
    
    var id: String { self.rawValue }
}
