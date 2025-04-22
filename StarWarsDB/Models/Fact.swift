//
//  Fact.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

/// Represents a factual piece of information from the Star Wars universe
///
/// Facts are specific pieces of information or lore extracted from Star Wars media sources.
/// Each fact is associated with a source and can be tagged with keywords for easy searching
/// and categorization.
@Observable
class Fact: DataNode, Identifiable {
    /// Unique identifier for the fact
    let id: UUID
    
    /// The actual factual information
    var fact: String
    
    /// The source material where this fact was found
    var source: Source
    
    /// Keywords or tags associated with this fact for categorization and searching
    ///
    /// Keywords help organize and find related facts. They might include:
    /// - Character names
    /// - Locations
    /// - Events
    /// - Concepts or themes
    var keywords: [String]
    
    /// Keys used for encoding and decoding fact data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// The factual information
        case fact
        /// Source reference
        case source
        /// Associated keywords
        case keywords
    }
    
    /// Creates a new fact
    /// - Parameters:
    ///   - fact: The factual information
    ///   - source: The source material where this fact was found
    ///   - keywords: Keywords or tags for categorization (defaults to empty array)
    init(fact: String, source: Source, keywords: [String] = []) {
        self.id = UUID()
        self.fact = fact
        self.source = source
        self.keywords = keywords
        
        super.init(recordType: "Fact", tableName: "facts", recordID: self.id)
    }
    
    /// Creates a fact from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Fact.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.fact = try container.decode(String.self, forKey: .fact)
        self.source = try container.decode(Source.self, forKey: .source)
        self.keywords = try container.decodeIfPresent([String].self, forKey: .keywords) ?? []
        
        super.init(recordType: "Fact", tableName: "facts", recordID: self.id)
    }
    
    /// Encodes the fact into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Fact.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(fact, forKey: .fact)
        try container.encode(source.id, forKey: .source)
        try container.encode(keywords, forKey: .keywords)
    }
    
    /// An example fact for previews and testing
    static let example = Fact(
        fact: "Battle for the Force",
        source: .example,
        keywords: ["Star Wars"]
    )
    
    /// An empty fact for initialization
    static let empty = Fact(
        fact: "",
        source: .example,
        keywords: []
    )
}
