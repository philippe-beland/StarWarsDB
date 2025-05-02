//
//  Scraper.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Foundation
import SwiftSoup


func fetchInfo(for sourceURL: URL?, type: EntityType) async throws -> String {
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
            return "\(type.rawValue) header not found"
        }
        
        // Traverse siblings until we find a non-empty one with <li> elements
        var next: Element? = try header.nextElementSibling()
        while let current = next {
            let listItems = try current.select("li")
            if !listItems.isEmpty() {
                let entitiesNames = try listItems.map { try $0.text() }
                return entitiesNames.joined(separator: ", ")
            }
            next = try current.nextElementSibling()
        }
        return "Section not found"
    } catch {
        return "No info found"
    }
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


