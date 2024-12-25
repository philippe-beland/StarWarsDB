//
//  SourceArtist.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceArtist: SourceItem {
    
    enum CodingKeys: String, CodingKey {
        case id
        case source
        case entity = "artist"
        case appearance
    }
    
    init(source: Source, entity: Artist, appearance: AppearanceType) {
        let id = UUID()
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceArtists", tableName: "source_artists")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Artist.self, forKey: .entity)
        let _appearance = try container.decode(Int.self, forKey: .appearance)
        
        let appearance = AppearanceType(rawValue: _appearance.description) ?? .present
        
        super.init(id: id, source: source, entity: entity, appearance: appearance, recordType: "SourceArtists", tableName: "source_artists")
    }
    
    static let example = [
        SourceArtist(source: .example, entity: .example, appearance: .mentioned),
        SourceArtist(source: .example, entity: .example, appearance: .mentioned)
    ]
}
