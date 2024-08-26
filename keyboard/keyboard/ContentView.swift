//
//  ContentView.swift
//  keyboard
//
//  Created by Dan Kevin on 8/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputText = ""
    @State private var suggestions: [String] = []
    
    var body: some View {
        VStack {
            TextField("Enter text", text: $inputText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .onChange(of: inputText) { newValue in
                    suggestions = generateSuggestions(for: newValue)
                }
            
            HStack {
                ForEach(suggestions, id: \.self) { suggestion in
                    Button(action: {
                        inputText = suggestion
                    }) {
                        Text(suggestion)
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
            }
            .padding()
            
            Spacer()
        }
    }
    
    func generateSuggestions(for input: String) -> [String] {
        let charactersSimilarity: [Character: [Character]] = [
            "a": ["ɑ", "α", "а", "ɒ", "à", "á", "ä", "ã", "å", "ą", "â"],
            "b": ["ɓ", "ƀ", "β", "þ", "в", "Ь", "ƃ", "ь", "ʙ", "Ъ", "ɮ"],
            "c": ["ς", "ϲ", "č", "ç", "ć", "ĉ", "ɕ", "c̨", "ȼ", "ƈ", "ɕ́"],
            "d": ["đ", "ð", "ɗ", "ď", "ƌ", "ɗ̄", "ɖ", "д", "ԁ", "ḑ", "ď́"],
            "e": ["ɛ", "є", "é", "è", "ë", "ê", "ė", "ē", "ę", "ẹ", "ɘ"],
            "f": ["ƒ", "ʄ", "f́", "ƭ", "f̄", "ḟ", "ϝ", "f̨", "f̈", "f̧", "ϝ́"],
            "g": ["ɡ", "ğ", "ĝ", "ġ", "ǧ", "ģ", "ḡ", "ɠ", "ԍ", "ĝ́", "ğ́"],
            "h": ["ћ", "ħ", "ɦ", "ђ", "ħ́", "ћ́", "ḥ", "ɧ", "ʰ", "ẖ", "ẖ"],
            "i": ["í", "ì", "î", "ï", "ı", "į", "ī", "ỉ", "i̇", "i̱", "ǐ"],
            "j": ["ʝ", "ȷ", "ǰ", "ĵ", "j́", "ј", "j̈", "j̄", "j̧", "ʲ", "j̨"],
            "k": ["ƙ", "ķ", "к", "ḳ", "ʞ", "ƙ́", "ќ", "k̨", "k̈", "ƙ̈", "ḱ"],
            "l": ["ł", "ļ", "ľ", "ĺ", "ļ́", "ļ", "Ľ", "l̄", "ʟ", "ḽ", "l̨"],
            "m": ["ɱ", "ṃ", "ḿ", "м", "ʍ", "ɯ", "м́", "m̄", "m̈", "ṃ́", "m̨"],
            "n": ["ŋ", "ń", "ñ", "ñ́", "ń", "и", "и́", "η", "ñ́", "ń́", "n̄"],
            "o": ["ø", "ó", "ò", "ö", "ô", "ō", "ő", "õ", "ọ", "ơ", "ȯ"],
            "p": ["ρ", "þ", "ṕ", "п", "ṕ", "р", "p̄", "p̈", "p̧", "p̈́", "p̨"],
            "q": ["ɋ", "q́", "q̈", "q̧", "ʠ", "q̨", "ɋ̈", "q̄", "q̇", "q̃", "q̈́"],
            "r": ["ř", "ŕ", "ŗ", "ŕ", "r̄", "ṙ", "ŗ", "ɾ", "г", "р", "ṛ"],
            "s": ["ş", "ś", "š", "ṡ", "ś", "ŝ", "ş", "s̄", "s̈", "ş́", "ṣ"],
            "t": ["ţ", "ţ́", "ţ̈", "ṫ", "т", "ţ", "ŧ", "ṭ", "ť", "ṯ", "ŧ́"],
            "u": ["ü", "ū", "ù", "ú", "ũ", "ů", "ű", "ư", "ụ", "ṹ", "ú̄"],
            "v": ["ṿ", "ṽ", "ʋ", "v̈", "ṿ́", "ṽ̈", "v̧", "v̄", "ṿ̈", "ṽ́", "ṽ̄"],
            "w": ["ŵ", "ŵ́", "ŵ̈", "ẁ", "ẃ", "ẅ", "ʍ", "w̄", "ẇ", "ŵ̄", "ŵ̧"],
            "x": ["ẋ", "ẋ", "х", "ẍ", "х́", "х̈", "χ", "χ́", "χ̈", "χ̄", "χ̧"],
            "y": ["ÿ", "ý", "ŷ", "ý", "ÿ", "ỳ", "ỷ", "ȳ", "y̧", "ʏ", "y̨"],
            "z": ["ź", "ż", "ž", "z̈", "з", "z̧", "ʐ", "з́", "z̄", "ż", "ž́"]
        ]
        
        var suggestions: [String] = []
        
        for _ in 0..<5 { // Generate 5 suggestions
            var newWord = ""
            for char in input.lowercased() {
                if let similarChars = charactersSimilarity[char],
                   let randomChar = similarChars.randomElement() {
                    newWord.append(randomChar)
                } else {
                    newWord.append(char)
                }
            }
            suggestions.append(newWord)
        }
        
        return suggestions
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
