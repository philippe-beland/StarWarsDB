//
//  ListEntitiesView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/17/24.
//

import SwiftUI

struct ListEntitiesView: View {
    var entityType: EntityType
    
    @State private var sortOrder: String = "name"
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
                AddEntityView(entityType: entityType) { entity in
                    entities.append(entity)}
            }
        }
    }
}

#Preview {
    ListEntitiesView(entityType: .creature)
}
