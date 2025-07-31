import Foundation
import SwiftSoup

// MARK: - Main Function
func fetchMissingEntities<T: TrackableEntity>(entityType: T.Type, for sourceURL: URL?) async throws -> [String] {
    let html = try await fetchHTML(from: sourceURL)
    let doc = try parseHTML(html)
    let headerText: String = T.htmlTag
    
    guard let header = try findEntityHeader(in: doc, for: headerText) else {
        return ["\(T.displayName) header not found"]
    }
    
    let entities = try await extractEntities(from: header, for: entityType)
    return entities.isEmpty ? ["Section not found"] : entities
}

// MARK: - Header Finding
func findEntityHeader(in doc: Document, for headerText: String) throws -> Element? {
    return try doc.select(headerText).first()
}

// MARK: - Entity Extraction
func extractEntities<T: TrackableEntity>(from header: Element, for entityType: T.Type) async throws -> [String] {
    var next: Element? = try header.nextElementSibling()
    
    while let current = next {
        let filteredItems = try filterListItems(in: current, for: entityType)
        
        if !filteredItems.isEmpty {
            return try extractEntityNames(from: filteredItems)
        }
        
        next = try current.nextElementSibling()
    }
    
    return []
}

// MARK: - List Item Filtering
func filterListItems<T: TrackableEntity>(in element: Element, for entityType: T.Type) throws -> [Element] {
    let allListItems = try element.select("li")
    
    return try allListItems.filter { item in
        let hasChildren = try !item.select("> ul").isEmpty()
        let isNestedInLi = item.parents().first(where: { $0.tagName() == "li" }) != nil
        
        return shouldIncludeListItem(hasChildren: hasChildren, isNestedInLi: isNestedInLi, for: entityType)
    }
}

// MARK: - Filtering Logic
func shouldIncludeListItem<T: TrackableEntity>(hasChildren: Bool, isNestedInLi: Bool, for entityType: T.Type) -> Bool {
    if T.self == Species.self {
        // For species: keep top-level items (with or without children)
        return !isNestedInLi
    } else {
        // For others: keep only leaf items (no children)
        return !hasChildren
    }
}

// MARK: - Name Extraction
func extractEntityNames(from items: [Element]) throws -> [String] {
    return try items.compactMap { item in
        guard let name = try item.select("a").first()?.text() else { return nil }
        let modifiers = try item.select("small").map { try $0.text() }
        return "\(name) \(modifiers.joined(separator: " "))"
    }
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


