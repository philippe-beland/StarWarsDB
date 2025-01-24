//
//  Droid.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents a droid in the Star Wars universe
///
/// Droids are robotic beings that serve various functions in the galaxy.
/// They can be specialized for tasks like astrogation, protocol, or combat,
/// and are classified into different types based on their primary function.
@Observable
class Droid: Entity {
    /// The droid's classification type (e.g., "Astromech", "Protocol", "Battle")
    ///
    /// This indicates the droid's primary function and capabilities. For example:
    /// - Astromech droids specialize in starship maintenance and navigation
    /// - Protocol droids focus on translation and diplomatic functions
    /// - Battle droids are designed for combat operations
    var classType: String?
    
    /// Creates a new droid
    /// - Parameters:
    ///   - name: The droid's designation or name
    ///   - classType: The droid's classification type
    ///   - firstAppearance: First appearance in Star Wars media
    ///   - comments: Additional notes about the droid
    init(name: String, classType: String?, firstAppearance: String?, comments: String?) {
        let id = UUID()
        self.classType = classType
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Droid", tableName: "droids")
    }
    
    /// Keys used for encoding and decoding droid data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Droid's name or designation
        case name
        /// Droid's classification type
        case classType = "class_type"
        /// First appearance in media
        case firstAppearance = "first_appearance"
        /// Additional notes
        case comments
        /// Number of appearances
        case nbApparitions = "appearances"
    }
    
    /// Creates a droid from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.classType = try container.decodeIfPresent(String.self, forKey: .classType)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Droid", tableName: "droids")
    }
    
    /// Encodes the droid into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(classType, forKey: .classType)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example droid for previews and testing
    ///
    /// R2 astromech droids are a popular and versatile class of utility droids,
    /// known for their reliability in starship maintenance and navigation.
    static let example = Droid(
        name: "R2 astromech droid",
        classType: "Astromech droid",
        firstAppearance: nil,
        comments: "Astromech droid with a high degree of mechanical aptitude."
    )
    
    /// An empty droid for initialization
    static let empty = Droid(name: "", classType: nil, firstAppearance: nil, comments: nil)
}
