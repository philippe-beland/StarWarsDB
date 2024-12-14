//
//  SourceStarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

@Observable
class SourceStarshipModel: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var starshipModel: StarshipModel
    var appearance: AppearanceType
    
    init(source: Source, starshipModel: StarshipModel, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.starshipModel = starshipModel
        self.appearance = appearance
        
        super.init(recordType: "SourceStarshipModels", tableName: "source_starshipModels", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = SourceStarshipModel(source: .example, starshipModel: .example, appearance: .mentioned)
    
    static func == (lhs: SourceStarshipModel, rhs: SourceStarshipModel) -> Bool {
        lhs.source == rhs.source && lhs.starshipModel == rhs.starshipModel
    }
}
