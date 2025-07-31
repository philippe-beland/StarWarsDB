import Foundation
import SwiftSoup

// MARK: - Main Function
func fetchDescription(for entityURL: URL?) async throws -> String {
    let html = try await fetchHTML(from: entityURL)
    let doc = try parseHTML(html)

    return try await fetchDescription(from: doc)

}

func fetchDescription(from doc: Document) async throws -> String {

    guard let content = try doc.select("#mw-content-text").first() else {
            throw NSError(domain: "Missing content", code: 1, userInfo: nil)
        }

    // Find the quote div
    let quoteElement = try content.select("div.quote").first()

    var nextSibling: Node? = quoteElement?.nextSibling()

    // Traverse siblings until we find a non-empty <p>
    while let node = nextSibling {
        if let element = node as? Element,
            element.tagName() == "p" {
            let text = try element.text().trimmingCharacters(in: .whitespacesAndNewlines)
            if !text.isEmpty {
                return text
            }
        }
        nextSibling = node.nextSibling()
    }

    // Fallback: get first non-empty <p> inside content
    let fallbackParagraphs = try content.select("p")
    for p in fallbackParagraphs {
        let text = try p.text().trimmingCharacters(in: .whitespacesAndNewlines)
        if !text.isEmpty {
            return text
        }
    }

    return "No paragraph found"
}
