//
//  ChooseEntityView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct ChooseEntityView: View {
    @Environment(\.dismiss) var dismiss
    var entityType: EntityType
    
    @State private var searchText = ""
    @State private var appearanceType: AppearanceType = .present
    @State private var showNewEntitySheet = false
    @State private var entities = [Entity]()
    @State private var selectedEntities = Set<Entity>()
    
    var onEntitySelect: (Set<Entity>, AppearanceType) -> Void
    
    var body: some View {
        VStack {
            AppearancePickerView(appearance: $appearanceType)
            
            NavigationStack {
                List(entities, id: \.self, selection: $selectedEntities) { entity in
                    EntityRowView(entityType: entityType, entity: entity)
                }
                .searchable(text: $searchText, prompt: "Search")
                .navigationTitle(entityType.rawValue)
                .toolbar { ToolbarContent }
            }
            Button("Done") {
                onEntitySelect(selectedEntities, appearanceType)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .onChange(of: searchText)  { handleSearchTextChange() }
        .task { await loadInitialEntities() }
    }
    
    private func handleSearchTextChange() {
        Task {
            if !searchText.isEmpty && searchText.count > 3 {
                entities = await loadEntities(entityType: entityType, sort: .name, filter: searchText)
            }
        }
    }
    
    private func loadInitialEntities() async {
        entities = await loadEntities(entityType: entityType, sort: .name, filter: searchText)
    }
    
    
    @ToolbarContentBuilder
    private var ToolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            EditButton()
        }
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
                }
            }
        }
    }
}
