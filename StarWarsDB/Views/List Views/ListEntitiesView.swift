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
            .navigationBarTitleDisplayMode(.inline)
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

struct AddEntitySheet: View {
    var entityType: EntityType
    var onAdd: (Entity) -> Void
    
    var body: some View {
        switch entityType {
        case .character: AddCharacterView(name: "", onCharacterCreation: onAdd)
        case .creature: AddCreatureView(name: "", onCreatureCreation: onAdd)
        case .droid: AddDroidView(name: "", onDroidCreation: onAdd)
        case .organization: AddOrganizationView(name: "", onOrganizationCreation: onAdd)
        case .planet: AddPlanetView(name: "", onPlanetCreation: onAdd)
        case .species: AddSpeciesView(name: "", onSpeciesCreation: onAdd)
        case .starshipModel: AddStarshipModelView(name: "", onStarshipModelCreation: onAdd)
        case .starship: AddStarshipView(name: "", onStarshipCreation: onAdd)
        case .varia: AddVariaView(name: "", onVariaCreation: onAdd)
        case .arc: AddArcView(name: "", onArcCreation: onAdd)
        case .serie: AddSerieView(name: "", onSerieCreation: onAdd)
        case .artist: AddArtistView(name: "", onArtistCreation: onAdd)
        case .author: AddArtistView(name: "", onArtistCreation: onAdd)
        }
    }
}

#Preview {
    ListEntitiesView(entityType: .creature)
}
