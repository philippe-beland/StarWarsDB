//
//  Artist.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents an artist or creator in the Star Wars universe
///
/// Artists can be writers, illustrators, directors, or other creative professionals
/// who have contributed to Star Wars media. This model is used to track their work
/// and contributions across different sources.
@Observable
class Artist: Entity {
    
    /// Creates a new artist
    /// - Parameters:
    ///   - name: The artist's name
    ///   - comments: Additional notes about the artist
    init(name: String, comments: String? = nil) {
        let id = UUID()
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Artist", tableName: "artists")
    }
    
    /// Keys used for encoding and decoding artist data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Artist's name
        case name
        /// Additional notes
        case comments
    }
    
    /// Creates an artist from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Artist", tableName: "artists")
    }
    
    /// Encodes the artist into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example artist for previews and testing
    static let example = Artist(name: "Charles Soule")
    
    /// An empty artist for initialization
    static let empty = Artist(name: "")
}
