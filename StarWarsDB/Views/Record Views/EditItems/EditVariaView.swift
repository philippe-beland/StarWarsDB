//
//  EditVariaView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/22/24.
//

import SwiftUI

struct EditVariaView: View {
    @Bindable var varia: Varia
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceVarias = [SourceVaria]()
    
    var body: some View {
        NavigationStack {
                RecordContentView(record: varia, sourceItems: sourceVarias, InfosSection: InfosSection)
            }
        .task { await loadInitialSources() }
        }
        
    
    private var InfosSection: some View {
        Section("Infos") {
            FieldView(fieldName: "First Appearance", info: varia.firstAppearance ?? "")
        }
    }
    
    private func loadInitialSources() async {
        sourceVarias = await loadSourceVarias(recordField: "varia", recordID: varia.id.uuidString)
    }
}

#Preview {
    EditVariaView(varia: .example)
}
