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
    
    @State private var sourceStarshipModels = [SourceStarshipModel]()
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: starshipModel, sourceItems: sourceStarshipModels, InfosSection: StarshipModelInfoSection(starshipModel: starshipModel))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: starshipModel.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceStarshipModels = await loadStarshipModelSources(starshipModelID: starshipModel.id)
    }
}

#Preview {
    EditStarshipModelView(starshipModel: .example)
}
