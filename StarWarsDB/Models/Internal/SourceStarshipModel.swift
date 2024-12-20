//
//  SourceStarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

@Observable
class SourceStarshipModel: SourceItem {
    
    init(source: Source, entity: StarshipModel, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourceStarshipModels", tableName: "source_starshipmodels")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceStarshipModel(source: .example, entity: .example, appearance: .mentioned)
    ]
}
