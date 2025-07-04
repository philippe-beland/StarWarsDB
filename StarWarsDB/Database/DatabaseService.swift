import Supabase
import Foundation

let supabase = SupabaseClient(
    supabaseURL: URL(string: Secrets.supabaseURL.rawValue)!,
    supabaseKey: Secrets.apiKey.rawValue)

func loadEntities(serie: Serie? = nil, entityType: EntityType, sort: SortingItemOrder, filter: String = "") async -> [Entity] {
    var entities = [Entity]()
    
    switch entityType {
    case .character:
        entities = await loadCharacters(serie: serie, sort: sort.rawValue, filter: filter)
    case .creature:
        entities = await loadCreatures(serie: serie, sort: sort.rawValue, filter: filter)
    case .droid:
        entities = await loadDroids(serie: serie, sort: sort.rawValue, filter: filter)
    case .organization:
        entities = await loadOrganizations(serie: serie, sort: sort.rawValue, filter: filter)
    case .planet:
        entities = await loadPlanets(serie: serie, sort: sort.rawValue, filter: filter)
    case .species:
        entities = await loadSpecies(serie: serie, sort: sort.rawValue, filter: filter)
    case .starship:
        entities = await loadStarships(serie: serie, sort: sort.rawValue, filter: filter)
    case .starshipModel:
        entities = await loadStarshipModels(serie: serie, sort: sort.rawValue, filter: filter)
    case .varia:
        entities = await loadVarias(serie: serie, sort: sort.rawValue, filter: filter)
    case .serie:
        entities = await loadSeries(filter: filter)
    case .arc:
        entities = await loadArcs(sort: sort.rawValue, filter: filter)
    case .artist:
        entities = await loadArtists(sort: sort.rawValue, filter: filter)
    case .author:
        entities = await loadArtists(sort: sort.rawValue, filter: filter)
    }
    return entities
}

func loadSources(sort: String, sourceType: SourceType, serie: Serie?, isDone: Bool, filter: String = "") async -> [Source] {
    var sources: [Source] = []
    
    do {
        var query = supabase
            .from("sources")
            .select("id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments")
        
        if sourceType != .all {
            query = query.eq("source_type", value: sourceType.rawValue)
        }
        
        if let serie {
            query = query.eq("serie", value: serie.id)
        }
        
        if isDone {
            query = query.eq("is_done", value: false)
        }
        
        if !filter.isEmpty {
            query = query.ilike("name", pattern: "%\(filter)%")
        }
        
        query = query.order(sort).order("number").limit(500) as! PostgrestFilterBuilder
        sources = try await query.execute().value

        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return sources
}

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
