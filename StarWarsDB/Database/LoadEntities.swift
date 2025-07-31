import Foundation

struct LoadCharactersParams: Encodable {
    let series_id: UUID?
    let filter: String
}

func loadCharacters(serie: Serie? = nil, filter: String = "")
    async -> [Character]
{
    var characters: [Character] = []

    do {
        let params = LoadCharactersParams(series_id: serie?.id, filter: filter)

        characters =
            try await supabase
                .rpc("load_characters", params: ["input": params])
                .limit(40)
                .execute()
                .value
        databaseLogger.info("Characters successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Characters: \(error)")
    }

    return characters
}

func loadCreatures(serie: Serie? = nil, filter: String = "") async
    -> [Creature]
{
    var creatures: [Creature] = []

    do {
        creatures =
            try await supabase
                .rpc("load_creatures", params: ["series_id": serie?.id])
                .ilike("name", pattern: "%\(filter)%")
                .limit(40)
                .execute()
                .value
        databaseLogger.info("Creatures successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Creatures: \(error)")
    }

    return creatures
}

func loadDroids(serie: Serie? = nil, filter: String = "") async
    -> [Droid]
{
    var droids: [Droid] = []

    do {
        droids =
            try await supabase
                .rpc("load_droids", params: ["series_id": serie?.id])
                .ilike("name", pattern: "%\(filter)%")
                .limit(40)
                .execute()
                .value
        databaseLogger.info("Droids successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Droids: \(error)")
    }

    return droids
}

func loadOrganizations(serie: Serie? = nil, filter: String = "")
    async -> [Organization]
{
    var organizations: [Organization] = []

    do {
        organizations =
            try await supabase
                .rpc("load_organizations", params: ["series_id": serie?.id])
                .ilike("name", pattern: "%\(filter)%")
                .limit(40)
                .execute()
                .value
        databaseLogger.info("Organizations successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Organizations: \(error)")
    }

    return organizations
}

func loadPlanets(serie: Serie? = nil, filter: String = "") async
    -> [Planet]
{
    var planets: [Planet] = []

    do {
        planets =
            try await supabase
                .rpc("load_planets", params: ["series_id": serie?.id])
                .ilike("name", pattern: "%\(filter)%")
                .limit(40)
                .execute()
                .value
        databaseLogger.info("Planets successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Planets: \(error)")
    }

    return planets
}

func loadSpecies(serie: Serie? = nil, filter: String = "") async
    -> [Species]
{
    var species: [Species] = []

    do {
        species =
            try await supabase
                .rpc("load_species", params: ["series_id": serie?.id])
                .ilike("name", pattern: "%\(filter)%")
                .limit(40)
                .execute()
                .value
        databaseLogger.info("Species successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Species: \(error)")
    }

    return species
}

func loadStarships(serie: Serie? = nil, filter: String = "") async
    -> [Starship]
{
    var starships: [Starship] = []

    do {
        starships =
            try await supabase
                .rpc("load_starships", params: ["series_id": serie?.id])
                .ilike("name", pattern: "%\(filter)%")
                .limit(40)
                .execute()
                .value
        databaseLogger.info("Starships successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Starships: \(error)")
    }

    return starships
}

func loadStarshipModels(serie: Serie? = nil, filter: String = "")
    async -> [StarshipModel]
{
    var starshipModels: [StarshipModel] = []

    do {
        starshipModels =
            try await supabase
                .rpc("load_starship_models", params: ["series_id": serie?.id])
                .ilike("name", pattern: "%\(filter)%")
                .limit(40)
                .execute()
                .value
        databaseLogger.info("StarshipModels successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch StarshipModels: \(error)")
    }

    return starshipModels
}

func loadMisc(serie: Serie? = nil, filter: String = "") async
    -> [Misc]
{
    var misc: [Misc] = []

    do {
        misc =
            try await supabase
                .rpc("load_misc", params: ["series_id": serie?.id])
                .ilike("name", pattern: "%\(filter)%")
                .limit(40)
                .execute()
                .value
            databaseLogger.info("Misc successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Misc: \(error)")
    }

    return misc
}

func loadArcs(filter: String = "") async -> [Arc] {
    var arcs: [Arc] = []

    do {
        arcs =
            try await supabase
                .from("arcs")
                .select("id, name, serie(*), comments")
                .ilike("name", pattern: "%\(filter)%")
                .order("name")
                .limit(40)
                .execute()
                .value
        databaseLogger.info("Arcs successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Arcs: \(error)")
    }

    return arcs
}

func loadSeries(filter: String = "") async -> [Serie] {
    var series: [Serie] = []

    do {
        series =
            try await supabase
                .from("series")
                .select("*")
                .ilike("name", pattern: "%\(filter)%")
                .order("name")
                .execute()
                .value
        databaseLogger.info("Series successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Series: \(error)")
    }

    return series
}

func loadArtists(serie: Serie? = nil, filter: String = "") async -> [Artist] {
    var artists: [Artist] = []

    do {
        artists =
            try await supabase
                .from("artists")
                .select("*")
                .ilike("name", pattern: "%\(filter)%")
                .limit(40)
                .execute()
                .value
        databaseLogger.info("Artists successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Artists: \(error)")
    }

    return artists
}

func loadAuthors(serie: Serie? = nil, filter: String = "") async -> [Author] {
    var authors: [Author] = []

    do {
        authors =
            try await supabase
                .from("artists")
                .select("*")
                .ilike("name", pattern: "%\(filter)%")
                .limit(40)
                .execute()
                .value
        databaseLogger.info("Artists successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch Authors: \(error)")
    }

    return authors
}
