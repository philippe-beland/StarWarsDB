import SwiftUI

struct SourceListBrowserView: View {
    var selectedType: SourceType?
    var serie: Serie? = nil
    
    @State private var sortOrder: SortingSourceOrder = .publicationDate
    @StateObject var searchContext = SearchContext()
    @State private var isDoneFilter: Bool = false
    @State private var showNewSourceSheet: Bool = false
    @State private var sources: [Source] = []
    
    let layout: [GridItem] = [GridItem(.adaptive(minimum: 200, maximum: 300))]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(sources) { source in    
                        SourceGridItem(
                        source: source,
                        onDelete: { deleteSource(source) }
                    )
                    }
                }
            }
            .navigationTitle("Sources")
            .searchable(text: $searchContext.query, prompt: "Search")
            .toolbar { toolbarContent }
        }
        .onChange(of: searchContext.debouncedQuery) { handleSearchTextChange() }
        .onChange(of: selectedType) { handleParameterChange() }
        .onChange(of: sortOrder) { handleParameterChange() }
        .onChange(of: isDoneFilter) { handleParameterChange() }
        .task { await loadInitialSources() }
    }
    
    private func handleParameterChange() {
        Task {
            sources = await loadSources(sort: sortOrder.rawValue, sourceType: selectedType, serie: serie, isDone: isDoneFilter, filter: searchContext.debouncedQuery)
        }
    }
    
    private func handleSearchTextChange() {
        Task {
            if !searchContext.debouncedQuery.isEmpty && searchContext.debouncedQuery.count >= Constants.Search.minSearchLength {
                sources = await loadSources(sort: sortOrder.rawValue, sourceType: selectedType, serie: serie, isDone: isDoneFilter, filter: searchContext.debouncedQuery)
            }
        }
    }
    
    private func loadInitialSources() async {
        sources = await loadSources(sort: sortOrder.rawValue, sourceType: selectedType, serie: serie, isDone: isDoneFilter, filter: searchContext.debouncedQuery)
    }
    
    private func deleteSource(_ source: Source) {
        if let index = sources.firstIndex(of: source) {
            sources.remove(at: index)
        }
        source.delete()
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button ("Create") {
                showNewSourceSheet.toggle()
            }
            .sheet(isPresented: $showNewSourceSheet) {
                AddSourceView { source in
                    sources.append(source)}
            }
        }
        ToolbarItem(placement: .topBarTrailing) {
            Menu("Sort", systemImage: "arrow.up.arrow.down") {
                Picker("Sort", selection: $sortOrder) {
                    Text("Publication Date").tag(SortingSourceOrder.publicationDate)
                    Text("Universe Year").tag(SortingSourceOrder.universeYear)
                }
            }
        }
        ToolbarItem(placement: .topBarLeading) {
            Toggle("ToDo", isOn: $isDoneFilter)
                .toggleStyle(ButtonToggleStyle())
        }
    }
}

struct SourceGridItem: View {
    let source: Source
    let onDelete: () -> Void

    @State private var viewModel: EditSourceViewModel

    init(source: Source, onDelete: @escaping () -> Void) {
        self.source = source
        self.onDelete = onDelete
        _viewModel = State(initialValue: EditSourceViewModel(source: source))
    }

    var body: some View {
        NavigationLink(destination: SourceDetailView(viewModel: viewModel)) {
            SourceGridView(source: source)
        }
        .contextMenu {
            Button("Delete", role: .destructive, action: onDelete)
        }
    }
}

#Preview {
    SourceListBrowserView(selectedType: .movies)
}
