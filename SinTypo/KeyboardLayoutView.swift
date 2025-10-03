//
//  KeyboardLayoutView.swift
//  SinTypo
//
//  Created by Sudharaka Ashen on 10/2/25.
//

import SwiftUI

struct KeyboardLayoutView: View {
    @ObservedObject var converter: PhoneticConverter
    @State private var selectedLayout: KeyboardLayout = .consonants
    
    let onKeyPress: (KeyboardKeyData) -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            // Keyboard Layout Tabs
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(KeyboardLayout.allCases, id: \.self) { layout in
                        KeyboardTabButton(
                            title: layout.title,
                            isSelected: selectedLayout == layout
                        ) {
                            selectedLayout = layout
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // Current Input Buffer Display
            if !converter.getCurrentBuffer().isEmpty {
                HStack {
                    Text("Typing: \(converter.getCurrentBuffer())")
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    if let preview = converter.getCurrentPossibleConversion() {
                        Image(systemName: "arrow.right")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(preview)
                            .font(.caption)
                            .foregroundColor(.green)
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            // Keyboard Layout
            VStack(spacing: 8) {
                switch selectedLayout {
                case .consonants:
                    ConsonantsKeyboardView(onKeyPress: onKeyPress)
                case .vowels:
                    VowelsKeyboardView(onKeyPress: onKeyPress)
                case .numbers:
                    NumbersKeyboardView(onKeyPress: onKeyPress)
                case .symbols:
                    SymbolsKeyboardView(onKeyPress: onKeyPress)
                }
                
                // Common Action Keys
                ActionKeysRow(onKeyPress: onKeyPress)
            }
            .padding(.horizontal)
        }
        .background(Color.gray.opacity(0.05))
    }
}

// MARK: - Consonants Keyboard
struct ConsonantsKeyboardView: View {
    let onKeyPress: (KeyboardKeyData) -> Void
    
    private let consonantRows: [[String]] = [
        ["ka", "kha", "ga", "gha", "nga"],
        ["cha", "chha", "ja", "jha", "nya"],
        ["tta", "ttha", "dda", "ddha", "nna"],
        ["ta", "tha", "da", "dha", "na"],
        ["pa", "pha", "ba", "bha", "ma"],
        ["ya", "ra", "la", "va", "sha"],
        ["ssa", "sa", "ha", "lla", "fa"]
    ]
    
    var body: some View {
        VStack(spacing: 6) {
            ForEach(consonantRows, id: \.self) { row in
                KeyboardRow(
                    keys: row.map { consonant in
                        KeyboardKeyData(
                            key: consonant,
                            displayText: consonant,
                            sinhalaText: SinhalaCharacterMap.getSinhalaConsonant(for: consonant),
                            keyType: .consonant
                        )
                    },
                    onKeyPress: onKeyPress
                )
            }
        }
    }
}

// MARK: - Vowels Keyboard
struct VowelsKeyboardView: View {
    let onKeyPress: (KeyboardKeyData) -> Void
    
    private let vowelRows: [[String]] = [
        ["a", "aa", "i", "ii"],
        ["u", "uu", "e", "ee"],
        ["o", "oo", "au"]
    ]
    
    var body: some View {
        VStack(spacing: 6) {
            ForEach(vowelRows, id: \.self) { row in
                KeyboardRow(
                    keys: row.map { vowel in
                        KeyboardKeyData(
                            key: vowel,
                            displayText: vowel,
                            sinhalaText: SinhalaCharacterMap.getSinhalaVowel(for: vowel),
                            keyType: .vowel
                        )
                    },
                    onKeyPress: onKeyPress
                )
            }
            
            // Vowel Signs Row
            Text("Vowel Signs (පිළි)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 8)
            
            ForEach(vowelRows, id: \.self) { row in
                KeyboardRow(
                    keys: row.compactMap { vowel in
                        guard vowel != "a" else { return nil } // 'a' doesn't have a vowel sign
                        return KeyboardKeyData(
                            key: vowel + "_sign",
                            displayText: vowel,
                            sinhalaText: SinhalaCharacterMap.getVowelSign(for: vowel),
                            keyType: .vowel
                        )
                    },
                    onKeyPress: onKeyPress
                )
            }
        }
    }
}

// MARK: - Numbers Keyboard
struct NumbersKeyboardView: View {
    let onKeyPress: (KeyboardKeyData) -> Void
    
    private let numberRows: [[String]] = [
        ["1", "2", "3", "4", "5"],
        ["6", "7", "8", "9", "0"]
    ]
    
    var body: some View {
        VStack(spacing: 6) {
            ForEach(numberRows, id: \.self) { row in
                KeyboardRow(
                    keys: row.map { number in
                        KeyboardKeyData(
                            key: number,
                            displayText: number,
                            sinhalaText: SinhalaCharacterMap.getSinhalaNumber(for: number),
                            keyType: .number
                        )
                    },
                    onKeyPress: onKeyPress
                )
            }
        }
    }
}

// MARK: - Symbols Keyboard
struct SymbolsKeyboardView: View {
    let onKeyPress: (KeyboardKeyData) -> Void
    
    private let symbolRows: [[String]] = [
        [".", ",", "?", "!", ";"],
        [":", "'", "\"", "(", ")"],
        ["-", "x"] // x for al-lakuna (virama)
    ]
    
    var body: some View {
        VStack(spacing: 6) {
            ForEach(symbolRows, id: \.self) { row in
                KeyboardRow(
                    keys: row.map { symbol in
                        KeyboardKeyData(
                            key: symbol,
                            displayText: symbol == "x" ? "්" : symbol,
                            sinhalaText: symbol == "x" ? "්" : SinhalaCharacterMap.getSpecialCharacter(for: symbol),
                            keyType: .special
                        )
                    },
                    onKeyPress: onKeyPress
                )
            }
        }
    }
}

// MARK: - Action Keys Row
struct ActionKeysRow: View {
    let onKeyPress: (KeyboardKeyData) -> Void
    
    var body: some View {
        HStack(spacing: 8) {
            // Space key
            KeyboardKey(
                text: "Space",
                width: 120,
                isSpecial: true
            ) {
                onKeyPress(KeyboardKeyData(
                    key: "SPACE",
                    displayText: "Space",
                    width: 120,
                    isSpecial: true,
                    keyType: .space
                ))
            }
            
            Spacer()
            
            // Backspace key
            KeyboardKey(
                text: "⌫",
                width: 60,
                isSpecial: true
            ) {
                onKeyPress(KeyboardKeyData(
                    key: "BACKSPACE",
                    displayText: "⌫",
                    width: 60,
                    isSpecial: true,
                    keyType: .backspace
                ))
            }
            
            // Enter key
            KeyboardKey(
                text: "↵",
                width: 60,
                isSpecial: true
            ) {
                onKeyPress(KeyboardKeyData(
                    key: "ENTER",
                    displayText: "↵",
                    width: 60,
                    isSpecial: true,
                    keyType: .enter
                ))
            }
        }
    }
}

// MARK: - Keyboard Layout Preview
#Preview {
    KeyboardLayoutView(
        converter: PhoneticConverter()
    ) { keyData in
        print("Key pressed: \(keyData.key)")
    }
}