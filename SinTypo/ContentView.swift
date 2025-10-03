//
//  ContentView.swift
//  SinTypo
//
//  Created by Sudharaka Ashen on 10/2/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var converter = PhoneticConverter()
    @State private var showingSettings = false
    @State private var showingAbout = false
    
    var body: some View {
        NavigationView {
            SinhalaTypingView(converter: converter)
                .navigationTitle("SinTypo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { showingAbout = true }) {
                            Image(systemName: "info.circle")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button("Clear All", role: .destructive) {
                                converter.clearAll()
                            }
                            
                            Button("Settings") {
                                showingSettings = true
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                        }
                    }
                }
                .alert("About SinTypo", isPresented: $showingAbout) {
                    Button("OK") { }
                } message: {
                    Text("SinTypo is a Sinhala typing keyboard app that converts phonetic English input to Sinhala Unicode text. Type in English phonetics and see your words appear in beautiful Sinhala script!")
                }
                .sheet(isPresented: $showingSettings) {
                    SettingsView()
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SinhalaTypingView: View {
    @ObservedObject var converter: PhoneticConverter
    @State private var inputMode: InputMode = .keyboard
    
    var body: some View {
        VStack(spacing: 0) {
            // Text Display Area
            VStack(spacing: 16) {
                TextDisplayArea(
                    text: $converter.inputText,
                    placeholder: "Start typing in Sinhala... Type 'namaste' for 'නමස්තේ'"
                )
                
                // Action Buttons
                HStack(spacing: 12) {
                    ActionButton(
                        title: "Copy",
                        icon: "doc.on.doc",
                        color: .blue
                    ) {
                        copyToClipboard()
                    }
                    
                    ActionButton(
                        title: "Share",
                        icon: "square.and.arrow.up",
                        color: .green
                    ) {
                        shareText()
                    }
                    
                    ActionButton(
                        title: "Clear",
                        icon: "trash",
                        color: .red
                    ) {
                        converter.clearAll()
                    }
                    
                    Spacer()
                    
                    // Input Mode Toggle
                    Picker("Input Mode", selection: $inputMode) {
                        Text("Virtual").tag(InputMode.keyboard)
                        Text("Physical").tag(InputMode.phonetic)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 120)
                }
            }
            .padding()
            .background(Color.white)
            
            Divider()
            
            // Input Area
            if inputMode == .keyboard {
                KeyboardLayoutView(converter: converter) { keyData in
                    handleKeyPress(keyData)
                }
            } else {
                PhysicalKeyboardInputView(converter: converter)
            }
        }
        .background(Color.gray.opacity(0.05))
    }
    
    private func handleKeyPress(_ keyData: KeyboardKeyData) {
        switch keyData.keyType {
        case .backspace:
            converter.processInput("BACKSPACE")
        case .space:
            converter.processInput("SPACE")
        case .enter:
            converter.processInput("ENTER")
        default:
            if let sinhalaText = keyData.sinhalaText {
                converter.addDirectCharacter(sinhalaText)
            } else {
                converter.processInput(keyData.key)
            }
        }
    }
    
    private func copyToClipboard() {
        UIPasteboard.general.string = converter.sinhalaText
        // You might want to show a toast or alert here
    }
    
    private func shareText() {
        let activityViewController = UIActivityViewController(
            activityItems: [converter.sinhalaText],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityViewController, animated: true)
        }
    }
}

// MARK: - Physical Keyboard Input View
struct PhysicalKeyboardInputView: View {
    @ObservedObject var converter: PhoneticConverter
    @State private var inputText: String = ""
    @FocusState private var isInputFocused: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            // Input Status
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "keyboard")
                        .foregroundColor(.blue)
                    Text("Physical Keyboard Mode")
                        .font(.headline)
                    Spacer()
                    
                    Button(action: {
                        isInputFocused = true
                    }) {
                        Text(isInputFocused ? "🟢 Active" : "⚪ Tap to Activate")
                            .font(.caption)
                            .foregroundColor(isInputFocused ? .green : .blue)
                    }
                }
                
                // Current typing preview
                if !converter.getCurrentBuffer().isEmpty {
                    HStack {
                        Text("Currently typing:")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(converter.getCurrentBuffer())
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.blue)
                        
                        if let preview = converter.getCurrentPossibleConversion() {
                            Image(systemName: "arrow.right")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            Text(preview)
                                .font(.caption)
                                .foregroundColor(.green)
                                .fontWeight(.medium)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue.opacity(0.1))
                    )
                }
            }
            
            // Invisible text field for capturing keyboard input
            TextField("", text: $inputText)
                .focused($isInputFocused)
                .opacity(0)
                .frame(height: 0)
                .onChange(of: inputText) { oldValue, newValue in
                    handleKeyboardInput(oldValue: oldValue, newValue: newValue)
                }
                .onSubmit {
                    converter.processInput("ENTER")
                }
            
            // Instructions and examples
            VStack(alignment: .leading, spacing: 16) {
                // Instructions
                VStack(alignment: .leading, spacing: 8) {
                    Text("How to Use:")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        InstructionItem(step: "1", text: "Tap 'Tap to Activate' above to focus keyboard input")
                        InstructionItem(step: "2", text: "Type phonetic English words using your physical keyboard")
                        InstructionItem(step: "3", text: "Press Space to convert current word")
                        InstructionItem(step: "4", text: "Press Enter for new line")
                        InstructionItem(step: "5", text: "Use Backspace to delete")
                    }
                }
                
                Divider()
                
                // Examples
                VStack(alignment: .leading, spacing: 8) {
                    Text("Try These Words:")
                        .font(.subheadline)
                        .fontWeight(.medium)
                    
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 8) {
                        ExampleWord(english: "amma", sinhala: "අම්මා")
                        ExampleWord(english: "thaththa", sinhala: "තත්තා")
                        ExampleWord(english: "ayubowan", sinhala: "ආයුබෝවන්")
                        ExampleWord(english: "kohomada", sinhala: "කොහොමද")
                        ExampleWord(english: "sinhala", sinhala: "සිංහල")
                        ExampleWord(english: "namaste", sinhala: "නමස්තේ")
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            // Auto-focus when view appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isInputFocused = true
            }
        }
        .onTapGesture {
            isInputFocused = true
        }
    }
    
    private func handleKeyboardInput(oldValue: String, newValue: String) {
        if newValue.count > oldValue.count {
            // Characters added
            let addedText = String(newValue.suffix(newValue.count - oldValue.count))
            for char in addedText {
                if char == " " {
                    converter.processInput("SPACE")
                } else {
                    converter.processInput(String(char))
                }
            }
        } else if newValue.count < oldValue.count {
            // Characters deleted
            let deletedCount = oldValue.count - newValue.count
            for _ in 0..<deletedCount {
                converter.processInput("BACKSPACE")
            }
        }
        
        // Clear input field to keep it ready for next input
        DispatchQueue.main.async {
            inputText = ""
        }
    }
}

struct InstructionItem: View {
    let step: String
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Text(step)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 16, height: 16)
                .background(Circle().fill(Color.blue))
            
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

struct ExampleWord: View {
    let english: String
    let sinhala: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(sinhala)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Text(english)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
        )
    }
}

// MARK: - Legacy Phonetic Input View (for reference)
struct PhoneticInputView: View {
    @ObservedObject var converter: PhoneticConverter
    @State private var phoneticInput: String = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Physical Keyboard Input")
                        .font(.headline)
                    Spacer()
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
                        }
                    }
                }
                
                TextField("Type using your physical keyboard...", text: $phoneticInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isTextFieldFocused)
                    .font(.system(size: 16))
                    .onSubmit {
                        // Handle Enter key
                        converter.processInput("ENTER")
                        phoneticInput = ""
                    }
                    .onChange(of: phoneticInput) { oldValue, newValue in
                        handlePhysicalKeyboardInput(oldValue: oldValue, newValue: newValue)
                    }
                
                Button(action: {
                    isTextFieldFocused = true
                }) {
                    HStack {
                        Image(systemName: "keyboard")
                        Text("Tap to activate physical keyboard")
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
            }
            
            // Quick Reference
            VStack(alignment: .leading, spacing: 8) {
                Text("Quick Reference:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        QuickReferenceItem(phonetic: "amma", sinhala: "අම්මා")
                        QuickReferenceItem(phonetic: "thaththa", sinhala: "තත්තා")
                        QuickReferenceItem(phonetic: "namaste", sinhala: "නමස්තේ")
                        QuickReferenceItem(phonetic: "ayubowan", sinhala: "ආයුබෝවන්")
                        QuickReferenceItem(phonetic: "sinhala", sinhala: "සිංහල")
                        QuickReferenceItem(phonetic: "kohomada", sinhala: "කොහොමද")
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            isTextFieldFocused = true
        }
    }
    
    private func handlePhysicalKeyboardInput(oldValue: String, newValue: String) {
        if newValue.count > oldValue.count {
            // Character added
            let addedCharacters = String(newValue.suffix(newValue.count - oldValue.count))
            for char in addedCharacters {
                if char == " " {
                    converter.processInput("SPACE")
                } else {
                    converter.processInput(String(char))
                }
            }
        } else if newValue.count < oldValue.count {
            // Character deleted
            let deletedCount = oldValue.count - newValue.count
            for _ in 0..<deletedCount {
                converter.processInput("BACKSPACE")
            }
        }
        
        // Clear the text field but keep focus for continuous typing
        DispatchQueue.main.async {
            phoneticInput = ""
        }
    }
}

struct QuickReferenceItem: View {
    let phonetic: String
    let sinhala: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(sinhala)
                .font(.title2)
                .fontWeight(.medium)
            Text(phonetic)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.1))
        )
    }
}

// MARK: - Settings View
struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section("About") {
                    HStack {
                        Image(systemName: "keyboard")
                            .foregroundColor(.blue)
                        VStack(alignment: .leading) {
                            Text("SinTypo")
                                .font(.headline)
                            Text("Sinhala Typing Keyboard")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section("Features") {
                    Label("Phonetic typing", systemImage: "abc")
                    Label("Virtual keyboard", systemImage: "keyboard")
                    Label("Unicode support", systemImage: "textformat")
                    Label("Copy & Share", systemImage: "square.and.arrow.up")
                }
                
                Section("Instructions") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("• Use the virtual keyboard to type directly in Sinhala")
                        Text("• Switch to phonetic mode to type English sounds")
                        Text("• Example: 'namaste' becomes 'නමස්තේ'")
                        Text("• Example: 'ayubowan' becomes 'ආයුබෝවන්'")
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

enum InputMode {
    case keyboard
    case phonetic
}

#Preview {
    ContentView()
}
