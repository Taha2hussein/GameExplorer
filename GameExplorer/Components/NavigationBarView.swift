//
//  NavigationBarView.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import SwiftUI

struct NavigationBarView: View {
    let title: String
    let subtitle: String?
    let profileImage: Image?
    let onProfileTapped: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("👋 Hello, \(title)")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
                    if let subtitle = subtitle {
                        Text(subtitle)
                            .font(.largeTitle.bold())
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                if let profileImage = profileImage {
                    Button(action: {
                        onProfileTapped?()
                    }) {
                        profileImage
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 16)
        .background(Color.white)
       
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(
            title: "Ffd",
            subtitle: "Explore Games Giveaways",
            profileImage: Image(systemName: "person.circle"),
            onProfileTapped: {
                print("Profile tapped")
            }
        )
        .previewLayout(.sizeThatFits)
    }
}
