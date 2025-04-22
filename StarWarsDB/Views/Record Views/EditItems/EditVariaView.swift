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
        .toolbar {
            Button ("Update", action: varia.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceVarias = await loadVariaSources(variaID: varia.id)
    }
}

#Preview {
    EditVariaView(varia: .example)
}
