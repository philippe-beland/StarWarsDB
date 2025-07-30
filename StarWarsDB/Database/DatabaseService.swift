import Supabase
import Foundation

let supabase = SupabaseClient(
    supabaseURL: URL(string: Secrets.supabaseURL.rawValue)!,
    supabaseKey: Secrets.apiKey.rawValue)

func loadEntities<T: BaseEntity>(serie: Serie? = nil, sort: SortingItemOrder, filter: String = "") async -> [T] {
    await T.loadAll(serie: serie, sort: sort.rawValue, filter: filter)
}

func loadSources(sort: String, sourceType: SourceType?, serie: Serie?, isDone: Bool, filter: String = "") async -> [Source] {
    var sources: [Source] = []
    
    do {
        var query = supabase
            .from("sources")
            .select("id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments")
        
        if let sourceType = sourceType {
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
