//
//  ContentView.swift
//  WordScramble
//
//  Created by Nate Lee on 7/6/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = "rootWord"
    @State private var newWord = ""
    
    // MARK: - Alert Related Properties
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(usedWords, id:\.self) {
                    Image(systemName: "\($0.count).circle.fill")
                    Text("\($0)")
                }
            }
            .navigationBarTitle(Text(rootWord))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) { () -> Alert in
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func startGame() {
        // Read from bundle
        let fileUrl = Bundle.main.url(forResource: "start", withExtension: "txt")!
        do {
            let str = try String(contentsOf: fileUrl)
            let start = str.components(separatedBy: "\n").randomElement() ?? "silkworm"
            rootWord = start
            
        } catch {
            fatalError("Couldn't read the start.txt file!")
        }
    }
    
    func addNewWord() {
        let trimmed = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmed.count > 0 else {
            return
        }
        
        // DONE: - Guard more things
        guard isOriginal(word: trimmed) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: trimmed) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: trimmed) else {
            wordError(title: "Word not possible", message: "That isn't even a real word!")
            return
        }
        
        usedWords.insert(trimmed, at: 0)
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    // rootWord = "abc",
    func isPossible(word: String) -> Bool {
        var tmpWord = rootWord
        
        for letter in word {
            if let pos = tmpWord.firstIndex(of: letter) {
                tmpWord.remove(at: pos)
            } else { // not found
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return mispelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
