//
//  SourceOrganization.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceOrganization: SourceItem {
    
    enum CodingKeys: String, CodingKey {
        case id
        case source
        case entity
        case appearance
    }
    
    init(source: Source, entity: Organization, appearance: AppearanceType) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceOrganizations", tableName: "source_organizations")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Artist.self, forKey: .entity)
        let appearance = try container.decode(AppearanceType.self, forKey: .appearance)
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceOrganizations", tableName: "source_organizations")
    }
    
    static let example = [
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
        SourceOrganization(source: .example, entity: .example, appearance: .mentioned),
    ]
}
