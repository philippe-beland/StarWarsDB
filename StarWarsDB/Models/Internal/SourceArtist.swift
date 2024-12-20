//
//  SourceArtist.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceArtist: SourceItem {
    
    init(source: Source, entity: Artist, appearance: AppearanceType) {
        super.init(source: source, entity: entity, appearance: appearance, recordType: "SourceArtists", tableName: "source_artists")
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceArtist(source: .example, entity: .example, appearance: .mentioned),
        SourceArtist(source: .example, entity: .example, appearance: .mentioned)
    ]
}
