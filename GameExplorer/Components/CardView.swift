//
//  CardView.swift
//  GameExplorer
//
//  Created by Taha Hussein on 23/01/2025.
//

import Foundation
import SwiftUI

// CardView
struct CardView: View {
    let game: Giveaway

    var body: some View {
        NavigationLink(destination: GiveawayDetailView(game: game)) {
            ZStack(alignment: .top) {
                // Background Image
                AsyncImage(url: URL(string: game.thumbnail)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(10)
                            .clipped()
                    case .failure:
                        Color.gray.opacity(0.2)
                    @unknown default:
                        EmptyView()
                    }
                }
                .cornerRadius(10)
                .shadow(radius: 5)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(game.title )
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(game.platforms )
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Text(game.description )
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                        .truncationMode(.tail)
                }
                .padding(10)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .buttonStyle(PlainButtonStyle()) 
    }
}
