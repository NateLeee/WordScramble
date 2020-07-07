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
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                List(usedWords, id:\.self) {
                    Image(systemName: "\($0.count).circle.fill")
                    Text("\($0)")
                }
            }
            .navigationBarTitle(Text(rootWord))
        }
    }
    
    func addNewWord() {
        let trimmed = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        usedWords.insert(trimmed, at: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
