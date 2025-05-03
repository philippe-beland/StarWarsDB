//
//  DataNode.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation
import Supabase

/// Types of entities that can be tracked in the Star Wars database
///
/// This enum defines all the different types of elements that can be
/// recorded and tracked in the database, from characters to starships.
enum EntityType: String, Codable {
    /// Individual characters
    case character = "Character"
    /// Non-humanoid life forms
    case creature = "Creature"
    /// Artificial beings
    case droid = "Droid"
    /// Groups and institutions
    case organization = "Organization"
    /// Worlds and locations
    case planet = "Planet"
    /// Sentient races
    case species = "Species"
    /// Vessel classes and designs
    case starshipModel = "Starship Model"
    /// Individual vessels
    case starship = "Starship"
    /// Miscellaneous items and concepts
    case varia = "Varia"
    /// Story arcs and plot lines
    case arc = "Arc"
    /// Media series and collections
    case serie = "Serie"
    /// Visual artists and creators
    case artist = "Artist"
    /// Writers and authors
    case author = "Author"
}

/// Base class for database-persisted objects
///
/// DataNode provides the foundation for all objects that can be saved to
/// and loaded from the database. It handles basic persistence operations
/// and maintains metadata about the record type and storage location.
class DataNode: Codable {
    /// The type of record this represents (e.g., "Character", "Planet")
    let recordType: String
    
    /// The database table where this record is stored
    let tableName: String
    
    /// Unique identifier for this record in the database
    let recordID: UUID
    
    /// Creates a new data node
    /// - Parameters:
    ///   - recordType: Type of record for display and logging
    ///   - tableName: Database table for storage
    ///   - recordID: Unique identifier
    init(recordType: String, tableName: String, recordID: UUID) {
        self.recordType = recordType
        self.tableName = tableName
        self.recordID = recordID
    }
    
    /// Saves this record to the database
    ///
    /// Creates a new record in the database with this object's data.
    /// Prints success or failure messages to aid in debugging.
    func save() {
        Task {
            do {
                try await supabase
                    .from(self.tableName)
                    .insert(self)
                    .execute()
                
                print("\(self.recordType) saved successfully")
            } catch {
                print("Failed to save \(self.recordType): \(error)")
            }
        }
    }
    
    /// Updates this record in the database
    ///
    /// Updates the existing database record with this object's current data.
    /// Prints success or failure messages to aid in debugging.
    func update() {
        Task {
            do {
                try await supabase
                    .from(self.tableName)
                    .update(self)
                    .eq("id", value: self.recordID.uuidString)
                    .execute()
                
                print("\(self.recordType) successfully updated.")
            } catch {
                print("\(self.recordType) update failed: \(error.localizedDescription)")
            }
        }
    }
    
    /// Deletes this record from the database
    ///
    /// Removes the record from the database permanently.
    /// Prints success or failure messages to aid in debugging.
    func delete() {
        Task {
            do {
                try await supabase
                    .from(self.tableName)
                    .delete()
                    .eq("id", value: self.recordID.uuidString)
                    .execute()
                
                print("\(self.recordType) successfully deleted.")
                
            } catch {
                print("Failed to delete \(self.recordType): \(error)")
            }
        }
    }
}

/// Base class for Star Wars universe entities
///
/// Entity provides common properties and behavior for all trackable elements
/// in the Star Wars universe. This includes basic identification, naming,
/// and appearance tracking shared by all entity types.
@Observable
class Entity: DataNode, Record {
    /// Unique identifier
    var id: UUID
    
    /// Name or title of the entity
    var name: String
    
    /// Additional notes about the entity
    var comments: String
    
    /// Number of times this entity appears in sources
    var nbApparitions: Int
    
    /// First appearance in Star Wars media
    var firstAppearance: String
    
    var isExisting: Bool = false
    
    var wookieepediaTitle: String = ""
    
    /// Wookieepedia URL for this entity
    var url: URL? {
        let title = wookieepediaTitle.isEmpty ? name : wookieepediaTitle
        let encodedTitle = title.replacingOccurrences(of: " ", with: "_")
        return URL(string: "https://starwars.fandom.com/wiki/" + encodedTitle)
    }
    
    /// Creates a new entity
    /// - Parameters:
    ///   - id: Unique identifier
    ///   - name: Entity name
    ///   - comments: Additional notes
    ///   - firstAppearance: First media appearance
    ///   - nbApparitions: Number of appearances
    ///   - recordType: Type of record
    ///   - tableName: Database table
    init(id: UUID, name: String, comments: String?, firstAppearance: String?, nbApparitions: Int = 0, recordType: String, tableName: String) {
        self.id = id
        self.name = name
        self.comments = comments ?? ""
        self.firstAppearance = firstAppearance ?? ""
        self.nbApparitions = nbApparitions
        
        super.init(recordType: recordType, tableName: tableName, recordID: id)
    }
    
    /// Required initializer for Decodable protocol
    /// - Note: This is not implemented in the base class and must be implemented by subclasses
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    /// Compares two entities for equality
    /// - Returns: True if both entities have the same ID
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        lhs.id == rhs.id
    }
    
    /// Generates a hash value for the entity
    /// - Parameter hasher: The hasher to use
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

/// Protocol for named, identifiable database records
///
/// Record defines the basic requirements for any named entity that can
/// be stored in the database and referenced online.
protocol Record: Identifiable, Hashable {
    /// Unique identifier
    var id: UUID { get }
    
    /// Name or title
    var name: String { get set }
    
    /// Additional notes
    var comments: String { get set }
    
    /// Online reference URL
    var url: URL? { get }
}

/// Helper class for counting source appearances
///
/// Used when querying the database to get appearance counts for entities.
class SourceCount: Decodable {
    /// Number of appearances
    var count: Int
}
