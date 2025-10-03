//
//  AdvancedFeatures.swift
//  SinTypo
//
//  Created by Sudharaka Ashen on 10/2/25.
//

import SwiftUI
import UniformTypeIdentifiers

// MARK: - Text History Manager
class TextHistoryManager: ObservableObject {
    @Published var history: [String] = []
    private let maxHistoryItems = 20
    
    func addToHistory(_ text: String) {
        guard !text.isEmpty, !history.contains(text) else { return }
        
        history.insert(text, at: 0)
        
        if history.count > maxHistoryItems {
            history.removeLast()
        }
    }
    
    func clearHistory() {
        history.removeAll()
    }
}

// MARK: - Export Options
enum ExportFormat: String, CaseIterable {
    case plainText = "Plain Text"
    case richText = "Rich Text"
    case pdf = "PDF"
    
    var fileExtension: String {
        switch self {
        case .plainText: return "txt"
        case .richText: return "rtf"
        case .pdf: return "pdf"
        }
    }
    
    var utType: UTType {
        switch self {
        case .plainText: return .plainText
        case .richText: return .rtf
        case .pdf: return .pdf
        }
    }
}

// MARK: - Text Statistics View
struct TextStatisticsView: View {
    let text: String
    
    private var statistics: (words: Int, characters: Int, charactersNoSpaces: Int, lines: Int) {
        let words = text.split(separator: " ").count
        let characters = text.count
        let charactersNoSpaces = text.replacingOccurrences(of: " ", with: "").count
        let lines = text.split(separator: "\n").count
        
        return (words, characters, charactersNoSpaces, lines)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Text Statistics")
                .font(.headline)
                .padding(.bottom, 4)
            
            HStack {
                StatisticItem(title: "Words", value: "\(statistics.words)")
                Spacer()
                StatisticItem(title: "Characters", value: "\(statistics.characters)")
            }
            
            HStack {
                StatisticItem(title: "Characters (no spaces)", value: "\(statistics.charactersNoSpaces)")
                Spacer()
                StatisticItem(title: "Lines", value: "\(statistics.lines)")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.1))
        )
    }
}

struct StatisticItem: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Font Size Selector
struct FontSizeSelector: View {
    @Binding var fontSize: CGFloat
    
    private let fontSizes: [CGFloat] = [12, 14, 16, 18, 20, 24, 28, 32]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Font Size")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(fontSizes, id: \.self) { size in
                        Button(action: { fontSize = size }) {
                            Text("\(Int(size))")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(fontSize == size ? .white : .primary)
                                .frame(width: 40, height: 32)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(fontSize == size ? Color.blue : Color.gray.opacity(0.1))
                                )
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

// MARK: - Keyboard Shortcuts Help
struct KeyboardShortcutsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Keyboard Shortcuts")
                .font(.headline)
                .padding(.bottom, 4)
            
            VStack(alignment: .leading, spacing: 8) {
                ShortcutItem(key: "Space", description: "Add space")
                ShortcutItem(key: "⌫", description: "Delete character")
                ShortcutItem(key: "↵", description: "New line")
                ShortcutItem(key: "x", description: "Al-lakuna (්)")
            }
            
            Text("Phonetic Examples")
                .font(.headline)
                .padding(.top, 8)
                .padding(.bottom, 4)
            
            VStack(alignment: .leading, spacing: 8) {
                PhoneticExample(input: "namaste", output: "නමස්තේ")
                PhoneticExample(input: "ayubowan", output: "ආයුබෝවන්")
                PhoneticExample(input: "sinhala", output: "සිංහල")
                PhoneticExample(input: "kaluwara", output: "කළුවර")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.05))
        )
    }
}

struct ShortcutItem: View {
    let key: String
    let description: String
    
    var body: some View {
        HStack {
            Text(key)
                .font(.system(.caption, design: .monospaced))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                )
            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)
            Spacer()
        }
    }
}

struct PhoneticExample: View {
    let input: String
    let output: String
    
    var body: some View {
        HStack {
            Text(input)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.blue)
            Image(systemName: "arrow.right")
                .font(.caption)
                .foregroundColor(.secondary)
            Text(output)
                .font(.caption)
                .fontWeight(.medium)
            Spacer()
        }
    }
}

// MARK: - Advanced Settings View
struct AdvancedSettingsView: View {
    @Binding var fontSize: CGFloat
    @Binding var enableHapticFeedback: Bool
    @Binding var enableSoundFeedback: Bool
    @State private var showingKeyboardHelp = false
    
    var body: some View {
        List {
            Section("Display") {
                FontSizeSelector(fontSize: $fontSize)
            }
            
            Section("Feedback") {
                Toggle("Haptic Feedback", isOn: $enableHapticFeedback)
                Toggle("Sound Feedback", isOn: $enableSoundFeedback)
            }
            
            Section("Help") {
                Button("Keyboard Shortcuts") {
                    showingKeyboardHelp = true
                }
                
                Button("Reset Settings") {
                    fontSize = 18
                    enableHapticFeedback = true
                    enableSoundFeedback = false
                }
                .foregroundColor(.red)
            }
        }
        .sheet(isPresented: $showingKeyboardHelp) {
            NavigationView {
                ScrollView {
                    KeyboardShortcutsView()
                        .padding()
                }
                .navigationTitle("Help")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            showingKeyboardHelp = false
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Enhanced Text Display with Advanced Features
struct EnhancedTextDisplayArea: View {
    @Binding var text: String
    let placeholder: String
    let fontSize: CGFloat
    @State private var showingStatistics = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Sinhala Text")
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Button(action: { showingStatistics.toggle() }) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.blue)
                }
            }
            
            ScrollView {
                VStack {
                    if text.isEmpty {
                        Text(placeholder)
                            .font(.system(size: fontSize))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Text(text)
                            .font(.system(size: fontSize))
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .textSelection(.enabled)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
            .frame(height: showingStatistics ? 80 : 120)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
            )
            
            if showingStatistics {
                TextStatisticsView(text: text)
            }
        }
    }
}