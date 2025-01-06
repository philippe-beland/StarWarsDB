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
            RecordContentView(record: varia, sourceItems: sourceVarias, InfosSection: VariaInfoSection(varia: varia))
            }
        .task { await loadInitialSources() }
        }
    
    private func loadInitialSources() async {
        sourceVarias = await loadSourceVarias(recordField: "varia", recordID: varia.id.uuidString)
    }
}

#Preview {
    EditVariaView(varia: .example)
}
