import SwiftUI

struct EntitySelectorView<T: Entity>: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    var isSourceEntity: Bool
    var serie: Serie?
    let sourceEntities: [SourceEntity<T>]
    
    @StateObject var searchContext = SearchContext()
    @State private var appearanceType: AppearanceType = .present
    @State private var showNewEntitySheet: Bool = false
    @State private var entities: [T] = []
    @State private var selectedEntities = Set<T>()
    
    var existingEntities: Set<T> {
        Set(sourceEntities.map { $0.entity })
    }
    var filteredEntities: [T] {
        let existingSet = Set(existingEntities.map { $0.id })
        
        if searchContext.query.count < 3 {
            return entities.filter { !existingEntities.contains($0) }
        }
        else {
            return entities.map {entity in
                var newEntity = entity
                if existingSet.contains(entity.id) {
                    newEntity.alreadyInSource = true
                }
                return newEntity
            }
        }
    }
    
    var onEntitySelect: (Set<T>, AppearanceType) -> Void
    
    var body: some View {
        VStack {
            NavigationStack {
                AppearancePickerView(appearance: $appearanceType)
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
                onEntitySelect(selectedEntities, appearanceType)
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
                entities = await loadEntities(serie: serie, sort: .name, filter: searchContext.debouncedQuery)
            }
        }
    }
    
    private func loadInitialEntities() async {
        entities = await loadEntities(serie: serie, sort: .name, filter: searchContext.debouncedQuery)
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
                entities.append(entity as! T)
            }
        case is Creature.Type:
            AddCreatureView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
            }
        case is Droid.Type:
            AddDroidView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
            }
        case is Organization.Type:
            AddOrganizationView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
            }
        case is Planet.Type:
            AddPlanetView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
            }
        case is Species.Type:
            AddSpeciesView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
            }
        case is StarshipModel.Type:
            AddStarshipModelView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
            }
        case is Starship.Type:
            AddStarshipView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
            }
        case is Varia.Type:
            AddVariaView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
            }
        case is Serie.Type:
            AddSerieView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
            }
        case is Arc.Type:
            AddArcView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
            }
        case is Artist.Type:
            AddArtistView(name: searchContext.debouncedQuery) { entity in
                entities.append(entity as! T)
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
