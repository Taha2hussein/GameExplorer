//
//  CategoryButton.swift
//  GameExplorer
//
//  Created by Taha Hussein on 23/01/2025.
//

import SwiftUI
struct CategoryButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Text(label)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(isSelected ? Color.blue : Color.gray.opacity(0.1))
            .foregroundColor(isSelected ? .white : .blue)
            .cornerRadius(12)
            .onTapGesture {
                action()
            }
    }
}
