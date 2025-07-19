import Foundation

protocol Entity: BaseEntity {
    var alreadyInSource: Bool { get set }
    static var sourceRecordType: String { get }
    static var sourceDatabaseTableName: String { get }

    static var displayName: String { get }
}
