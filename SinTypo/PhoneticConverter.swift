//
//  PhoneticConverter.swift
//  SinTypo
//
//  Created by Sudharaka Ashen on 10/2/25.
//

import Foundation

class PhoneticConverter: ObservableObject {
    @Published var inputText: String = ""
    @Published var sinhalaText: String = ""
    
    private var inputBuffer: String = ""
    
    // MARK: - Main Conversion Methods
    
    func processInput(_ input: String) {
        switch input {
        case "BACKSPACE":
            handleBackspace()
        case "SPACE":
            handleSpaceInput()
        case "ENTER":
            handleEnterInput()
        default:
            processCharacterInput(input)
        }
    }
    
    private func handleSpaceInput() {
        // Try to convert any remaining buffer content before adding space
        if !inputBuffer.isEmpty {
            let converted = convertBufferToSinhala()
            if !converted.isEmpty {
                addCharacter(converted)
                inputBuffer = ""
            } else {
                // If no conversion found, add the buffer as-is
                addCharacter(inputBuffer)
                inputBuffer = ""
            }
        }
        addCharacter(" ")
    }
    
    private func handleEnterInput() {
        // Try to convert any remaining buffer content before adding newline
        if !inputBuffer.isEmpty {
            let converted = convertBufferToSinhala()
            if !converted.isEmpty {
                addCharacter(converted)
                inputBuffer = ""
            } else {
                // If no conversion found, add the buffer as-is
                addCharacter(inputBuffer)
                inputBuffer = ""
            }
        }
        addCharacter("\n")
    }
    
    private func processCharacterInput(_ input: String) {
        inputBuffer += input.lowercased()
        
        // Try to find the longest matching pattern
        let converted = convertBufferToSinhala()
        
        if !converted.isEmpty {
            addCharacter(converted)
            inputBuffer = ""
        } else if inputBuffer.count > 8 { // Increased buffer size for longer words
            // Try to find partial matches before giving up
            if let partialMatch = findPartialMatch() {
                addCharacter(partialMatch.text)
                inputBuffer = partialMatch.remaining
            } else {
                // If buffer gets too long without a match, add the first character as-is
                let firstChar = String(inputBuffer.prefix(1))
                addCharacter(firstChar)
                inputBuffer = String(inputBuffer.dropFirst())
            }
        }
    }
    
    private func findPartialMatch() -> (text: String, remaining: String)? {
        // Try to find the longest possible conversion from the beginning of the buffer
        for length in (1...inputBuffer.count).reversed() {
            let substring = String(inputBuffer.prefix(length))
            let remaining = String(inputBuffer.dropFirst(length))
            
            if let commonWord = SinhalaCharacterMap.getCommonWord(for: substring) {
                return (commonWord, remaining)
            }
            
            if let consonant = SinhalaCharacterMap.getSinhalaConsonant(for: substring) {
                return (consonant, remaining)
            }
            
            if let vowel = SinhalaCharacterMap.getSinhalaVowel(for: substring) {
                return (vowel, remaining)
            }
        }
        
        return nil
    }
    
    private func convertBufferToSinhala() -> String {
        // Try different conversion strategies in order of priority
        
        // 1. Try exact phonetic mappings (longest first)
        if let exactMatch = findExactPhoneticMatch() {
            return exactMatch
        }
        
        // 2. Try consonant + vowel combinations
        if let consonantVowelMatch = findConsonantVowelMatch() {
            return consonantVowelMatch
        }
        
        // 3. Try standalone characters
        if let standaloneMatch = findStandaloneMatch() {
            return standaloneMatch
        }
        
        return ""
    }
    
    // MARK: - Pattern Matching Methods
    
    private func findExactPhoneticMatch() -> String? {
        // Check for exact matches in decreasing length order
        for length in (1...inputBuffer.count).reversed() {
            let substring = String(inputBuffer.prefix(length))
            
            // Check common words FIRST (highest priority)
            if let commonWord = SinhalaCharacterMap.getCommonWord(for: substring) {
                inputBuffer = String(inputBuffer.dropFirst(length))
                return commonWord
            }
            
            // Check consonants (longer matches)
            if let consonant = SinhalaCharacterMap.getSinhalaConsonant(for: substring) {
                inputBuffer = String(inputBuffer.dropFirst(length))
                return consonant
            }
            
            // Check vowels
            if let vowel = SinhalaCharacterMap.getSinhalaVowel(for: substring) {
                inputBuffer = String(inputBuffer.dropFirst(length))
                return vowel
            }
            
            // Check phonetic mappings
            if let phonetic = SinhalaCharacterMap.getPhoneticMapping(for: substring) {
                inputBuffer = String(inputBuffer.dropFirst(length))
                return phonetic
            }
            
            // Check numbers
            if let number = SinhalaCharacterMap.getSinhalaNumber(for: substring) {
                inputBuffer = String(inputBuffer.dropFirst(length))
                return number
            }
            
            // Check special characters
            if let special = SinhalaCharacterMap.getSpecialCharacter(for: substring) {
                inputBuffer = String(inputBuffer.dropFirst(length))
                return special
            }
        }
        
        return nil
    }
    
    private func findConsonantVowelMatch() -> String? {
        // Try to match consonant + vowel combinations
        for consonantLength in (1...inputBuffer.count-1).reversed() {
            let consonantPart = String(inputBuffer.prefix(consonantLength))
            let remainingPart = String(inputBuffer.dropFirst(consonantLength))
            
            if let baseConsonant = SinhalaCharacterMap.getSinhalaConsonant(for: consonantPart) {
                // Try to match a vowel sign with the remaining part
                for vowelLength in (1...remainingPart.count).reversed() {
                    let vowelPart = String(remainingPart.prefix(vowelLength))
                    
                    if let vowelSign = SinhalaCharacterMap.getVowelSign(for: vowelPart) {
                        inputBuffer = String(inputBuffer.dropFirst(consonantLength + vowelLength))
                        return baseConsonant + vowelSign
                    }
                }
            }
        }
        
        return nil
    }
    
    private func findStandaloneMatch() -> String? {
        // Check for single character matches
        let firstChar = String(inputBuffer.prefix(1))
        
        if let vowel = SinhalaCharacterMap.getSinhalaVowel(for: firstChar) {
            inputBuffer = String(inputBuffer.dropFirst())
            return vowel
        }
        
        if let consonant = SinhalaCharacterMap.getSinhalaConsonant(for: firstChar) {
            inputBuffer = String(inputBuffer.dropFirst())
            return consonant
        }
        
        if let number = SinhalaCharacterMap.getSinhalaNumber(for: firstChar) {
            inputBuffer = String(inputBuffer.dropFirst())
            return number
        }
        
        if let special = SinhalaCharacterMap.getSpecialCharacter(for: firstChar) {
            inputBuffer = String(inputBuffer.dropFirst())
            return special
        }
        
        return nil
    }
    
    // MARK: - Text Manipulation Methods
    
    private func addCharacter(_ char: String) {
        sinhalaText += char
        inputText = sinhalaText
    }
    
    private func handleBackspace() {
        if !sinhalaText.isEmpty {
            sinhalaText = String(sinhalaText.dropLast())
            inputText = sinhalaText
        }
        
        // Clear input buffer on backspace
        inputBuffer = ""
    }
    
    func clearAll() {
        sinhalaText = ""
        inputText = ""
        inputBuffer = ""
    }
    
    func setText(_ text: String) {
        sinhalaText = text
        inputText = text
        inputBuffer = ""
    }
    
    // MARK: - Direct Character Input (for keyboard keys)
    
    func addDirectCharacter(_ character: String) {
        sinhalaText += character
        inputText = sinhalaText
    }
    
    func addConsonantWithVowel(consonant: String, vowel: String) {
        if let sinhalaConsonant = SinhalaCharacterMap.getSinhalaConsonant(for: consonant),
           let vowelSign = SinhalaCharacterMap.getVowelSign(for: vowel) {
            sinhalaText += sinhalaConsonant + vowelSign
        } else if let sinhalaConsonant = SinhalaCharacterMap.getSinhalaConsonant(for: consonant) {
            sinhalaText += sinhalaConsonant
        }
        inputText = sinhalaText
    }
    
    // MARK: - Helper Methods
    
    func getCurrentBuffer() -> String {
        return inputBuffer
    }
    
    func getWordCount() -> Int {
        return sinhalaText.split(separator: " ").count
    }
    
    func getCharacterCount() -> Int {
        return sinhalaText.count
    }
    
    // MARK: - Auto-completion Suggestions
    
    func getSuggestions() -> [String] {
        guard !inputBuffer.isEmpty else { return [] }
        
        var suggestions: [String] = []
        
        // Get common word suggestions (highest priority)
        let wordSuggestions = SinhalaCharacterMap.commonWords.keys
            .filter { $0.hasPrefix(inputBuffer.lowercased()) }
            .compactMap { SinhalaCharacterMap.commonWords[$0] }
        
        // Get consonant suggestions
        let consonantSuggestions = SinhalaCharacterMap.consonants.keys
            .filter { $0.hasPrefix(inputBuffer) }
            .compactMap { SinhalaCharacterMap.consonants[$0] }
        
        // Get vowel suggestions
        let vowelSuggestions = SinhalaCharacterMap.vowels.keys
            .filter { $0.hasPrefix(inputBuffer) }
            .compactMap { SinhalaCharacterMap.vowels[$0] }
        
        suggestions.append(contentsOf: wordSuggestions)
        suggestions.append(contentsOf: consonantSuggestions)
        suggestions.append(contentsOf: vowelSuggestions)
        
        return Array(suggestions.prefix(5)) // Limit to 5 suggestions
    }
    
    func getCurrentPossibleConversion() -> String? {
        guard !inputBuffer.isEmpty else { return nil }
        
        // Check if current buffer matches a common word
        if let commonWord = SinhalaCharacterMap.getCommonWord(for: inputBuffer) {
            return commonWord
        }
        
        // Check for other conversions
        return convertBufferToSinhala().isEmpty ? nil : convertBufferToSinhala()
    }
}