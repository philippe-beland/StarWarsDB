import Foundation

struct WikiEntity: Identifiable {
    var id: UUID = UUID()
    var name: String
    var modifiers: [String]
    var appearance: AppearanceType
}