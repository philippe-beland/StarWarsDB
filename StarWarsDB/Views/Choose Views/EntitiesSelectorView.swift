import SwiftUI

struct EntitiesSelectorView<T: Entity>: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @StateObject var searchContext = SearchContext()
    @State private var showNewEntitySheet: Bool = false
    @State private var appearanceType: AppearanceType = .present
    @State private var entities = [T]()
    @State private var selectedEntities = Set<T>()
    
    var onEntitiesSelect: (Set<T>, AppearanceType) -> Void
    
    var body: some View {
        VStack {
            AppearancePickerView(appearance: $appearanceType)
            
            NavigationStack {
                List(entities, id: \.self, selection: $selectedEntities) { entity in
                    EntityRowView<T>(entity: entity )
                }
                .searchable(text: $searchContext.query, prompt: "Search")
                .navigationTitle(T.displayName)
                .toolbar{ ToolbarContent }
            }
            Button("Done") {
                onEntitiesSelect(selectedEntities, appearanceType)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .onChange(of: searchContext.debouncedQuery) { handleSearchTextChange() }
        .task { await loadInitialEntities() }
    }
    
        private func handleSearchTextChange() {
            Task {
                if !searchContext.debouncedQuery.isEmpty && searchContext.debouncedQuery.count >= Constants.Search.minSearchLength {
                    entities = await loadEntities(serie: nil, sort: .name, filter: searchContext.debouncedQuery)
                }
            }
        }
    
    private func loadInitialEntities() async {
        entities = await loadEntities(serie: nil, sort: .name, filter: "")
    }
    
    @ToolbarContentBuilder
    private var ToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            EditButton()
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button ("Create") {
                showNewEntitySheet.toggle()
            }
//            .sheet(isPresented: $showNewEntitySheet)  {
//                AddEntityView(entityType: entityType) { selectedEntity in
//                    onEntitiesSelect(selectedEntities, appearanceType)
//                    dismiss()
//                }
//            }
        }
    }
}

#Preview {
    EntitiesSelectorView<Character>(onEntitiesSelect: { _, _ in })
}
