import Foundation

// Protocol to unify shared behavior
protocol SourceEntityProtocol: DatabaseRecord, Hashable, Codable {

    var id: UUID { get set }
    var source: Source { get set }
    var number: Int { get set }

    var recordType: String { get }
    var databaseTableName: String { get }
}

extension SourceEntityProtocol {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

