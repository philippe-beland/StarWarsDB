import Foundation

/// Base class for tracking entity appearances in Star Wars media sources
///
/// SourceEntity creates relationships between entities (characters, creatures, etc.)
/// and the sources they appear in, along with the type of appearance (present,
/// mentioned, flashback, etc.). This enables tracking how and where different
/// elements of the Star Wars universe are referenced.
@Observable
class SourceEntity<T: TrackableEntity>: SourceEntityProtocol {
    var id: UUID
    
    var source: Source
    var entity: T
    
    var appearance: AppearanceType
    var number: Int
    
    var recordType: String { T.sourceRecordType }
    var databaseTableName: String { T.sourceDatabaseTableName }

    init(id: UUID? = nil, source: Source, entity: T, appearance: AppearanceType, number: Int = 0) {
        self.id = id ?? UUID()
        self.source = source
        self.entity = entity
        self.appearance = appearance
        self.number = number
    }

    enum CodingKeys: String, CodingKey {
        case id
        case source
        case entity
        case appearance
        case number = "nb_appearances"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.source = try container.decode(Source.self, forKey: .source)
        self.entity = try container.decode(T.self, forKey: .entity)
        let rawAppearance = try container.decode(Int.self, forKey: .appearance)
        self.appearance = AppearanceType(rawValue: rawAppearance.description) ?? .present
        self.number = try container.decodeIfPresent(Int.self, forKey: .number) ?? 0
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(source.id, forKey: .source)
        try container.encode(entity.id, forKey: .entity)
        try container.encode(appearance.rawValue, forKey: .appearance)
    }

    static func == (lhs: SourceEntity, rhs: SourceEntity) -> Bool {
        lhs.source == rhs.source && lhs.entity == rhs.entity
    }
}
