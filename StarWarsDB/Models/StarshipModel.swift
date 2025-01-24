//
//  StarshipModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

/// Represents a starship design or class in the Star Wars universe
///
/// Starship models define the specifications and characteristics of a particular
/// type of vessel. Multiple individual starships can be of the same model, such as
/// how many YT-1300 light freighters exist besides the Millennium Falcon.
@Observable
class StarshipModel: Entity {
    /// The vessel's classification (e.g., "Starfighter", "Capital Ship", "Freighter")
    ///
    /// Indicates the primary role and general characteristics of the vessel design.
    var classType: String
    
    /// The manufacturer's product line or series
    ///
    /// For example, the X-wing belongs to the "T-65" line of starfighters
    /// manufactured by Incom Corporation.
    var line: String
    
    /// Keys used for encoding and decoding starship model data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Model name
        case name
        /// Vessel classification
        case classType = "class_type"
        /// Product line
        case line
        /// First appearance in media
        case firstAppearance = "first_appearance"
        /// Additional notes
        case comments
        /// Number of appearances
        case nbApparitions = "appearances"
    }
    
    /// Creates a new starship model
    /// - Parameters:
    ///   - name: The model designation (e.g., "YT-1300", "X-wing")
    ///   - classType: The vessel's classification
    ///   - line: The manufacturer's product line
    ///   - firstAppearance: First appearance in Star Wars media
    ///   - comments: Additional notes about the model
    init(name: String, classType: String?, line: String?, firstAppearance: String?, comments: String? = nil) {
        let id = UUID()
        
        self.classType = classType ?? ""
        self.line = line ?? ""
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, recordType: "Starship Model", tableName: "starship_models")
    }
    
    /// Creates a starship model from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(UUID.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.classType = try container.decodeIfPresent(String.self, forKey: .classType) ?? ""
        self.line = try container.decodeIfPresent(String.self, forKey: .line) ?? ""
        let firstAppearance = try container.decodeIfPresent(String.self, forKey: .firstAppearance)
        let comments = try container.decodeIfPresent(String.self, forKey: .comments)
        let nbApparitions = try container.decodeIfPresent(Int.self, forKey: .nbApparitions) ?? 0
        
        super.init(id: id, name: name, comments: comments, firstAppearance: firstAppearance, nbApparitions: nbApparitions, recordType: "Starship Model", tableName: "starship_models")
    }
    
    /// Encodes the starship model into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(classType, forKey: .classType)
        try container.encode(line, forKey: .line)
        try container.encode(firstAppearance, forKey: .firstAppearance)
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example starship model for previews and testing
    static let example = StarshipModel(
        name: "YT-1300",
        classType: "Starfighter",
        line: nil,
        firstAppearance: nil,
        comments: "Best ship!"
    )
    
    /// An empty starship model for initialization
    static let empty = StarshipModel(
        name: "",
        classType: nil,
        line: nil,
        firstAppearance: nil,
        comments: nil
    )
}
