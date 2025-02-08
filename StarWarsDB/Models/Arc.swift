//
//  Arc.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2024-11-29.
//

import Foundation

/// Represents a story arc in the Star Wars universe
/// 
/// An arc is a collection of related stories within a series, such as a comic book storyline
/// or a multi-episode TV show plot arc.
@Observable
class Arc: Entity {
    /// The series this arc belongs to
    var serie: Serie?
    
    /// Creates a new story arc
    /// - Parameters:
    ///   - name: The name of the arc
    ///   - serie: The series this arc belongs to
    ///   - comments: Additional notes about the arc
    init(name: String, serie: Serie, comments: String?) {
        let id: UUID = UUID()
        self.serie = serie
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Arc", tableName: "arcs")
    }
    
    /// Keys used for encoding and decoding arc data
    enum CodingKeys: String, CodingKey {
        /// Unique identifier
        case id
        /// Name of the arc
        case name
        /// Associated series
        case serie
        /// Additional notes
        case comments
    }
    
    /// Creates an arc from decoded data
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: An error if data reading fails
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.serie = try container.decodeIfPresent(Serie.self, forKey: .serie)
        
        let id: UUID = try container.decode(UUID.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        let comments: String? = try container.decodeIfPresent(String.self, forKey: .comments)
        
        super.init(id: id, name: name, comments: comments, firstAppearance: nil, recordType: "Arc", tableName: "arcs")
    }
    
    /// Encodes the arc into data for storage
    /// - Parameter encoder: The encoder to write data to
    /// - Throws: An error if data writing fails
    override func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Arc.CodingKeys> = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        if serie != nil {
            try container.encode(serie?.id, forKey: .serie)
        }
        try container.encode(comments, forKey: .comments)
    }
    
    /// An example arc for previews and testing
    static let example = Arc(name: "Battle for the Force", serie: .example, comments: nil)
    
    /// An empty arc for initialization
    static let empty = Arc(name: "", serie: .empty, comments: nil)
}
