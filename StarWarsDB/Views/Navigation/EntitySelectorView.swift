import SwiftUI

struct EntityPickerList<T: BaseEntity>: View {
    // MARK: - Configuration
    var allowMultiSelection: Bool = false
    var serie: Serie? = nil
    var excludedEntityIDs: Set<UUID> = []
    
    @Binding var selectedEntities: Set<T>
    var onFinish: (_ selected: Set<T>) -> Void
    
    // MARK: - State
    @State private var availableEntities: [T] = []
    @State private var showNewEntitySheet: Bool = false
    
    @StateObject var searchContext = SearchContext()

    // MARK: - Computed
    private var filteredEntities: [T] {
        let filtered = availableEntities.filter { !excludedEntityIDs.contains($0.id) }
        
        if searchContext.query.count < 3 {
            return filtered
        }
        else {
            return filtered.map {entity in
                var updated = entity
                if excludedEntityIDs.contains(entity.id) {
                    updated.alreadyInSource = true
                }
                return updated
            }
        }
    }

    // MARK: - View
    var body: some View {
        VStack {
            TextField("Search", text: $searchContext.query)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, Constants.Spacing.md)
            
            List(filteredEntities, id: \.self, selection: $selectedEntities) { entity in
                EntityRowView(entity: entity)
            }
            .navigationTitle(T.displayName)
            .toolbar { ToolbarContent }
            
            Button("Done") {
                onFinish(selectedEntities)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .onChange(of: searchContext.debouncedQuery)  { handleSearchTextChange() }
        .task { await loadInitialEntities() }
        .sheet(isPresented: $showNewEntitySheet) {
            addEntitySheet()
        }
    }

    // MARK: - Data Loading
    private func handleSearchTextChange() {
        Task {
            if searchContext.debouncedQuery.isEmpty || searchContext.debouncedQuery.count >= Constants.Search.minSearchLength {
                availableEntities = await loadEntities(serie: serie, filter: searchContext.debouncedQuery)
            }
        }
    }
    
    private func loadInitialEntities() async {
        availableEntities = await loadEntities(serie: serie, filter: searchContext.debouncedQuery)
    }

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var ToolbarContent: some ToolbarContent {
        if allowMultiSelection {
            ToolbarItem(placement: .navigationBarLeading) {
                EditButton()
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Create", systemImage: "plus") {
                showNewEntitySheet.toggle()
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

// MARK: - BaseEntity Selector Wrapper
struct BaseEntitySelectorView<T: BaseEntity>: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    @State private var selectedEntities = Set<T>()

    var onSelect: (T) -> Void

    var body: some View {
        NavigationStack {
            VStack {
                EntityPickerList(
                    selectedEntities: $selectedEntities,
                    onFinish: { entity in
                        if let first = entity.first {
                            onSelect(first)
                            dismiss()
                        }
                    }
                )
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

// MARK: - Entity Selector Wrapper
struct EntitySelectorView<T: TrackableEntity>: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    var serie: Serie?
    let sourceEntities: [SourceEntity<T>]
    
    @State private var selectedAppearanceType: AppearanceType = .present
    @State private var selectedEntities = Set<T>()
    
    var onSelect: (_ selected: Set<T>, _ appearance: AppearanceType) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                AppearancePickerView(appearance: $selectedAppearanceType)
                
                EntityPickerList(
                    allowMultiSelection: true,
                    serie: serie,
                    excludedEntityIDs: Set(sourceEntities.map { $0.entity.id }),
                    selectedEntities: $selectedEntities,
                    onFinish: { selected in
                        onSelect(selected, selectedAppearanceType)
                        dismiss()
                    }
                )
            }
        }
    }
}

// MARK: - Creator Selector Wrapper
struct CreatorSelectorView<T: CreatorEntity>: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    var serie: Serie?
    let sourceCreators: [SourceCreator<T>]
    
    @State private var selectedCreators = Set<T>()
    
    var onSelect: (_ selected: Set<T>) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                EntityPickerList(
                    allowMultiSelection: true,
                    serie: serie,
                    excludedEntityIDs: Set(sourceCreators.map { $0.creator.id }),
                    selectedEntities: $selectedCreators,
                    onFinish: { selected in
                        onSelect(selected)
                        dismiss()
                    }
                )
            }
        }
    }
}

// MARK: - Preview
//#Preview {
//    let sourceEntities: SourceEntity<Character> = SourceEntity(source: .example, entity: Character.example, appearance: .present)
//    EntitySelectorView<Character>(isSourceEntity: false, sourceEntities: sourceEntities.examples, onEntitySelect: { _, _ in })
//}
