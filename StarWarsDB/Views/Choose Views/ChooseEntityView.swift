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
    var isSourceItem: Bool
    
    @State private var searchText = ""
    @State private var appearanceType: AppearanceType = .present
    @State private var showNewEntitySheet = false
    @State private var entities = [Entity]()
    @State private var selectedEntities = Set<Entity>()
    
    var onEntitySelect: (Set<Entity>, AppearanceType) -> Void
    
    var body: some View {
        VStack {
            NavigationStack {
                AppearancePickerView(appearance: $appearanceType)
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                List(entities, id: \.self, selection: $selectedEntities) { entity in
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
        if isSourceItem {
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
                case .character: AddCharacterView(name: searchText) { entity in
                    entities.append(entity)}
                case .creature: AddCreatureView(name: searchText) { entity in
                    entities.append(entity)}
                case .droid: AddDroidView(name: searchText) { entity in
                    entities.append(entity)}
                case .organization: AddOrganizationView(name: searchText) { entity in
                    entities.append(entity)}
                case .planet: AddPlanetView(name: searchText) { entity in
                    entities.append(entity)}
                case .species: AddSpeciesView(name: searchText) { entity in
                    entities.append(entity)}
                case .starshipModel: AddStarshipModelView(name: searchText) { entity in
                    entities.append(entity)}
                case .starship: AddStarshipView(name: searchText) { entity in
                    entities.append(entity)}
                case .varia: AddVariaView(name: searchText) { entity in
                    entities.append(entity)}
                case .serie: AddSerieView(name: searchText) { entity in
                    entities.append(entity)}
                case .arc: AddArcView(name: searchText) { entity in
                    entities.append(entity)}
                case .artist: AddArtistView(name: searchText) { entity in
                    entities.append(entity)}
                case .author: AddArtistView(name: searchText) { entity in
                    entities.append(entity)
                }
                }
            }
        }
    }
}
