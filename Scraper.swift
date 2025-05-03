//
//  Scraper.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation
import SwiftSoup


func fetchInfo(for sourceURL: URL?, type: EntityType) async throws -> [String] {
    guard let sourceURL else {
        throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
    }

    let (data, _) = try await URLSession.shared.data(from: sourceURL)
    let html = String(data: data, encoding: .utf8) ?? ""
    let headerText: String = switch type {
        case .character:
            "p#app_characters"
        case .creature:
            "p#app_organisms"
        case .planet:
            "p#app_locations"
        case .droid:
            "p#app_droids"
        case .organization:
            "p#app_organizations"
        case .species:
            "p#app_species"
        case .starship:
            "p#app_vehicles"
        case .starshipModel:
            "p#app_vehicles"
        case .varia:
            "p#app_miscellanea"
        default:
            "Not implemented yet"
        }
    
    do {
        let doc: Document = try SwiftSoup.parse(html)

            
        guard let header = try doc.select(headerText).first() else {
            return ["\(type.rawValue) header not found"]
        }
        
        // Traverse siblings until we find a non-empty one with <li> elements
        var next: Element? = try header.nextElementSibling()
        while let current = next {
            let allListItems = try current.select("li")

            let filteredItems: [Element] = try allListItems.filter { item in
                let hasChildren = try !item.select("> ul").isEmpty()
                let isNestedInLi = try item.parents().first(where: { try $0.tagName() == "li" }) != nil

                if type == .species {
                    // For species: keep top-level items (with or without children)
                    return !isNestedInLi
                } else {
                    // For others: keep only leaf items (no children)
                    return !hasChildren
                }
            }

            if !filteredItems.isEmpty {
                let entities: [String] = try filteredItems.compactMap { item in
                    guard let name = try item.select("a").first()?.text() else { return nil }
                    let modifiers = try item.select("small").map { try $0.text() }
                    return "\(name) \(modifiers.joined(separator: " "))"
                }
                
                return entities
            }
            next = try current.nextElementSibling()
        }
        return ["Section not found"]
    } catch {
        return ["No info found"]
    }
}

struct WikiEntity: Identifiable {
    var id: UUID = UUID()
    var name: String
    var modifiers: [String]
    var appearance: AppearanceType
}

func processWikiEntities(_ entitiesList: [String]) -> [WikiEntity] {
    var processedEntities: [WikiEntity] = []
    
    for entity in entitiesList {
        let processedEntity: WikiEntity = processWikiEntity(entity)
        if !processedEntity.name.contains("Unidentified") {
            processedEntities.append(processedEntity)
        }
    }
    
    return processedEntities
}

func processWikiEntity(_ entity: String) -> WikiEntity {
    
    let name = entity.components(separatedBy: " (").first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? entity
    
    let imagePatterns = ["appears as a toy", "as statue", "emblem only", "first pictured", "as a tooka doll"]
    let mentionPatterns = ["mentioned only", "indirect mention only", "first mentioned"]
    let ignoredPatterns = ["first appearance", "voice only", "appears as hologram"]
    let flashbackPatterns = ["in flashback(s)", "appears as a hologram in flashback", "appears as a hologram in flashback(s)"]
    var appearance: AppearanceType = .present
    var filteredModifiers: [String] = []
    
    let modifiers = extractParentheticalPhrases(from: entity)
    
    for modifier in modifiers.map({ $0.lowercased() }) {
        if ignoredPatterns.contains(modifier) {
            continue
        }
        
        if flashbackPatterns.contains(modifier) {
            appearance = .flashback
            continue
        } else if mentionPatterns.contains(modifier) {
            appearance = .mentioned
            continue
        } else if imagePatterns.contains(modifier) {
            appearance = .image
            continue
        }
        
        filteredModifiers.append(modifier)
    }
    
    let processedEntity: WikiEntity = WikiEntity(name: name, modifiers: filteredModifiers, appearance: appearance)
    
    return processedEntity
}

func extractParentheticalPhrases(from input: String) -> [String] {
    var results: [String] = []
    var depth = 0
    var current = ""

    for char in input {
        if char == "(" {
            if depth == 0 {
                current = ""
            } else {
                current.append(char)
            }
            depth += 1
        } else if char == ")" {
            depth -= 1
            if depth == 0 {
                results.append(current)
            } else if depth > 0 {
                current.append(char)
            }
        } else if depth > 0 {
            current.append(char)
        }
    }

    return results
}

func fetchImageURL(for characterURL: String) async throws -> String? {
    guard let url = URL(string: characterURL) else {
        throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    let html = String(data: data, encoding: .utf8) ?? ""
    
    do {
        
        let doc: Document = try SwiftSoup.parse(html)
        
        // Look for the information in the infobox
        let image_soup = try doc.getElementsByClass("pi-item pi-image")
            
        if !image_soup.isEmpty {
            let image_url = try image_soup.first()!.select("a").first()!
            
            let identifier = try image_url.attr("href")
            
            if !identifier.isEmpty {
                return identifier
            }
        }
    } catch {
        print("Error parsing HTML: \(error)")
    }
    
    return "No image found"
}


