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
    
    @State private var sourceDroids: [SourceDroid] = [.example, .example, .example]
    
    var body: some View {
        NavigationStack {
                RecordContentView(record: droid, sourceItems: sourceDroids, InfosSection: InfosSection)
            }
        }
    private var InfosSection: some View {
        Section("Infos") {
            FieldView(fieldName: "First Appearance", info: droid.firstAppearance ?? "")
        }
    }
}

#Preview {
    EditDroidView(droid: .example)
}
