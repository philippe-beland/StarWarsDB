//
//  SourceAuthor.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Tracks the primary writers/authors of Star Wars media sources
///
/// SourceAuthor specializes SourceItem for tracking the relationship between
/// sources and their primary writers. While SourceArtist covers various creative
/// roles, SourceAuthor specifically tracks the writers who crafted the story,
/// such as novelists, screenwriters, and comic book writers.
@Observable
class SourceAuthor: SourceItem {
    
    /// Keys used for encoding and decoding source author data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Source material reference
        case source
        /// Author being referenced (named "artist" in JSON)
        case entity = "artist"
    }
    
    /// Creates a new source-author relationship
    /// - Parameters:
    ///   - source: The source material that was written
    ///   - entity: The author who wrote the source
    init(source: Source, entity: Artist) {
        let id = UUID()
        
        // Authors are always "present" in their works
        super.init(id: id, source: source, entity: entity, appearance: .present, recordType: "SourceAuthors", tableName: "source_authors")
    }
    
    /// Creates a source-author relationship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let source = try container.decode(Source.self, forKey: .source)
        let entity = try container.decode(Artist.self, forKey: .entity)
        
        // Authors are always "present" in their works
        super.init(id: id, source: source, entity: entity, appearance: .present, recordType: "SourceAuthors", tableName: "source_authors")
    }
    
    /// Encodes the source-author relationship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
    }
    
    /// Example source-author relationships for previews and testing
    ///
    /// Shows how multiple authors might be credited for a single source,
    /// such as co-writers on a novel or screenplay.
    static let example = [
        SourceAuthor(source: .example, entity: .example),
        SourceAuthor(source: .example, entity: .example),
        SourceAuthor(source: .example, entity: .example)
    ]
}
