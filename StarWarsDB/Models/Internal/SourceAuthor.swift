//
//  SourceAuthor.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceAuthor: SourceItem {
    
    enum CodingKeys: String, CodingKey {
        case id
        case source
        case entity = "artist"
    }
    
    init(source: Source, entity: Artist) {
        let id = UUID()
        
        super.init(id: id, source: source, entity: entity, appearance: .present, recordType: "SourceAuthors", tableName: "source_authors")
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Artist.self, forKey: .entity)
        
        super.init(id: id, source: source, entity: entity, appearance: .present, recordType: "SourceAuthors", tableName: "source_authors")
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
    }
    
    static let example = [
        SourceAuthor(source: .example, entity: .example),
        SourceAuthor(source: .example, entity: .example),
        SourceAuthor(source: .example, entity: .example)
    ]
}
