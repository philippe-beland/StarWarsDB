import SwiftUI

enum SortingItemOrder: String {
    case name = "name"
    case frequency = "number"
}

struct ListEntitiesView: View {
    var entityType: EntityType
    
    @State private var sortOrder: SortingItemOrder = .name
    @StateObject var searchContext = SearchContext()
    @State private var showNewEntitySheet: Bool = false
    @State private var entities = [Entity]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(entities) { entity in
                    NavigationLink(destination: EditEntityView(entityType: entityType, entity: entity)) {
                        EntityRowView(entityType: entityType, entity: entity)
                    }
                }
                .onDelete(perform: deleteEntity)
            }
            .searchable(text: $searchContext.query, prompt: "Search")
            .navigationTitle(entityType.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { ToolbarContent }
        }
        .onChange(of: searchContext.debouncedQuery) { handleSearchTextChange() }
        .task { await loadInitialEntities() }
    }
    
    private func handleSearchTextChange() {
        Task {
            if !searchContext.debouncedQuery.isEmpty && searchContext.debouncedQuery.count > 2 {
                entities = await loadEntities(entityType: entityType, sort: sortOrder, filter: searchContext.debouncedQuery)
            }
        }
    }
    
    private func loadInitialEntities() async {
        entities = await loadEntities(entityType: entityType, sort: sortOrder, filter: searchContext.debouncedQuery)
    }
    
    private func deleteEntity(_ indexSet: IndexSet) {
        for index    in indexSet {
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
                AddEntitySheet(entityType: entityType, onAdd: {entities.append($0) })
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
    ListEntitiesView(entityType: .creature)
}
