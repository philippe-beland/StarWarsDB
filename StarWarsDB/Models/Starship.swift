//
//  Starship.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents a specific starship in the Star Wars universe
///
/// While StarshipModel represents a class or type of vessel, Starship represents
/// individual vessels. For example, while YT-1300 is a starship model, the
/// Millennium Falcon is a specific starship of that model with its own history
/// and characteristics.
@Observable
class Starship: Entity {
    /// The design specification of this starship
    ///
    /// Links to the StarshipModel that defines this vessel's basic characteristics
    /// and capabilities. Multiple starships can share the same model, but each
    /// might be modified or customized differently.
    var model: StarshipModel?
    
    /// Keys used for encoding and decoding starship data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Ship's name
        case name
        /// Ship's model
        case model
        /// First appearance in media
        case firstAppearance = "first_appearance"
        /// Additional notes
        case comments
        /// Number of appearances
        case nbApparitions = "appearances"
    }
    
    /// Creates a new starship
    /// - Parameters:
    ///   - name: The vessel's name or designation
    ///   - model: The starship's model type
    ///   - firstAppearance: First appearance in Star Wars media
    ///   - comments: Additional notes about the starship
    init(name: String, model: StarshipModel?, firstAppearance: String?, comments: String? = nil) {
        let id = UUID()
        self.model = model
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Starship", tableName: "starships")
    }
    
    /// Creates a starship from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.model = try container.decodeIfPresent(StarshipModel.self, forKey: .model)
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Starship", tableName: "starships")
    }
    
    /// Encodes the starship into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if model != nil && model != .example {
            try container.encode(model?.id, forKey: .model)
        }
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example starship for previews and testing
    static let example = Starship(
        name: "Millennium Falcon",
        model: .example,
        firstAppearance: nil,
        comments: "The fastest hunk of junk in the galaxy"
    )
    
    /// An empty starship for initialization
    static let empty = Starship(
        name: "",
        model: nil,
        firstAppearance: nil,
        comments: ""
    )
}
