//
//  Supabase.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/12/24.
//

import Supabase
import Foundation

let supabase = SupabaseClient(
    supabaseURL: URL(string: Secrets.supabaseURL.rawValue)!,
    supabaseKey: Secrets.apiKey.rawValue)

func loadEntities(entityType: EntityType, sort: String, filter: String = "") async -> [Entity] {
    let entities: [Entity]
    
    switch entityType {
    case .character:
        entities = await loadCharacters(sort: sort, filter: filter)
    case .creature:
        entities = await loadCreatures(sort: sort, filter: filter)
    case .droid:
        entities = await loadDroids(sort: sort, filter: filter)
    case .organization:
        entities = await loadOrganizations(sort: sort, filter: filter)
    case .planet:
        entities = await loadPlanets(sort: sort, filter: filter)
    case .species:
        entities = await loadSpecies(sort: sort, filter: filter)
    case .starship:
        entities = await loadStarships(sort: sort, filter: filter)
    case .starshipModel:
        entities = await loadStarshipModels(sort: sort, filter: filter)
    }
    return entities
}

func loadSources(sort: String, filter: String = "") async -> [Source] {
    var sources: [Source] = []
    
    do {
        sources = try await supabase
            .from("sources")
            .select("id, name, type, release_date, number, commentary, image, serie!inner(*)")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return sources
}

func loadCharacters(sort: String, filter: String = "") async -> [Character] {
    var characters: [Character] = []
    
    do {
        characters = try await supabase
            .from("sources")
            .select("id, name, type, release_date, number, commentary, image, serie!inner(*)")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return characters
}

func loadCreatures(sort: String, filter: String = "") async -> [Character] {
    var characters: [Character] = []
    
    do {
        characters = try await supabase
            .from("sources")
            .select("id, name, type, release_date, number, commentary, image, serie!inner(*)")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return characters
}

func loadDroids(sort: String, filter: String = "") async -> [Character] {
    var characters: [Character] = []
    
    do {
        characters = try await supabase
            .from("sources")
            .select("id, name, type, release_date, number, commentary, image, serie!inner(*)")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return characters
}

func loadOrganizations(sort: String, filter: String = "") async -> [Character] {
    var characters: [Character] = []
    
    do {
        characters = try await supabase
            .from("sources")
            .select("id, name, type, release_date, number, commentary, image, serie!inner(*)")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return characters
}

func loadPlanets(sort: String, filter: String = "") async -> [Character] {
    var characters: [Character] = []
    
    do {
        characters = try await supabase
            .from("sources")
            .select("id, name, type, release_date, number, commentary, image, serie!inner(*)")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return characters
}

func loadSpecies(sort: String, filter: String = "") async -> [Character] {
    var characters: [Character] = []
    
    do {
        characters = try await supabase
            .from("sources")
            .select("id, name, type, release_date, number, commentary, image, serie!inner(*)")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return characters
}

func loadStarships(sort: String, filter: String = "") async -> [Character] {
    var characters: [Character] = []
    
    do {
        characters = try await supabase
            .from("sources")
            .select("id, name, type, release_date, number, commentary, image, serie!inner(*)")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return characters
}

func loadStarshipModels(sort: String, filter: String = "") async -> [Character] {
    var characters: [Character] = []
    
    do {
        characters = try await supabase
            .from("sources")
            .select("id, name, type, release_date, number, commentary, image, serie!inner(*)")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return characters
}

//
//func loadSourceGadgets(recordField: String, recordID: String) async -> [SourceGadget] {
//    var sourceGadgets = [SourceGadget]()
//    do {
//        sourceGadgets = try await supabase
//            .from("source_gadget")
//            .select("id, sources!inner(id, name, type, release_date, number, commentary, image), gadgets!inner(*)")
//            .eq(recordField, value: recordID)
//            .execute()
//            .value
//        print("SourceGadgets successfully loaded")
//    } catch {
//        print("Failed to fetch SourceGadgets: \(error)")
//    }
//    return sourceGadgets
//}

func downloadAndUploadImage(from imageUrl: URL, path: String) {
    let task = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
        guard let data = data, error == nil else {
            print("Error downloading image: \(error?.localizedDescription ?? "No error info")")
            return
        }
        
        uploadImageToSupabase(data: data, path: path)
    }
    task.resume()
}

private func uploadImageToSupabase(data: Data, path: String) {
    Task {
        do {
            try await supabase.storage
                .from("character_images")
                .upload(path, data: data, options: FileOptions(cacheControl: "3600", contentType: "image/png", upsert: false))
            print("Image uploaded successfully")
        } catch {
            print("Failed to upload image: \(error)")
        }
    }
}
