import SwiftUI

enum SortingItemOrder: String {
    case name = "name"
    case frequency = "number"
}

/// View that shows a list of entities of a specific type.
/// Users can search, sort, and delete entities.
/// The list updates automatically when searching or changing sort order.
struct EntityListBrowserView<T:Entity>: View {
    @State private var sortOrder: SortingItemOrder = .name
    @StateObject var searchContext = SearchContext()
    @State private var showNewEntitySheet: Bool = false
    @State private var entities = [T]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(entities) { entity in
                    NavigationLink(destination: EntityDetailRouter<T>(entity: entity)) {
                        EntityRowView<T>(entity: entity)
                    }
                }
                .onDelete(perform: deleteEntity)
            }
            .searchable(text: $searchContext.query, prompt: "Search")
            .navigationTitle(T.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarContent }
        }
        .onChange(of: searchContext.debouncedQuery) { handleSearchTextChange() }
        .task { await loadInitialEntities() }
    }
    
    private func handleSearchTextChange() {
        Task {
            if !searchContext.debouncedQuery.isEmpty && searchContext.debouncedQuery.count >= Constants.Search.minSearchLength {
                entities = await loadEntities(serie: nil, sort: sortOrder, filter: searchContext.debouncedQuery)
            }
        }
    }
    
    private func loadInitialEntities() async {
        entities = await loadEntities(serie: nil, sort: sortOrder, filter: searchContext.debouncedQuery)
    }
    
    private func deleteEntity(_ indexSet: IndexSet) {
        for index in indexSet {
            let entity = entities[index]
            entities.remove(at: index)
            entity.delete()
        }
    }
    
    @ToolbarContentBuilder
    private var ToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Create", systemImage: "plus") {
                showNewEntitySheet.toggle()
            }
            .sheet(isPresented: $showNewEntitySheet) {
                AddSourceEntitySheet<T>(onAdd: {entities.append($0) })
            }
        }
        
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu("Sort", systemImage: "arrow.up.arrow.down") {
                Picker("Sort", selection: $sortOrder) {
                    Text("Name").tag(SortingItemOrder.name)
                    Text("Frequency").tag(SortingItemOrder.frequency)
                }
            }
        }
    }
}

#Preview {
    EntityListBrowserView<Creature>()
}
