//
//  Serie.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents a series of related Star Wars media content
///
/// A series is a collection of related content that shares a common narrative thread,
/// characters, or theme. This can include TV shows, comic book series, novel series,
/// or other sequential media formats.
@Observable
class Serie: Entity {
    /// The type of media content in this series
    ///
    /// Indicates whether this is a TV show, comic book series, novel series, etc.
    /// This helps categorize and organize different types of Star Wars media.
    var sourceType: SourceType
    
    /// Keys used for encoding and decoding series data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Series name
        case name
        /// Type of media content
        case sourceType = "source_type"
        /// Additional notes
        case comments
    }
    
    /// Creates a new series
    /// - Parameters:
    ///   - name: The name of the series
    ///   - sourceType: The type of media content (e.g., TV show, comic book)
    ///   - comments: Additional notes about the series
    init(name: String, sourceType: SourceType, comments: String?) {
        let id: UUID = UUID()
        self.sourceType = sourceType
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Serie", tableName: "series")
    }
    
    /// Creates a series from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Serie.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        self.sourceType = try container.decode(SourceType.self, forKey: .sourceType)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Serie", tableName: "series")
    }
    
    /// Encodes the series into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Serie.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(sourceType.rawValue, forKey: .sourceType)
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example series for previews and testing
    static let example = Serie(
        name: "Rebels",
        sourceType: .tvShow,
        comments: "Series about the adventures of Ghost Squadron"
    )
    
    /// An empty series for initialization
    static let empty = Serie(
        name: "",
        sourceType: .tvShow,
        comments: nil
    )
}
