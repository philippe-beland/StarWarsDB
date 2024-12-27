//
//  ListEntitiesView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/17/24.
//

import SwiftUI

enum SortingItemOrder: String {
    case name = "name"
    case frequency = "number"
}

struct ListEntitiesView: View {
    var entityType: EntityType
    
    @State private var sortOrder: SortingItemOrder = .name
    @State private var searchText = ""
    @State private var showNewEntitySheet = false
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
            .searchable(text: $searchText, prompt: "Search")
            .navigationTitle(entityType.rawValue)
            .toolbar { ToolbarContent }
        }
        .onChange(of: searchText) { handleSearchTextChange() }
        .task { await loadInitialEntities() }
    }
    
    private func handleSearchTextChange() {
        Task {
            if !searchText.isEmpty && searchText.count > 3 {
                entities = await loadEntities(entityType: entityType, sort: sortOrder, filter: searchText)
            }
        }
    }
    
    private func loadInitialEntities() async {
        entities = await loadEntities(entityType: entityType, sort: sortOrder, filter: searchText)
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
                switch entityType {
                case .character: AddCharacterView() { entity in
                    entities.append(entity)}
                case .creature: AddCreatureView() { entity in
                    entities.append(entity)}
                case .droid: AddDroidView() { entity in
                    entities.append(entity)}
                case .organization: AddOrganizationView() { entity in
                    entities.append(entity)}
                case .planet: AddPlanetView() { entity in
                    entities.append(entity)}
                case .species: AddSpeciesView() { entity in
                    entities.append(entity)}
                case .starshipModel: AddStarshipModelView() { entity in
                    entities.append(entity)}
                case .starship: AddStarshipView() { entity in
                    entities.append(entity)}
                case .varia: AddVariaView() { entity in
                    entities.append(entity)}
                case .arc: AddArcView() { entity in
                    entities.append(entity)}
                case .serie: AddSerieView() { entity in
                    entities.append(entity)
                }
                }
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
