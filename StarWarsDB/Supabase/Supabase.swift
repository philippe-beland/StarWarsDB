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
        
        query = query.order(sort).limit(100) as! PostgrestFilterBuilder
        sources = try await query.execute().value

        print("Sources successfully loaded")
    } catch {
        print("Failed to fetch Sources: \(error)")
    }
    
    return sources
}

func loadCharacters(serie: Serie? = nil, sort: String, filter: String = "") async -> [Character] {
    var characters: [Character] = []
    
    do {
        characters = try await supabase
            .rpc("load_characters")
            .ilike("name", pattern: "%\(filter)%")
            .limit(40)
            .execute()
            .value
        print("Characters successfully loaded")
    } catch {
        print("Failed to fetch Characters: \(error)")
    }
    
    return characters
}

func loadCreatures(serie: Serie? = nil, sort: String, filter: String = "") async -> [Creature] {
    var creatures: [Creature] = []
    
    do {
        creatures = try await supabase
            .rpc("load_creatures")
            .ilike("name", pattern: "%\(filter)%")
            .limit(40)
            .execute()
            .value
        print("Creatures successfully loaded")
    } catch {
        print("Failed to fetch Creatures: \(error)")
    }
    
    return creatures
}

func loadDroids(serie: Serie? = nil, sort: String, filter: String = "") async -> [Droid] {
    var droids: [Droid] = []
    
    do {
        droids = try await supabase
            .rpc("load_droids")
            .ilike("name", pattern: "%\(filter)%")
            .limit(40)
            .execute()
            .value
        print("Droids successfully loaded")
    } catch {
        print("Failed to fetch Droids: \(error)")
    }
    
    return droids
}

func loadOrganizations(serie: Serie? = nil, sort: String, filter: String = "") async -> [Organization] {
    var organizations: [Organization] = []
    
    do {
        organizations = try await supabase
            .rpc("load_organizations")
            .ilike("name", pattern: "%\(filter)%")
            .limit(40)
            .execute()
            .value
        print("Organizations successfully loaded")
    } catch {
        print("Failed to fetch Organizations: \(error)")
    }
    
    return organizations
}

func loadPlanets(serie: Serie? = nil, sort: String, filter: String = "") async -> [Planet] {
    var planets: [Planet] = []
    
    do {
        planets = try await supabase
            .rpc("load_planets")
            .ilike("name", pattern: "%\(filter)%")
            .limit(40)
            .execute()
            .value
        print("Planets successfully loaded")
    } catch {
        print("Failed to fetch Planets: \(error)")
    }
    
    return planets
}

func loadSpecies(serie: Serie? = nil, sort: String, filter: String = "") async -> [Species] {
    var species: [Species] = []
    
    do {
        species = try await supabase
            .rpc("load_species")
            .ilike("name", pattern: "%\(filter)%")
            .limit(40)
            .execute()
            .value
        print("Species successfully loaded")
    } catch {
        print("Failed to fetch Species: \(error)")
    }
    
    return species
}

func loadStarships(serie: Serie? = nil, sort: String, filter: String = "") async -> [Starship] {
    var starships: [Starship] = []
    
    do {
        starships = try await supabase
            .rpc("load_starships")
            .ilike("name", pattern: "%\(filter)%")
            .limit(40)
            .execute()
            .value
        print("Starships successfully loaded")
    } catch {
        print("Failed to fetch Starships: \(error)")
    }
    
    return starships
}

func loadStarshipModels(serie: Serie? = nil, sort: String, filter: String = "") async -> [StarshipModel] {
    var starshipModels: [StarshipModel] = []
    
    do {
        starshipModels = try await supabase
            .rpc("load_starship_models")
            .ilike("name", pattern: "%\(filter)%")
            .limit(40)
            .execute()
            .value
        print("StarshipModels successfully loaded")
    } catch {
        print("Failed to fetch StarshipModels: \(error)")
    }
    
    return starshipModels
}

func loadVarias(serie: Serie? = nil, sort: String, filter: String = "") async -> [Varia] {
    var varias: [Varia] = []
    
    do {
        varias = try await supabase
            .rpc("load_varias", params: ["series_id": serie?.id])
            .ilike("name", pattern: "%\(filter)%")
            .limit(40)
            .execute()
            .value
        print("Varias successfully loaded")
    } catch {
        print("Failed to fetch Varias: \(error)")
    }
    
    return varias
}

func loadArcs(sort: String, filter: String = "") async -> [Arc] {
    var arcs: [Arc] = []
    
    do {
        arcs = try await supabase
            .from("arcs")
            .select("id, name, serie(*), comments")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Arcs successfully loaded")
    } catch {
        print("Failed to fetch Arcs: \(error)")
    }
    
    return arcs
}

func loadSeries(filter: String = "") async -> [Serie] {
    var series: [Serie] = []
    
    do {
        series = try await supabase
            .from("series")
            .select("*")
            .ilike("name", pattern: "%\(filter)%")
            .order("name")
            .execute()
            .value
        print("Series successfully loaded")
    } catch {
        print("Failed to fetch Series: \(error)")
    }
    
    return series
}

func loadArtists(sort: String, filter: String = "") async -> [Artist] {
    var artists: [Artist] = []
    
    do {
        artists = try await supabase
            .from("artists")
            .select("*")
            .ilike("name", pattern: "%\(filter)%")
            .order(sort)
            .limit(40)
            .execute()
            .value
        print("Artists successfully loaded")
    } catch {
        print("Failed to fetch Artists: \(error)")
    }
    
    return artists
}

func loadSourceCharacters(recordField: String, recordID: UUID) async -> [SourceCharacter] {
    var sourceItems = [SourceCharacter]()
    do {
        sourceItems = try await supabase
            .from("source_characters")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), character!inner(id, name, aliases, species(id, name, homeworld(*), first_appearance, comments), homeworld(*), gender, affiliations, first_appearance, comments), appearance")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourceCharacters successfully loaded")
    } catch {
        print("Failed to fetch SourceCharacters: \(error)")
    }
    return sourceItems
}

func loadSourceCreatures(recordField: String, recordID: UUID) async -> [SourceCreature] {
    var sourceItems = [SourceCreature]()
    do {
        sourceItems = try await supabase
            .from("source_creatures")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), creature!inner(id, name, designation, homeworld(*), first_appearance, comments), appearance")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourceCreatures successfully loaded")
    } catch {
        print("Failed to fetch SourceCreatures: \(error)")
    }
    return sourceItems
}

func loadSourceDroids(recordField: String, recordID: UUID) async -> [SourceDroid] {
    var sourceItems = [SourceDroid]()
    do {
        sourceItems = try await supabase
            .from("source_droids")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), droid!inner(*), appearance")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourceDroids successfully loaded")
    } catch {
        print("Failed to fetch SourceDroids: \(error)")
    }
    return sourceItems
}

func loadSourceOrganizations(recordField: String, recordID: UUID) async -> [SourceOrganization] {
    var sourceItems = [SourceOrganization]()
    do {
        sourceItems = try await supabase
            .from("source_organizations")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), organization!inner(*), appearance")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourceOrganizations successfully loaded")
    } catch {
        print("Failed to fetch SourceOrganizations: \(error)")
    }
    return sourceItems
}

func loadSourcePlanets(recordField: String, recordID: UUID) async -> [SourcePlanet] {
    var sourceItems = [SourcePlanet]()
    do {
        sourceItems = try await supabase
            .from("source_planets")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), planet!inner(*), appearance")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourcePlanets successfully loaded")
    } catch {
        print("Failed to fetch SourcePlanets: \(error)")
    }
    return sourceItems
}

func loadSourceSpecies(recordField: String, recordID: UUID) async -> [SourceSpecies] {
    var sourceItems = [SourceSpecies]()
    do {
        sourceItems = try await supabase
            .from("source_species")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), species!inner(id, name, homeworld(*), first_appearance, comments), appearance")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourceSpecies successfully loaded")
    } catch {
        print("Failed to fetch SourceSpecies: \(error)")
    }
    return sourceItems
}

func loadSourceStarships(recordField: String, recordID: UUID) async -> [SourceStarship] {
    var sourceItems = [SourceStarship]()
    do {
        sourceItems = try await supabase
            .from("source_starships")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), starship!inner(id, name, first_appearance, comments), appearance")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourceStarships successfully loaded")
    } catch {
        print("Failed to fetch SourceStarships: \(error)")
    }
    return sourceItems
}

func loadSourceStarshipModels(recordField: String, recordID: UUID) async -> [SourceStarshipModel] {
    var sourceItems = [SourceStarshipModel]()
    do {
        sourceItems = try await supabase
            .from("source_starship_models")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), starship_model!inner(*), appearance")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourceStarshipModels successfully loaded")
    } catch {
        print("Failed to fetch SourceStarshipModels: \(error)")
    }
    return sourceItems
}

func loadSourceVarias(recordField: String, recordID: UUID) async -> [SourceVaria] {
    var sourceItems = [SourceVaria]()
    do {
        sourceItems = try await supabase
            .from("source_varias")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), varia!inner(*), appearance")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourceVarias successfully loaded")
    } catch {
        print("Failed to fetch SourceVarias: \(error)")
    }
    return sourceItems
}

func loadSourceArtists(recordField: String, recordID: UUID) async -> [SourceArtist] {
    var sourceItems = [SourceArtist]()
    do {
        sourceItems = try await supabase
            .from("source_artists")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), artist!inner(*)")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourceArtists successfully loaded")
    } catch {
        print("Failed to fetch SourceArtists: \(error)")
    }
    return sourceItems
}

func loadSourceAuthors(recordField: String, recordID: UUID) async -> [SourceAuthor] {
    var sourceItems = [SourceAuthor]()
    do {
        sourceItems = try await supabase
            .from("source_authors")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), artist!inner(*)")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("SourceAuthors successfully loaded")
    } catch {
        print("Failed to fetch SourceAuthors: \(error)")
    }
    return sourceItems
}

func loadSourceFacts(recordField: String, recordID: UUID) async -> [Fact] {
    var facts = [Fact]()
    do {
        facts = try await supabase
            .from("facts")
            .select("id, fact, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), keywords")
            .eq(recordField, value: recordID.uuidString)
            .execute()
            .value
        print("Facts successfully loaded")
    } catch {
        print("Failed to fetch Facts: \(error)")
    }
    return facts
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
