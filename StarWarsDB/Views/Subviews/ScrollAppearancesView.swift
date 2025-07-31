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
    let layout = [GridItem(.adaptive(minimum: 225), spacing: 24)]
    
    private var sortedEntities: [SourceItem] {
        sourceItems.sorted(by: { $0.entity.name < $1.entity.name })
    }

    var body: some View {
            ScrollView(.vertical) {
                LazyVGrid (columns: layout, spacing: 40) {
                    ForEach(sortedEntities) { sourceItem in
                        NavigationLink(destination: EditEntityView(entityType: entityType, entity: sourceItem.entity)) {
                            RecordEntryView(sourceItem: sourceItem)
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
