//
//  ChooseEntitiesView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/18/24.
//

import SwiftUI

struct ChooseEntitiesView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    var entityType: EntityType
    
    @State private var searchText: String = ""
    @State private var showNewEntitySheet: Bool = false
    @State private var appearanceType: AppearanceType = .present
    @State private var entities = [Entity]()
    @State private var selectedEntities = Set<Entity>()
    
    var onEntitiesSelect: (Set<Entity>, AppearanceType) -> Void
    
    var body: some View {
        VStack {
            AppearancePickerView(appearance: $appearanceType)
            
            NavigationStack {
                List(entities, id: \.self, selection: $selectedEntities) { entity in
                    EntityRowView(entityType: entityType, entity: entity )
                }
                .searchable(text: $searchText, prompt: "Search")
                .navigationTitle(entityType.rawValue)
                .toolbar{ ToolbarContent }
            }
            Button("Done") {
                onEntitiesSelect(selectedEntities, appearanceType)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .onChange(of: searchText) { handleSearchTextChange() }
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
        entities = await loadEntities(entityType: entityType, sort: .name)
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

//#Preview {
//    ChooseEntitiesView(entityType: .character)
//}
