//
//  Appearances.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

/// The type of appearance of a character in a specific source
enum AppearanceType: String, Codable, CaseIterable {
    /// The character is present in the source
    case present = "1"
    /// The character is mentioned in the source
    case mentioned = "2"
    /// The character is seen in a flashback in the source
    case flashback = "3"
    /// The character is seen in a vision in the source
    case vision = "6"
    /// The character is indirectly mentioned in the source
    case indirectMentioned = "5"
    /// The character is seen in an image in the source
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
