//
//  TextFieldView.swift
//  GameExplorer
//
//  Created by Taha Hussein on 22/01/2025.
//

import SwiftUI
struct TextFieldComponent: View {
    @Binding var text: String
    let placeholder: String
    let icon: String?
    let keyboardType: UIKeyboardType
    let isSecure: Bool
    let onCommit: (() -> Void)?
    let maxLength: Int?

    var body: some View {
        HStack {
            // Leading Icon (if provided)
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.gray)
            }

            // TextField or SecureField based on `isSecure`
            if isSecure {
                SecureField(placeholder, text: $text, onCommit: {
                    onCommit?()
                })
                .onChange(of: text) { oldValue, newValue in
                    applyMaxLength(newValue)
                }
                .font(.body)
                .foregroundColor(.primary)
            } else {
                TextField(placeholder, text: $text, onCommit: {
                    onCommit?()
                })
                .onChange(of: text) { oldValue, newValue in
                    applyMaxLength(newValue)
                }
                .font(.body)
                .foregroundColor(.primary)
                .keyboardType(keyboardType)
            }

            // Clear Button
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    // Private helper to enforce maxLength constraint
    private func applyMaxLength(_ newValue: String) {
        if let maxLength = maxLength, newValue.count > maxLength {
            text = String(newValue.prefix(maxLength))
        }
    }
}

