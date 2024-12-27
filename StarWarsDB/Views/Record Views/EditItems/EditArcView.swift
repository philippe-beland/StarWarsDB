//
//  EditArcView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/26/24.
//

import SwiftUI

struct EditArcView: View {
    @Bindable var arc: Arc
    @Environment(\.dismiss) var dismiss
    
    @State private var sources = [SourceItem]()
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: arc, sourceItems: sources, InfosSection: ArcInfoSection(arc: arc))
        }
    }
}

#Preview {
    EditArcView(arc: .example)
}
