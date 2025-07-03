import Foundation

/// Protocol for named, identifiable database records
///
/// NamedEntity defines the basic requirements for any named entity that can
/// be stored in the database and referenced online.
protocol NamedEntity: Identifiable, Hashable {
    var id: UUID { get }
    var name: String { get set }
    var comments: String { get set }
    var url: URL? { get }
}
