import Foundation

protocol BaseEntity: DatabaseRecord {
    var name: String { get set }
    var comments: String? { get set }
    static var example: Self { get }
    static var empty: Self { get }
    var wookieepediaTitle: String { get }

    static func loadAll(serie: Serie?, sort: String, filter: String) async -> [Self]
}

extension BaseEntity {
    var url: URL? {
        let title = wookieepediaTitle.isEmpty ? name : wookieepediaTitle
        let encodedTitle = title.replacingOccurrences(of: " ", with: "_")
        return URL(string: "https://starwars.fandom.com/wiki/" + encodedTitle)
    }
}


