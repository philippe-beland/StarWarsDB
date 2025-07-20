import SwiftUI

struct EntitySelectorView<T: Entity>: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    var isSourceEntity: Bool
    var serie: Serie?
    let sourceEntities: [SourceEntity<T>]
    
    @StateObject var searchContext = SearchContext()
    @State private var selectedAppearanceType: AppearanceType = .present
    @State private var showNewEntitySheet: Bool = false
    @State private var availableEntities: [T] = []
    @State private var selectedEntities = Set<T>()
    
    var existingEntities: Set<T> {
        Set(sourceEntities.map { $0.entity })
    }
    var filteredEntities: [T] {
        let existingEntityIds = Set(existingEntities.map { $0.id })
        
        if searchContext.query.count < 3 {
            return availableEntities.filter { !existingEntities.contains($0) }
        }
        else {
            return availableEntities.map {entity in
                var updatedEntity = entity
                if existingEntityIds.contains(entity.id) {
                    updatedEntity.alreadyInSource = true
                }
                return updatedEntity
            }
        }
    }
    
    var onEntitySelect: (Set<T>, AppearanceType) -> Void
    
    var body: some View {
        VStack {
            NavigationStack {
                AppearancePickerView(appearance: $selectedAppearanceType)
                TextField("Search", text: $searchContext.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                List(filteredEntities, id: \.self, selection: $selectedEntities) { entity in
                    EntityRowView<T>(entity: entity)
                }
                .navigationTitle(T.displayName)
                .toolbar { ToolbarContent }
            }
            Button("Done") {
                onEntitySelect(selectedEntities, selectedAppearanceType)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .onChange(of: searchContext.debouncedQuery)  { handleSearchTextChange() }
        .task { await loadInitialEntities() }
    }
    
    private func handleSearchTextChange() {
        Task {
            if searchContext.debouncedQuery.isEmpty || searchContext.debouncedQuery.count >= Constants.Search.minSearchLength {
                availableEntities = await loadEntities(serie: serie, sort: .name, filter: searchContext.debouncedQuery)
            }
        }
    }
    
    private func loadInitialEntities() async {
        availableEntities = await loadEntities(serie: serie, sort: .name, filter: searchContext.debouncedQuery)
    }
    
    
    @ToolbarContentBuilder
    private var ToolbarContent: some ToolbarContent {
        if isSourceEntity {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Create", systemImage: "plus") {
                showNewEntitySheet.toggle()
            }
            .sheet(isPresented: $showNewEntitySheet) {
                addEntitySheet()
            }
        }
    }

    @ViewBuilder
    private func addEntitySheet() -> some View {
        switch T.self {
        case is Character.Type:
            AddCharacterView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is Creature.Type:
            AddCreatureView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is Droid.Type:
            AddDroidView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is Organization.Type:
            AddOrganizationView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is Planet.Type:
            AddPlanetView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is Species.Type:
            AddSpeciesView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is StarshipModel.Type:
            AddStarshipModelView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is Starship.Type:
            AddStarshipView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is Varia.Type:
            AddVariaView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is Serie.Type:
            AddSerieView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is Arc.Type:
            AddArcView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        case is Artist.Type:
            AddArtistView(name: searchContext.debouncedQuery) { entity in
                availableEntities.append(entity as! T)
            }
        default:
            Text("Unsupported entity type")
        }
    }
}

//#Preview {
//    let sourceEntities: SourceEntity<Character> = SourceEntity(source: .example, entity: Character.example, appearance: .present)
//    EntitySelectorView<Character>(isSourceEntity: false, sourceEntities: sourceEntities.examples, onEntitySelect: { _, _ in })
//}
