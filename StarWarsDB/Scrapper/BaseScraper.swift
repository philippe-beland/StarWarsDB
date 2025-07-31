import Foundation
import SwiftSoup

// MARK: - HTML Fetching
func fetchHTML(from url: URL?) async throws -> String {
    guard let url else {
        throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    return String(data: data, encoding: .utf8) ?? ""
}

// MARK: - HTML Parsing
func parseHTML(_ html: String) throws -> Document {
    return try SwiftSoup.parse(html)
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
        scraperLogger.error("Error parsing HTML: \(error)")
    }
    
    return "No image found"
}
