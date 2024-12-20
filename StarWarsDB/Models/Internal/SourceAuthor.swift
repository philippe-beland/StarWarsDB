//
//  SourceAuthor.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceAuthor: SourceItem {
    
    init(source: Source, entity: Artist, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourceAuthors", tableName: "source_authors")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceAuthor(source: .example, entity: .example, appearance: .mentioned),
        SourceAuthor(source: .example, entity: .example, appearance: .mentioned),
        SourceAuthor(source: .example, entity: .example, appearance: .mentioned)
    ]
}
