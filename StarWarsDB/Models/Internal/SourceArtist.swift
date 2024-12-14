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
    var artist: Artist
    var appearance: AppearanceType
    
    init(source: Source, artist: Artist, appearance: AppearanceType) {
        self.id = UUID()
        self.source = source
        self.artist = artist
        self.appearance = appearance
        
        super.init(recordType: "SourceArtists", tableName: "source_artists", recordID: self.id)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    static let example = SourceArtist(source: .example, artist: .example, appearance: .mentioned)
    
    static func == (lhs: SourceArtist, rhs: SourceArtist) -> Bool {
        lhs.source == rhs.source && lhs.artist == rhs.artist
    }
}
