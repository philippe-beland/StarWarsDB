//
//  SourceItem.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/14/24.
//

import Foundation

/// Base class for tracking entity appearances in Star Wars media sources
///
/// SourceItem creates relationships between entities (characters, creatures, etc.)
/// and the sources they appear in, along with the type of appearance (present,
/// mentioned, flashback, etc.). This enables tracking how and where different
/// elements of the Star Wars universe are referenced.
///
/// This class serves as the foundation for specialized source tracking classes:
/// - SourceCharacter: For individual characters
/// - SourceCreature: For non-humanoid life forms
/// - SourceDroid: For artificial beings
/// - SourceOrganization: For groups and institutions
/// - SourcePlanet: For worlds and locations
/// - SourceSpecies: For sentient races
/// - SourceStarship: For individual vessels
/// - SourceStarshipModel: For vessel classes
/// - SourceVaria: For miscellaneous items and concepts
/// - SourceArtist/SourceAuthor: For content creators
class SourceItem: DataNode, Equatable, Identifiable {
    /// Unique identifier for the source-entity relationship
    var id: UUID
    
    /// The source material where the entity appears
    ///
    /// This can be any type of Star Wars media:
    /// - Movies and TV shows
    /// - Books and comics
    /// - Video games
    /// - Other official content
    var source: Source
    
    /// The entity that appears in the source
    ///
    /// This is a generic reference to any trackable element in the Star Wars
    /// universe. Subclasses specialize this for specific entity types like
    /// characters, planets, etc.
    var entity: Entity
    
    /// How the entity appears in the source
    ///
    /// This can be:
    /// - present: The entity is physically present
    /// - mentioned: The entity is verbally referenced
    /// - flashback: The entity appears in a past scene
    /// - vision: The entity appears in a Force vision
    /// - image: The entity is shown in a picture or hologram
    /// - indirectMentioned: The entity is alluded to without direct reference
    var appearance: AppearanceType
    
    /// Creates a new source-entity relationship
    /// - Parameters:
    ///   - id: Unique identifier
    ///   - source: The source material
    ///   - entity: The appearing entity
    ///   - appearance: How the entity appears
    ///   - recordType: Type of record for database
    ///   - tableName: Database table name
    ///
    var number: Int
    
    init (id: UUID, source: Source, entity: Entity, appearance: AppearanceType, number: Int = 0, recordType: String, tableName: String) {
        self.id = id
        self.source = source
        self.entity = entity
        self.appearance = appearance
        self.number = number
        
        super.init(recordType: recordType, tableName: tableName, recordID: self.id)
    }
                   
    /// Required initializer for Decodable protocol
    /// - Note: This is not implemented in the base class and must be implemented by subclasses
    /// - Parameter decoder: The decoder to read data from
    /// - Throws: Always throws a fatal error if called directly on SourceItem
    required init(from decoder: Decoder) throws {
       fatalError("init(from:) has not been implemented")
    }

    /// Compares two source items for equality
    /// - Parameters:
    ///   - lhs: First source item to compare
    ///   - rhs: Second source item to compare
    /// - Returns: True if both items reference the same source and entity
    static func == (lhs: SourceItem, rhs: SourceItem) -> Bool {
       lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
