//
//  Appearances.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation

enum AppearanceType: String, Codable, CaseIterable {
    case present = "1"
    case mentioned = "2"
    case flashback = "3"
    case vision = "6"
    case indirectMentioned = "5"
    case image = "4"

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
