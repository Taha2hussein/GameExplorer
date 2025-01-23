//
//  GiveawayDetailView.swift
//  GameExplorer
//
//  Created by Taha Hussein on 23/01/2025.
//

import Foundation
import SwiftUI

struct GiveawayDetailView: View {
    @StateObject private var viewModel: GiveawayDetailViewModel
    
    init(game: Giveaway) {
        _viewModel = StateObject(wrappedValue: GiveawayDetailViewModel(game: game))
    }
    
    var body: some View {
        VStack {
            // Display giveaway details
            let giveaway = viewModel.giveaway
            AsyncImage(url: URL(string: giveaway.imageUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(10)
                        .frame(height: 250)
                        .clipped()
                case .failure:
                    Color.gray.opacity(0.2)
                @unknown default:
                    EmptyView()
                }
            }
            .padding(.top)
            
            Text(giveaway.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
            
            Text("Game: \(giveaway.gameType)")
                .font(.title2)
                .padding(.top, 5)
            
            Text("Expiry Date: \(giveaway.expiryDate)")
                .font(.body)
                .padding(.top, 5)
            
            Text("Users: \(giveaway.numberOfUsers)")
                .font(.body)
                .padding(.top, 5)
            
            Text(giveaway.description)
                .font(.body)
                .padding(.top, 10)
            
        }
        .navigationTitle("Giveaway Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
