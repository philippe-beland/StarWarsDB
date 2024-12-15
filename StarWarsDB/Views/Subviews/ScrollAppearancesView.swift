//
//  ScrollAppearancesView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/15/24.
//

import SwiftUI

struct ScrollAppearancesView: View {
    let sourceItems: [any SourceItem]
    let layout = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)

    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout, spacing: 40) {
                ForEach(sourceItems, id: \.id) { sourceItem in
                    RecordEntryView(
                        name: sourceItem.entity.name ,
                        imageName: sourceItem.entity.name.replacingOccurrences(of: " ", with: "_"),
                        appearance: sourceItem.appearance)
                }
            }
        }
    }
}

#Preview {
    ScrollAppearancesView(sourceItems: SourceCharacter.example)
}
