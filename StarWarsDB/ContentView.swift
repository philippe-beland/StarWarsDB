//
//  ContentView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            EditCharacterView(character: .example)
                .tabItem {
                    Label("Sources", systemImage: "star")
                }
            EditSpeciesView(species: .example)
                .tabItem {
                    Label("Records", systemImage: "star")
                }
        }
    }
}

#Preview {
    ContentView()
}
