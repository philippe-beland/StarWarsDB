//
//  RecordContentView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct RecordContentView<Content: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var record: Entity
    var sourceItems: [SourceItem]
    var InfosSection: Content
    
    var body: some View {
        VStack {
            HeaderView(name: record.name, urlString: record.url)
            
            if horizontalSizeClass == .regular {
                HStack {
                    SidePanelView(record: record, InfosSection: InfosSection)
                        .frame(width: 350)
                    Spacer()
                    SourcesSection(sourceItems: sourceItems)
                }
            } else {
                VStack {
                    SidePanelView(record: record, InfosSection: InfosSection)
                    Spacer()
                    SourcesSection(sourceItems: sourceItems)
                }
            }
        }
    }
}

#Preview {
    RecordContentView(record: Character.example, sourceItems: SourceCharacter.example, InfosSection: Text(Character.example.name))
}
