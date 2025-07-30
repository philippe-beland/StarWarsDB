import SwiftUI

// MARK: - View Model
@MainActor
class SourceFactsViewModel: ObservableObject {
    @Published var facts: [Fact] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let source: Source
    private var saveTask: Task<Void, Never>?
    
    init(source: Source) {
        self.source = source
    }
    
    func loadFacts() async {
        isLoading = true
        errorMessage = nil
        facts = await loadSourceFacts(entityField: "source", sourceID: source.id)
        isLoading = false
    }
    
    func addFact() {
        let fact = Fact(fact: "", source: source, keywords: [])
        facts.insert(fact, at: 0)
        fact.save()
    }
    
    func deleteFact(_ indexSet: IndexSet) {
        for index in indexSet {
            let fact = facts[index]
            facts.remove(at: index)
            fact.delete()
        }
    }
    
    func updateFact(_ fact: Fact) {
        // Cancel previous save task
        saveTask?.cancel()
        
        // Debounce the save operation
        saveTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds
            if !Task.isCancelled {
                await fact.update()
            }
        }
    }
}

// MARK: - Main View
struct SourceFactsView: View {
    let source: Source
    @StateObject private var viewModel: SourceFactsViewModel
    @FocusState private var focusedFactID: UUID?
    
    init(source: Source) {
        self.source = source
        self._viewModel = StateObject(wrappedValue: SourceFactsViewModel(source: source))
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    VStack(spacing: 16) {
                        ProgressView()
                            .scaleEffect(1.2)
                        
                        Text("Loading facts...")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 48))
                            .foregroundColor(.orange)
                        
                        VStack(spacing: 8) {
                            Text("Oops!")
                                .font(.title2)
                                .fontWeight(.medium)
                            
                            Text(errorMessage)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        
                        Button("Try Again") {
                            Task { await viewModel.loadFacts() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else if viewModel.facts.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "note.text")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        
                        VStack(spacing: 8) {
                            Text("No facts yet")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                            
                            Text("Add interesting facts about this source")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        
                        Button(action: viewModel.addFact) {
                            Label("Add First Fact", systemImage: "plus.circle.fill")
                                .font(.headline)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.top, 8)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    factsList
                }
            }
            .navigationTitle("Facts")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: viewModel.addFact) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
        }
        .task {
            await viewModel.loadFacts()
        }
    }
    
    private var factsList: some View {
        List {
            ForEach($viewModel.facts) { $fact in
                FactRowView(
                    fact: $fact,
                    focusedFactID: _focusedFactID,
                    onUpdate: { viewModel.updateFact(fact) }
                )
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                .transition(.asymmetric(
                    insertion: .scale.combined(with: .opacity),
                    removal: .scale.combined(with: .opacity)
                ))
            }
            .onDelete(perform: viewModel.deleteFact)
        }
        .listStyle(.plain) // Cleaner list style
    }
}

// MARK: - Fact Row View
struct FactRowView: View {
    @Binding var fact: Fact
    @FocusState var focusedFactID: UUID?
    let onUpdate: () -> Void
    
    private var calculatedHeight: CGFloat {
        let lineHeight: CGFloat = 20 // Approximate line height
        let charactersPerLine: CGFloat = 45 // Estimate characters per line
        let characterCount = fact.fact.count
        let estimatedLines = max(2, ceil(CGFloat(characterCount) / charactersPerLine)) // Minimum 2 lines
        return lineHeight * CGFloat(estimatedLines)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextEditor(text: $fact.fact)
                .focused($focusedFactID, equals: fact.id)
                .onChange(of: focusedFactID) { _, newFocus in
                    if newFocus != fact.id {
                        onUpdate()
                    }
                }
                .frame(height: calculatedHeight)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                )
                .overlay(
                    // Focus indicator
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(focusedFactID == fact.id ? Color.blue : Color.clear, lineWidth: 2)
                )
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview
#Preview {
    SourceFactsView(source: .example)
}
