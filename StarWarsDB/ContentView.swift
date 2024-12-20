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
            ListSourcesView()
                .tabItem {
                    Label("Sources", systemImage: "star")
                }
            ChooseRecordView()
                .tabItem {
                    Label("Records", systemImage: "star")
                }
        }
    }
}

#Preview {
    ContentView()
}
