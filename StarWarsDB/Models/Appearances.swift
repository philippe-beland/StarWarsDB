import Foundation

/// The type of appearance of an entity in a specific source
enum AppearanceType: String, Codable, CaseIterable {
    /// The entity is present in the source
    case present = "1"
    /// The entity is directly or indirectly mentioned in the source
    case mentioned = "2"
    /// The entity is seen in a flashback in the source
    case flashback = "3"
    /// The entity is seen in a vision in the source
    case vision = "6"
    /// The entity is indirectly mentioned in the source
    /// TODO: TO DELETE
    case indirectMentioned = "5"
    /// The entity is seen in an image in the source
    case image = "4"

    /// The description of the appearance type
    var description: String {
        switch self {
        case .present: return "Present"
        case .mentioned: return "Mentioned"
        case .flashback: return "Flashback"
        case .vision: return "Vision"
        case .image: return "Image"
        case .indirectMentioned: return "Indirect Mentioned"
        }
    }
}
