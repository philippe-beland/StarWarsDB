//
//  RecordContentView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct RecordContentView<Content: View>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Bindable var record: Entity
    
    var sourceItems: [SourceItem]
    var InfosSection: Content
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(name: $record.name, url: record.url)
            
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

//#Preview {
//    RecordContentView(record: Character.example, sourceItems: SourceCharacter.example, InfosSection: Text(Character.example.name))
//}
