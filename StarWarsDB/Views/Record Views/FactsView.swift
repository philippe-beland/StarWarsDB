import SwiftUI

struct FactsView: View {
    let source: Source
    @State private var facts = [Fact]()
    @FocusState private var focusedFactID: UUID?
    
    var body: some View {
        NavigationStack {
            if facts.isEmpty {
                Text("No facts")
                    .foregroundColor(.gray)
                    .italic()
            }
            List {
                ForEach($facts) { $fact in
                    TextEditor(text: $fact.fact)
                        .focused($focusedFactID, equals: fact.id)
                        .onChange(of: focusedFactID) { oldFocus, newFocus in
                            if newFocus != fact.id {
                                fact.update()
                            }
                        }
                }
                .onDelete(perform: deleteFact)
            }
            .navigationTitle("Facts")
            .toolbar {
                Button ("Create", systemImage: "plus") {
                    let fact = Fact(fact: "", source: source, keywords: [])
                    facts.insert(fact, at: 0)
                    fact.save()
                }
            }
        }
        .task {await loadInitialFacts(for: source) }
    }
    
    private func loadInitialFacts(for source: Source) async {
        facts = await loadSourceFacts(recordField: "source", recordID: source.id)
    }
    
    private func deleteFact(_ indexSet: IndexSet) {
        for index in indexSet {
            let fact = facts[index]
            facts.remove(at: index)
            fact.delete()
        }
    }
}

#Preview {
    FactsView(source: .example)
}
