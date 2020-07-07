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
        }
    }
    
    func startGame() {
        // Read from bundle
        let fileUrl = Bundle.main.url(forResource: "start", withExtension: "txt")!
        do {
            let str = try String(contentsOf: fileUrl)
            let start = str.components(separatedBy: "\n").randomElement()!
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
        
        usedWords.insert(trimmed, at: 0)
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
