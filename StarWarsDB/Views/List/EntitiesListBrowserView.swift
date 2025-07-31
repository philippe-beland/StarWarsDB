import SwiftUI

/// View that shows a list of entities of a specific type.
/// Users can search and delete entities.
/// The list updates automatically when searching or changing sort order.
struct EntityListBrowserView<T: TrackableEntity>: View {
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
                entities = await loadEntities(filter: searchContext.debouncedQuery)
            }
        }
    }
    
    private func loadInitialEntities() async {
        entities = await loadEntities(filter: searchContext.debouncedQuery)
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
    }
}

#Preview {
    EntityListBrowserView<Creature>()
}
