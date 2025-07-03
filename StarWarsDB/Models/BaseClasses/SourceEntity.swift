import Foundation

/// Base class for tracking entity appearances in Star Wars media sources
///
/// SourceEntity creates relationships between entities (characters, creatures, etc.)
/// and the sources they appear in, along with the type of appearance (present,
/// mentioned, flashback, etc.). This enables tracking how and where different
/// elements of the Star Wars universe are referenced.
class SourceEntity: DatabaseEntity, Equatable, Identifiable {
    var id: UUID
    
    /// The source material where the entity appears
    var source: Source
    
    /// The entity that appears in the source
    ///
    /// This is a generic reference to any trackable element in the Star Wars
    /// universe. Subclasses specialize this for specific entity types like
    /// characters, planets, etc.
    var entity: Entity
    
    /// How the entity appears in the source
    var appearance: AppearanceType
    var number: Int
    
    init (id: UUID, source: Source, entity: Entity, appearance: AppearanceType, number: Int = 0, recordType: String, databaseTableName: String) {
        self.id = id
        self.source = source
        self.entity = entity
        self.appearance = appearance
        self.number = number
        
        super.init(recordType: recordType, databaseTableName: databaseTableName, recordID: self.id)
    }
                   
    required init(from decoder: Decoder) throws {
       fatalError("init(from:) has not been implemented")
    }

    /// Compares two sourceEntities for equality
    static func == (lhs: SourceEntity, rhs: SourceEntity) -> Bool {
       lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
