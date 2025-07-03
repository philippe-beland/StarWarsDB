import Foundation

/// Base class for tracking entity appearances in Star Wars media sources
///
/// SourceEntity creates relationships between entities (characters, creatures, etc.)
/// and the sources they appear in, along with the type of appearance (present,
/// mentioned, flashback, etc.). This enables tracking how and where different
/// elements of the Star Wars universe are referenced.
class SourceEntity: DatabaseEntity, Equatable, Identifiable {
    var recordType: String
    var databaseTableName: String
    
    var id: UUID

    var source: Source
    var entity: Entity
    var appearance: AppearanceType
    var number: Int
    
    init (id: UUID, source: Source, entity: Entity, appearance: AppearanceType, number: Int = 0, recordType: String, databaseTableName: String) {
        self.id = id
        self.source = source
        self.entity = entity
        self.appearance = appearance
        self.number = number
        self.recordType = recordType
        self.databaseTableName = databaseTableName
    }
                   
    required init(from decoder: Decoder) throws {
       fatalError("init(from:) has not been implemented")
    }

    /// Compares two sourceEntities for equality
    static func == (lhs: SourceEntity, rhs: SourceEntity) -> Bool {
       lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
