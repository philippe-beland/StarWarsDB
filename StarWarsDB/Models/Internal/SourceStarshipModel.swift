//
//  SourceStarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

@Observable
class SourceStarshipModel: SourceItem {
    
    enum CodingKeys: String, CodingKey {
        case id
        case source
        case entity
        case appearance
    }
    
    init(source: Source, entity: StarshipModel, appearance: AppearanceType) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceStarshipModels", tableName: "source_starshipmodels")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Artist.self, forKey: .entity)
        let appearance = try container.decode(AppearanceType.self, forKey: .appearance)
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceStarshipModels", tableName: "source_starshipmodels")
    }
    
    static let example = [
        SourceStarshipModel(source: .example, entity: .example, appearance: .mentioned)
    ]
}
