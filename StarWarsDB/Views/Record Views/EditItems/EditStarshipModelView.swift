//
//  EditStarshipModelView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import SwiftUI

struct EditStarshipModelView: View {
    @Bindable var starshipModel: StarshipModel
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceStarshipModels: [SourceStarshipModel] = SourceStarshipModel.example
    
    var body: some View {
        NavigationStack {
                RecordContentView(record: starshipModel, sourceItems: sourceStarshipModels, InfosSection: InfosSection)
            }
        }
    private var InfosSection: some View {
        Section("Infos") {
            FieldView(fieldName: "First Appearance", info: starshipModel.firstAppearance ?? "")
        }
    }
}

#Preview {
    EditStarshipModelView(starshipModel: .example)
}
