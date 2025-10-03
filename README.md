# 🇱🇰 SinTypo - Sinhala Typing Keyboard for iOS

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)](https://developer.apple.com/ios/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0-green.svg)](https://developer.apple.com/xcode/swiftui/)
[![License](https://img.shields.io/badge/License-MIT-purple.svg)](LICENSE)

A beautiful, intelligent Sinhala typing keyboard app for iOS that converts phonetic English input to Unicode Sinhala text in real-time. Perfect for Sri Lankan users who want to type in Sinhala using familiar English phonetics!

## ✨ Features

### 🎹 **Dual Input Modes**
- **Virtual Keyboard**: On-screen Sinhala keyboard with all characters
- **Physical Keyboard**: Type phonetic English, get Sinhala output instantly

### 🔤 **Smart Phonetic Conversion**
- **100+ Common Words**: Type `amma` → get `අම්මා` automatically
- **Real-time Preview**: See your conversion before completing
- **Intelligent Buffer**: Handles complex words seamlessly
- **Space-triggered Conversion**: Press space to convert current word

### 🎨 **Beautiful User Interface**
- **Modern SwiftUI Design**: Native iOS look and feel
- **Smooth Animations**: Delightful user experience
- **Dark Mode Support**: Adapts to system appearance
- **Accessibility**: VoiceOver and large text support

### 📱 **Advanced Features**
- **Text Statistics**: Word count, character count, line count
- **Export Options**: Copy, share, and save your text
- **Multiple Layouts**: Consonants, vowels, numbers, symbols
- **Settings**: Customizable font size and preferences
- **Help System**: Built-in guides and examples

## 🚀 Quick Start

### Example Words to Try:
```
amma      → අම්මා      (mother)
thaththa  → තත්තා      (father)
ayubowan  → ආයුබෝවන්   (hello)
kohomada  → කොහොමද     (how are you)
sinhala   → සිංහල      (Sinhala)
namaste   → නමස්තේ     (namaste)
```

## 📋 Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.0+

## 🛠 Installation

1. Clone the repository:
```bash
git clone https://github.com/SudharakaA/IOS_Keyboard_For_Sinhala_Typing.git
```

2. Open the project:
```bash
cd IOS_Keyboard_For_Sinhala_Typing
open SinTypo.xcodeproj
```

3. Build and run in Xcode

## 🎯 How to Use

### Virtual Keyboard Mode
1. Launch the app
2. Use the on-screen keyboard tabs (Consonants, Vowels, Numbers, Symbols)
3. Tap keys to build your Sinhala text
4. Use space, backspace, and enter as needed

### Physical Keyboard Mode
1. Switch to "Physical" mode using the toggle
2. Tap "Tap to Activate" to focus keyboard input
3. Type phonetic English words
4. Press space to convert words to Sinhala
5. See real-time preview as you type

## 🏗 Architecture

### Core Components

- **`SinhalaCharacterMap`**: Complete Unicode mapping system
- **`PhoneticConverter`**: Intelligent conversion engine
- **`KeyboardComponents`**: Reusable UI components
- **`KeyboardLayoutView`**: Virtual keyboard layouts
- **`ContentView`**: Main app interface
- **`AdvancedFeatures`**: Settings, statistics, and utilities

### Key Features Implementation

```swift
// Example: Smart word conversion
"amma" → "අම්මා"
"thaththa" → "තත්තා" 
"ayubowan" → "ආයුබෝවන්"
```

## 🔤 Supported Characters

### Vowels (ස්වර)
- Independent: අ, ආ, ඉ, ඊ, උ, ඌ, එ, ඒ, ඔ, ඕ, ඖ
- Dependent: ා, ි, ී, ු, ූ, ෙ, ේ, ො, ෝ, ෞ

### Consonants (ව්යඤ්ජන)
- All 41 Sinhala consonants including: ක, ග, ච, ජ, ට, ඩ, ත, ද, ප, බ, ම, ය, ර, ල, ව, ශ, ෂ, ස, හ, ළ, ෆ

### Numbers (ඉලක්කම්)
- Sinhala numerals: ෦, ෧, ෨, ෩, ෪, ෫, ෬, ෭, ෮, ෯

### Special Characters
- Punctuation, al-lakuna (්), and common symbols

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### Areas for Contribution:
- 📝 Additional word mappings
- 🎨 UI/UX improvements
- 🔧 Performance optimizations
- 🌍 Localization
- 📖 Documentation
- 🐛 Bug fixes

## 📝 Phonetic Mapping Examples

| English Input | Sinhala Output | Meaning |
|---------------|----------------|---------|
| amma | අම්මා | Mother |
| thaththa | තත්තා | Father |
| akka | අක්කා | Elder sister |
| aiya | අයියා | Elder brother |
| ayubowan | ආයුබෝවන් | Hello/Goodbye |
| kohomada | කොහොමද | How are you? |
| sinhala | සිංහල | Sinhala |
| namaste | නමස්තේ | Namaste |
| mama | මම | I/Me |
| oya | ඔයා | You |

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Sri Lankan Unicode standard
- SwiftUI community
- All contributors and testers
- Sri Lankan developer community

## 📞 Contact

**Sudharaka Ashen**
- GitHub: [@SudharakaA](https://github.com/SudharakaA)
- Repository: [IOS_Keyboard_For_Sinhala_Typing](https://github.com/SudharakaA/IOS_Keyboard_For_Sinhala_Typing)

---

**Made with ❤️ for the Sri Lankan community**

*හදන ලද්දේ ශ්‍රී ලාංකික ප්‍රජාව වෙනුවෙන් ❤️*