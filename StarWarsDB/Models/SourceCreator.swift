import Foundation

/// Base class for tracking creator appearances in Star Wars media sources
@Observable
class SourceCreator<T: CreatorEntity>: SourceEntityProtocol {
    var id: UUID
    var source: Source
    var number: Int
    var creator: T
    
    var recordType: String { T.sourceRecordType }
    var databaseTableName: String { T.sourceDatabaseTableName }

    init(id: UUID? = nil, source: Source, creator: T, number: Int = 0) {
        self.id = id ?? UUID()
        self.source = source
        self.creator = creator
        self.number = number
    }

    enum CodingKeys: String, CodingKey {
        case id
        case source
        case creator = "entity"
        case number = "nb_appearances"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.source = try container.decode(Source.self, forKey: .source)
        self.creator = try container.decode(T.self, forKey: .creator)
        self.number = try container.decodeIfPresent(Int.self, forKey: .number) ?? 0
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(source.id, forKey: .source)
        try container.encode(creator.id, forKey: .creator)
    }

    static func == (lhs: SourceCreator, rhs: SourceCreator) -> Bool {
        lhs.source == rhs.source && lhs.creator == rhs.creator
    }
}
