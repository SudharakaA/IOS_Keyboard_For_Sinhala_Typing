//
//  SinhalaCharacterMap.swift
//  SinTypo
//
//  Created by Sudharaka Ashen on 10/2/25.
//

import Foundation

struct SinhalaCharacterMap {
    
    // MARK: - Vowels (ස්වර)
    static let vowels: [String: String] = [
        "a": "අ",
        "aa": "ආ",
        "i": "ඉ",
        "ii": "ඊ",
        "u": "උ",
        "uu": "ඌ",
        "e": "එ",
        "ee": "ඒ",
        "o": "ඔ",
        "oo": "ඕ",
        "au": "ඖ"
    ]
    
    // MARK: - Vowel Signs (පිළි)
    static let vowelSigns: [String: String] = [
        "aa": "ා",
        "i": "ි",
        "ii": "ී",
        "u": "ු",
        "uu": "ූ",
        "e": "ෙ",
        "ee": "ේ",
        "o": "ො",
        "oo": "ෝ",
        "au": "ෞ"
    ]
    
    // MARK: - Consonants (ව්යඤ්ජන)
    static let consonants: [String: String] = [
        "ka": "ක",
        "kha": "ඛ",
        "ga": "ග",
        "gha": "ඝ",
        "nga": "ඞ",
        "cha": "ච",
        "chha": "ඡ",
        "ja": "ජ",
        "jha": "ඣ",
        "nya": "ඤ",
        "tta": "ට",
        "ttha": "ඨ",
        "dda": "ඩ",
        "ddha": "ඪ",
        "nna": "ණ",
        "ta": "ත",
        "tha": "ථ",
        "da": "ද",
        "dha": "ධ",
        "na": "න",
        "pa": "ප",
        "pha": "ඵ",
        "ba": "බ",
        "bha": "භ",
        "ma": "ම",
        "ya": "ය",
        "ra": "ර",
        "la": "ල",
        "va": "ව",
        "sha": "ශ",
        "ssa": "ෂ",
        "sa": "ස",
        "ha": "හ",
        "lla": "ළ",
        "fa": "ෆ"
    ]
    
    // MARK: - Numbers (ඉලක්කම්)
    static let numbers: [String: String] = [
        "0": "෦",
        "1": "෧",
        "2": "෨",
        "3": "෩",
        "4": "෪",
        "5": "෫",
        "6": "෬",
        "7": "෭",
        "8": "෮",
        "9": "෯"
    ]
    
    // MARK: - Special Characters (විශේෂ අකුරු)
    static let specialCharacters: [String: String] = [
        "x": "්", // Al-lakuna (Virama)
        ".": ".",
        ",": ",",
        "?": "?",
        "!": "!",
        ";": ";",
        ":": ":",
        "'": "'",
        "\"": "\"",
        "(": "(",
        ")": ")",
        "-": "-",
        " ": " "
    ]
    
    // MARK: - Common Phonetic Mappings
    static let phoneticMappings: [String: String] = [
        // Single consonants
        "k": "ක්",
        "g": "ග්",
        "ng": "ං",
        "ch": "ච්",
        "j": "ජ්",
        "ny": "ඤ්",
        "t": "ත්",
        "d": "ද්",
        "n": "න්",
        "p": "ප්",
        "b": "බ්",
        "m": "ම්",
        "y": "ය්",
        "r": "ර්",
        "l": "ල්",
        "v": "ව්",
        "w": "ව්",
        "s": "ස්",
        "h": "හ්",
        "f": "ෆ්"
    ]
    
    // MARK: - Common Word Mappings
    static let commonWords: [String: String] = [
        // Family terms
        "amma": "අම්මා",
        "thaththa": "තත්තා",
        "thaththaa": "තත්තා",
        "akka": "අක්කා",
        "aiya": "අයියා",
        "nangi": "නංගි",
        "malli": "මල්ලි",
        "seeya": "සීයා",
        "achchi": "අච්චි",
        "mama": "මාමා",
        "nanda": "නන්දා",
        
        // Common greetings
        "ayubowan": "ආයුබෝවන්",
        "namaste": "නමස්තේ",
        "kohomada": "කොහොමද",
        "suba": "සුභ",
        "udawa": "උදාව",
        "rathri": "රාත්‍රි",
        "dawasa": "දවස",
        
        // Basic words
        "mama": "මම",
        "oya": "ඔයා",
        "eya": "එයා",
        "api": "අපි",
        "oyala": "ඔයාලා",
        "eyala": "එයාලා",
        "meka": "මේක",
        "eka": "එක",
        "oka": "ඔක",
        "kiyala": "කියලා",
        "denna": "දෙන්න",
        "ganna": "ගන්න",
        "enna": "එන්න",
        "yanna": "යන්න",
        "kanna": "කන්න",
        "bonawa": "බොනවා",
        "kanawa": "කනවා",
        "yanawa": "යනවා",
        "enawa": "එනවා",
        "innawa": "ඉන්නවා",
        
        // Colors
        "sudu": "සුදු",
        "kalu": "කළු",
        "ratu": "රතු",
        "kola": "කොළ",
        "nil": "නිල්",
        "kaha": "කහ",
        
        // Numbers (written form)
        "eka": "එක",
        "deka": "දෙක",
        "thuna": "තුන",
        "hathara": "හතර",
        "paha": "පහ",
        "haya": "හය",
        "hatha": "හත",
        "ata": "අට",
        "namaya": "නමය",
        "dahaya": "දහය",
        
        // Common objects
        "geya": "ගෙය",
        "watura": "වතුර",
        "bath": "බත්",
        "kiri": "කිරි",
        "paan": "පාන්",
        "mas": "මස්",
        "kaha": "කහ",
        "mal": "මල්",
        "gaha": "ගහ",
        "patha": "පත",
        "liyana": "ලියන",
        "katha": "කථා",
        
        // Time related
        "adha": "අද",
        "heta": "හෙට",
        "iye": "ඊයෙ",
        "dawasa": "දවස",
        "rathri": "රාත්‍රි",
        "udaa": "උදා",
        "saradha": "සරද",
        "panindu": "පැනිඳු",
        
        // Question words
        "mokada": "මොකද",
        "kawuda": "කවුද",
        "koheda": "කොහෙද",
        "kiyada": "කීයද",
        "kiyawata": "කියවට",
        "oyata": "ඔයාට",
        "mata": "මට",
        "eyata": "එයාට",
        "apita": "අපිට",
        
        // Common expressions
        "honda": "හොඳ",
        "naraka": "නරක",
        "lassana": "ලස්සන",
        "sudda": "සුද්ද",
        "kalu": "කළු",
        "hari": "හරි",
        "naa": "නෑ",
        "ow": "ඔව්",
        "naha": "නහ",
        
        // Place names (common)
        "sinhala": "සිංහල",
        "lanka": "ලංකා",
        "colombo": "කොළඹ",
        "gampaha": "ගම්පහ",
        "kandy": "මහනුවර",
        "galle": "ගාල්ල",
        "jaffna": "යාපනය",
        
        // Technology/modern words
        "computer": "පරිගණක",
        "internet": "අන්තර්ජාල",
        "mobile": "ජංගම",
        "phone": "දුරකථන"
    ]
    
    // MARK: - Helper Methods
    static func getSinhalaVowel(for key: String) -> String? {
        return vowels[key]
    }
    
    static func getSinhalaConsonant(for key: String) -> String? {
        return consonants[key]
    }
    
    static func getSinhalaNumber(for key: String) -> String? {
        return numbers[key]
    }
    
    static func getVowelSign(for key: String) -> String? {
        return vowelSigns[key]
    }
    
    static func getPhoneticMapping(for key: String) -> String? {
        return phoneticMappings[key]
    }
    
    static func getSpecialCharacter(for key: String) -> String? {
        return specialCharacters[key]
    }
    
    static func getCommonWord(for key: String) -> String? {
        return commonWords[key.lowercased()]
    }
    
    // Get all available consonant keys for keyboard layout
    static var consonantKeys: [String] {
        return Array(consonants.keys).sorted()
    }
    
    // Get all available vowel keys for keyboard layout
    static var vowelKeys: [String] {
        return Array(vowels.keys).sorted()
    }
    
    // Get all available number keys for keyboard layout
    static var numberKeys: [String] {
        return Array(numbers.keys).sorted { Int($0) ?? 0 < Int($1) ?? 0 }
    }
}