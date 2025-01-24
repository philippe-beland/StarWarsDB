//
//  SourceArtist.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Tracks the creative contributors to Star Wars media sources
///
/// SourceArtist specializes SourceItem for tracking the relationship between
/// sources and their creators. Unlike other source items that track appearances
/// of in-universe elements, this tracks the real-world artists who created
/// the content, such as writers, illustrators, directors, etc.
@Observable
class SourceArtist: SourceItem {
    
    /// Keys used for encoding and decoding source artist data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Artist being referenced (named "artist" in JSON)
        case entity = "artist"
    }
    
    /// Creates a new source-artist relationship
    /// - Parameters:
    ///   - source: The source material that was created
    ///   - entity: The artist who contributed to the source
    init(source: Source, entity: Artist) {
        let id = UUID()
        // Artists are always "present" in their works
        super.init(id: id, source: source, entity: entity, appearance: .present, recordType: "SourceArtists", tableName: "source_artists")
    }
    
    /// Creates a source-artist relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Artist.self, forKey: .entity)
        
        // Artists are always "present" in their works
        super.init(id: id, source: source, entity: entity, appearance: .present, recordType: "SourceArtists", tableName: "source_artists")
    }
    
    /// Encodes the source-artist relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
    }
    
    /// Example source-artist relationships for previews and testing
    ///
    /// Shows how multiple artists might be credited for a single source,
    /// such as a writer and illustrator for a comic book.
    static let example = [
        SourceArtist(source: .example, entity: .example),
        SourceArtist(source: .example, entity: .example)
    ]
}
