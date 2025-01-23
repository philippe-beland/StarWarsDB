//
//  EditDroidView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct EditDroidView: View {
    @Bindable var droid: Droid
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceDroids = [SourceDroid]()
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: droid, sourceItems: sourceDroids, InfosSection: DroidInfoSection(droid: droid))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: droid.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceDroids = await loadSourceDroids(recordField: "droid", recordID: droid.id)
    }
}

#Preview {
    EditDroidView(droid: .example)
}
