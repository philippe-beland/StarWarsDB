//
//  SourceArtist.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

@Observable
class SourceArtist: DataNode, Equatable, Identifiable, SourceItem {
    let id: UUID
    var source: Source
    var entity: Artist
    var appearance: AppearanceType
    
    init(source: Source, entity: Artist, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.entity = entity
        self.appearance = appearance
        
        super.init(recordType: "SourceArtists", tableName: "source_artists", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = [
        SourceArtist(source: .example, entity: .example, appearance: .mentioned),
        SourceArtist(source: .example, entity: .example, appearance: .mentioned)
    ]
    
    static func == (lhs: SourceArtist, rhs: SourceArtist) -> Bool {
        lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
