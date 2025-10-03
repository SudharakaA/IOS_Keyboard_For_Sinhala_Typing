//
//  KeyboardComponents.swift
//  SinTypo
//
//  Created by Sudharaka Ashen on 10/2/25.
//

import SwiftUI

// MARK: - Keyboard Key View
struct KeyboardKey: View {
    let text: String
    let sinhalaText: String?
    let action: () -> Void
    let isSpecial: Bool
    let width: CGFloat?
    
    init(text: String, sinhalaText: String? = nil, width: CGFloat? = nil, isSpecial: Bool = false, action: @escaping () -> Void) {
        self.text = text
        self.sinhalaText = sinhalaText
        self.width = width
        self.isSpecial = isSpecial
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                if let sinhalaText = sinhalaText {
                    Text(sinhalaText)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                }
                Text(text)
                    .font(sinhalaText != nil ? .caption : .title3)
                    .fontWeight(.medium)
                    .foregroundColor(sinhalaText != nil ? .secondary : .primary)
            }
            .frame(width: width ?? 45, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSpecial ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            )
        }
        .buttonStyle(KeyPressStyle())
    }
}

// MARK: - Key Press Animation Style
struct KeyPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Keyboard Row View
struct KeyboardRow: View {
    let keys: [KeyboardKeyData]
    let onKeyPress: (KeyboardKeyData) -> Void
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(keys, id: \.id) { keyData in
                KeyboardKey(
                    text: keyData.displayText,
                    sinhalaText: keyData.sinhalaText,
                    width: keyData.width,
                    isSpecial: keyData.isSpecial
                ) {
                    onKeyPress(keyData)
                }
            }
        }
    }
}

// MARK: - Keyboard Tab Button
struct KeyboardTabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isSelected ? Color.blue : Color.gray.opacity(0.1))
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Text Display Area
struct TextDisplayArea: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Sinhala Text")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(text.count) characters")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            ScrollView {
                VStack {
                    if text.isEmpty {
                        Text(placeholder)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text(text)
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .textSelection(.enabled)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .frame(height: 120)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
            )
        }
    }
}

// MARK: - Action Button
struct ActionButton: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .medium))
                Text(title)
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Keyboard Key Data Model
struct KeyboardKeyData: Identifiable {
    let id = UUID()
    let key: String
    let displayText: String
    let sinhalaText: String?
    let width: CGFloat?
    let isSpecial: Bool
    let keyType: KeyType
    
    init(key: String, displayText: String? = nil, sinhalaText: String? = nil, width: CGFloat? = nil, isSpecial: Bool = false, keyType: KeyType = .character) {
        self.key = key
        self.displayText = displayText ?? key
        self.sinhalaText = sinhalaText
        self.width = width
        self.isSpecial = isSpecial
        self.keyType = keyType
    }
}

// MARK: - Key Types
enum KeyType {
    case character
    case vowel
    case consonant
    case number
    case special
    case space
    case backspace
    case enter
}

// MARK: - Keyboard Layout Type
enum KeyboardLayout: String, CaseIterable {
    case consonants = "Consonants"
    case vowels = "Vowels"
    case numbers = "Numbers"
    case symbols = "Symbols"
    
    var title: String {
        return rawValue
    }
}