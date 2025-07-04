import SwiftUI

struct ChooseEntityView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    var entityType: EntityType
    var isSourceEntity: Bool
    var serie: Serie?
    let sourceEntities: [SourceEntity]
    
    @StateObject var searchContext = SearchContext()
    @State private var appearanceType: AppearanceType = .present
    @State private var showNewEntitySheet: Bool = false
    @State private var entities = [Entity]()
    @State private var selectedEntities = Set<Entity>()
    
    var existingEntities: Set<Entity> {
        Set(sourceEntities.map { $0.entity })
    }
    var filteredEntities: [Entity] {
        let existingSet = Set(existingEntities.map { $0.id })
        
        if searchContext.query.count < 3 {
            return entities.filter { !existingEntities.contains($0) }
        }
        else {
            return entities.map {entity in
                let newEntity = entity
                if existingSet.contains(entity.id) {
                    newEntity.isExisting = true
                }
                return newEntity
            }
        }
    }
    
    var onEntitySelect: (Set<Entity>, AppearanceType) -> Void
    
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
                    EntityRowView(entityType: entityType, entity: entity)
                }
                .navigationTitle(entityType.rawValue)
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
                entities = await loadEntities(serie: serie, entityType: entityType, sort: .name, filter: searchContext.debouncedQuery)
            }
        }
    }
    
    private func loadInitialEntities() async {
        entities = await loadEntities(serie: serie, entityType: entityType, sort: .name, filter: searchContext.debouncedQuery)
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
                switch entityType {
                    case .character: AddCharacterView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .creature: AddCreatureView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .droid: AddDroidView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .organization: AddOrganizationView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .planet: AddPlanetView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .species: AddSpeciesView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .starshipModel: AddStarshipModelView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .starship: AddStarshipView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .varia: AddVariaView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .serie: AddSerieView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .arc: AddArcView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .artist: AddArtistView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)}
                    case .author: AddArtistView(name: searchContext.debouncedQuery) { entity in
                        entities.append(entity)
                    }
                }
            }
        }
    }
}

#Preview {
    ChooseEntityView(entityType: .character, isSourceEntity: false, sourceEntities: SourceCharacter.example, onEntitySelect: <#(Set<Entity>, AppearanceType) -> Void#>)
}
