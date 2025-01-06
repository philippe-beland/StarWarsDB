//
//  Scraper.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation
import SwiftSoup


func fetchInfo(for characterURL: String, key: String) async throws -> String? {
    guard let url = URL(string: characterURL) else {
        throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
    }

    let (data, _) = try await URLSession.shared.data(from: url)
    let html = String(data: data, encoding: .utf8) ?? ""

    let doc: Document = try SwiftSoup.parse(html)
    
    // Look for the information in the infobox
    let infoboxRows = try doc.getElementsByClass("pi-item pi-data pi-item-spacing pi-border-color")
    
    for row in infoboxRows {
        let header = try row.attr("data-source")
        
        if header == key {
            return try row.getElementsByClass("pi-data-value pi-font").first()?.text()
        }
    }

    return "No info found"
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


