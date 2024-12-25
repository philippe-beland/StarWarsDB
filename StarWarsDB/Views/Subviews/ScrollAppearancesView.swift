//
//  ScrollAppearancesView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/15/24.
//

import SwiftUI

struct ScrollAppearancesView: View {
    let sourceItems: [SourceItem]
    let entityType: EntityType
    let layout = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)

    var body: some View {
            ScrollView(.horizontal) {
                LazyHGrid(rows: layout, spacing: 40) {
                    ForEach(sourceItems) { sourceItem in
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
        }
    }

#Preview {
    ScrollAppearancesView(sourceItems: SourceCharacter.example, entityType: .character)
}
