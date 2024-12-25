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
        case entity = "starship_model"
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
        let entity = try container.decode(StarshipModel.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceStarshipModels", tableName: "source_starshipmodels")
    }
    
    static let example = [
        SourceStarshipModel(source: .example, entity: .example, appearance: .mentioned)
    ]
}
