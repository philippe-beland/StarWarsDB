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

    
//func loadSources(sort: String, sourceType: SourceType, filter: String = "") async -> [Source] {
//    var sources: [Source] = []
//    
//    do {
//        sources = try await supabase
//            .from("sources")
//            .select("id, name, type, release_date, number, commentary, image, serie!inner(*)")
//            .eq("type", value: sourceType.rawValue)
//            .ilike("name", pattern: "%\(filter)%")
//            .order(sort)
//            .limit(40)
//            .execute()
//            .value
//        print("Sources successfully loaded")
//    } catch {
//        print("Failed to fetch Sources: \(error)")
//    }
//    
//    return sources
//}
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
