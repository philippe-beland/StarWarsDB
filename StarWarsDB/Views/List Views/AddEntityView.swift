//
//  AddEntityView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/18/24.
//

import SwiftUI

struct AddEntityView: View {
    @Environment(\.dismiss) var dismiss
    
    var entityType: EntityType
    
    //@State var properties
    
    var onEntityCreation: (Entity) -> Void
    
    var body: some View {
        NavigationStack{
            Form {
                Section("Infos") {
                    
                }
                
                Section {
                    Button("Save", action: saveEntity)
                        //.disabled(name.isEmpty)
                }
            }
        }
        .navigationTitle("Add new \(entityType.rawValue)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveEntity() {
        //let newEntity = Entity(properties)
        //newEntity.save()
        //onEntityCreation(newEntity)
        dismiss()
    }
}

//#Preview {
//    AddEntityView()
//}
