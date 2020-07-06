//
//  ContentView.swift
//  WordScramble
//
//  Created by Nate Lee on 7/6/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        List(people, id: \.self) {
            Text("Dynamic row \($0)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
