import Foundation

protocol Entity: BaseEntity {
    static var sourceRecordType: String { get }
    static var sourceDatabaseTableName: String { get }
}
