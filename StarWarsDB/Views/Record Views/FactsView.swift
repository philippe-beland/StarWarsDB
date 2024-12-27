//
//  FactsView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/26/24.
//

import SwiftUI

struct FactsView: View {
    let source: Source
    @State private var facts = [Fact]()
    
    var body: some View {
        NavigationStack {
            if facts.isEmpty {
                Text("No facts")
                    .foregroundColor(.gray)
                    .italic()
            }
            List {
                ForEach($facts, id: \.id) { fact in
                    TextEditor(text: fact.fact)
                }
            }
            .navigationTitle("Facts")
            .toolbar {
                Button ("Create", systemImage: "plus") {
                    facts.insert(Fact(fact: "", source: source, keywords: []), at: 0)
                }
            }
        }
        .task {await loadInitialFacts(for: source) }
    }
    
    private func loadInitialFacts(for source: Source) async {
        facts = await loadSourceFacts(recordField: "source", recordID: source.id.uuidString)
    }
}

#Preview {
    FactsView(source: .example)
}
