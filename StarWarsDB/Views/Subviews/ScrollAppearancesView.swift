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
    let layout = Array(repeating: GridItem(.flexible(), spacing: 24), count: 3)
    
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
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.vertical)
        }
}

//#Preview {
//    ScrollAppearancesView(sourceItems: $SourceCharacter.example, entityType: .character)
//}
