//
//  ContentView.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import SwiftUI

// Main View
struct MainView: View {
    @StateObject private var viewModel = MainViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                // Navigation Bar
                NavigationBarView(
                    title: "Ffd",
                    subtitle: "Explore Games Giveaways",
                    profileImage: Image(systemName: "person.circle"),
                    onProfileTapped: {
                        print("Profile tapped")
                    }
                )

                // Search TextField
                SearchTextField()

                // Category Tabs
                CategoryTabView()

                // Game List or Loading/Error State
                GameListView()

                Spacer()
            }
            .task {
                await viewModel.fetchGamesList()
            }.onAppear{
                viewModel.searchText = ""
            }
        }
    }

    // Helper View for Search TextField
    private func SearchTextField() -> some View {
        TextFieldComponent(
            text: $viewModel.searchText,
            placeholder: "Search Game by name",
            icon: "magnifyingglass",
            keyboardType: .default,
            isSecure: false,
            onSubmit: {
                     viewModel.performSearch()
            },
            maxLength: 50
        )
        .padding(.horizontal)
    }

   
    // Helper View for Displaying Game List or Loading/Error
    private func GameListView() -> some View {
        ScrollView {
            LazyVStack(spacing: 10) {  // LazyVStack for efficient rendering
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity)
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)").foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                } else {
                    ForEach(viewModel.filteredGames, id: \.id) { game in
                        CardView(game: game)
                        
                    }
                }
            }
            .padding(.top, 10)
        }
    }

    // Helper method for Category Tab View
    private func CategoryTabView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack(spacing: 16) {
                    ForEach(viewModel.categories) { category in
                        CategoryButton(
                            label: category.rawValue,
                            isSelected: viewModel.selectedCategory == category,
                            action: {
                                viewModel.selectedCategory = category
                                viewModel.filterGamesByCategory()
                            }
                        )
                        .id(category.id)
                    }
                }
                .padding(.horizontal)
                .onChange(of: viewModel.selectedCategory) { newCategory in
                    withAnimation {
                        // Scroll to selected category
                        if let selectedCategory = viewModel.categories.first(where: { $0 == newCategory }) {
                            proxy.scrollTo(selectedCategory.id, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

// Preview
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
