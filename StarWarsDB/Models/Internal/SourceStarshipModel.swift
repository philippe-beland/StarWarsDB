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
    var entity: StarshipModel
    var appearance: AppearanceType
    
    init(source: Source, entity: StarshipModel, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.entity = entity
        self.appearance = appearance
        
        super.init(recordType: "SourceStarshipModels", tableName: "source_starshipModels", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceStarshipModel(source: .example, entity: .example, appearance: .mentioned)
    ]
    
    static func == (lhs: SourceStarshipModel, rhs: SourceStarshipModel) -> Bool {
        lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
