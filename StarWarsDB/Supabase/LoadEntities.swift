//
//  LoadEntities.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2/8/25.
//

import Foundation

struct LoadCharactersParams: Encodable {
    let series_id: UUID?
    let filter: String
}

func loadCharacters(serie: Serie? = nil, sort: String, filter: String = "") async -> [Character] {
    var characters: [Character] = []
    
    do {
        let params = LoadCharactersParams(series_id: serie?.id, filter: filter)
        
        characters = try await supabase
            .rpc("load_characters", params: ["input": params])
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
            .rpc("load_creatures", params: ["series_id": serie?.id])
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
            .rpc("load_droids", params: ["series_id": serie?.id])
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
            .rpc("load_organizations", params: ["series_id": serie?.id])
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
            .rpc("load_planets", params: ["series_id": serie?.id])
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
            .rpc("load_species", params: ["series_id": serie?.id])
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
            .rpc("load_starships", params: ["series_id": serie?.id])
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
            .rpc("load_starship_models", params: ["series_id": serie?.id])
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
