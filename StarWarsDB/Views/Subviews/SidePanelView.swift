//
//  SidePanelView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct SidePanelView<RecordType: Record, Content: View>: View {
    var record: RecordType
    var InfosSection: Content
    
    var body: some View {
        Form {
            ImageView(title: record.name)
            InfosSection
            CommentsView(comments: record.comments)
        }
    }
}

#Preview {
    SidePanelView(record: Character.example, InfosSection: Text(Character.example.name))
}
