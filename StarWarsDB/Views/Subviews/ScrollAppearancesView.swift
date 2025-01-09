//
//  ScrollAppearancesView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/15/24.
//

import SwiftUI

struct ScrollAppearancesView<T: SourceItem>: View {
    @Binding var sourceItems: [T]
    
    let entityType: EntityType
    let layout = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    
    private var sortedEntities: [SourceItem] {
        sourceItems.sorted(by: { $0.entity.name < $1.entity.name })
    }

    var body: some View {
            ScrollView(.horizontal) {
                LazyHGrid(rows: layout, spacing: 40) {
                    ForEach(sortedEntities) { sourceItem in
                        NavigationLink(destination: EditEntityView(entityType: entityType, entity: sourceItem.entity)) {
                            RecordEntryView(
                                name: sourceItem.entity.name ,
                                imageName: sourceItem.entity.id,
                                appearance: sourceItem.appearance)
                        }
                        .contextMenu {
                            Button("Delete", role: .destructive, action: {deleteEntity(sourceItem)})
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    
    private func deleteEntity(_ entity: SourceItem) {
        if let index = sourceItems.firstIndex(of: entity as! T) {
            sourceItems.remove(at: index)
        }
        entity.delete()
    }
}

//#Preview {
//    ScrollAppearancesView(sourceItems: $SourceCharacter.example, entityType: .character)
//}
