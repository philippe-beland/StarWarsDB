import Foundation
import SwiftUI

struct EditEntityInfoView: View {
    var fieldName: String
    @Binding var entity: Entity
    var entityType: EntityType
    
    @State private var showEntitySelection = false
    
    var body: some View {
        HStack {
            Text("\(fieldName):")
                .font(.footnote)
                .bold()
            Spacer()
            Button {
                showEntitySelection.toggle()
            } label: {
                if entity.name.isEmpty {
                    Text("Select \(fieldName)")
                        .foregroundColor(.blue)
                }
                Text(entity.name)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .sheet(isPresented: $showEntitySelection) {
            ChooseEntityView(entityType: entityType, isSourceEntity: false, sourceEntities: []) { selectedEntities, appearance in
                if let selectedEntity = selectedEntities.first {
                    entity = selectedEntity
                }
            }
        }
    }
}

struct EditVEntityInfoView: View {
    var fieldName: String
    @Binding var entity: Entity
    var entityType: EntityType
    
    @State private var showEntitySelection: Bool = false
    
    var body: some View {
            Button {
                showEntitySelection.toggle()
            } label: {
                if entity.name.isEmpty {
                    Text("Select \(fieldName)")
                        .foregroundStyle(.secondary)
                } else {
                    Text(entity.name)
                }
            }
            .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showEntitySelection) {
            ChooseEntityView(entityType: entityType, isSourceEntity: false, sourceEntities: []) { selectedEntities, _ in
                guard let selectedEntity = selectedEntities.first else { return }
                entity = selectedEntity
            }
        }
    }
}


