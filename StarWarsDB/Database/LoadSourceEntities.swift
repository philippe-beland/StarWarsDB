import Foundation

func loadSourceCharacters(sourceID: UUID) async -> [SourceEntity<Character>] {
    var sourceCharacters = [SourceEntity<Character>]()
    do {
        sourceCharacters = try await supabase
            .rpc("load_sourcecharacters", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceCharacters successfully loaded")
    } catch {
        print("Failed to fetch SourceCharacters: \(error)")
    }
    return sourceCharacters
}

func loadSourceCreatures(sourceID: UUID) async -> [SourceEntity<Creature>] {
    var sourceCreatures = [SourceEntity<Creature>]()
    do {
        sourceCreatures = try await supabase
            .rpc("load_sourcecreatures", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceCreatures successfully loaded")
    } catch {
        print("Failed to fetch SourceCreatures: \(error)")
    }
    return sourceCreatures
}

func loadSourceDroids(sourceID: UUID) async -> [SourceEntity<Droid>] {
    var sourceDroids = [SourceEntity<Droid>]()
    do {
        sourceDroids = try await supabase
            .rpc("load_sourcedroids", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceDroids successfully loaded")
    } catch {
        print("Failed to fetch SourceDroids: \(error)")
    }
    return sourceDroids
}

func loadSourceOrganizations(sourceID: UUID) async -> [SourceEntity<Organization>] {
    var sourceOrganizations = [SourceEntity<Organization>]()
    do {
        sourceOrganizations = try await supabase
            .rpc("load_sourceorganizations", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceOrganizations successfully loaded")
    } catch {
        print("Failed to fetch SourceOrganizations: \(error)")
    }
    return sourceOrganizations
}

func loadSourcePlanets(sourceID: UUID) async -> [SourceEntity<Planet>] {
    var sourcePlanets = [SourceEntity<Planet>]()
    do {
        sourcePlanets = try await supabase
            .rpc("load_sourceplanets", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourcePlanets successfully loaded")
    } catch {
        print("Failed to fetch SourcePlanets: \(error)")
    }
    return sourcePlanets
}

func loadSourceSpecies(sourceID: UUID) async -> [SourceEntity<Species>] {
    var sourceSpecies = [SourceEntity<Species>]()
    do {
        sourceSpecies = try await supabase
            .rpc("load_sourcespecies", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceSpecies successfully loaded")
    } catch {
        print("Failed to fetch SourceSpecies: \(error)")
    }
    return sourceSpecies
}

func loadSourceStarships(sourceID: UUID) async -> [SourceEntity<Starship>] {
    var sourceStarships = [SourceEntity<Starship>]()
    do {
        sourceStarships = try await supabase
            .rpc("load_sourcestarships", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceStarships successfully loaded")
    } catch {
        print("Failed to fetch SourceStarships: \(error)")
    }
    return sourceStarships
}

func loadSourceStarshipModels(sourceID: UUID) async -> [SourceEntity<StarshipModel>] {
    var sourceStarshipModels = [SourceEntity<StarshipModel>]()
    do {
        sourceStarshipModels = try await supabase
            .rpc("load_sourcestarshipmodels", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceStarshipModels successfully loaded")
    } catch {
        print("Failed to fetch SourceStarshipModels: \(error)")
    }
    return sourceStarshipModels
}

func loadSourceVarias(sourceID: UUID) async -> [SourceEntity<Varia>] {
    var sourceVarias = [SourceEntity<Varia>]()
    do {
        sourceVarias = try await supabase
            .rpc("load_sourcevarias", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceVarias successfully loaded")
    } catch {
        print("Failed to fetch SourceVarias: \(error)")
    }
    return sourceVarias
}

func loadSourceArtists(sourceID: UUID) async -> [SourceCreator<Artist>] {
    var sourceArtists = [SourceCreator<Artist>]()
    do {
        sourceArtists = try await supabase
            .from("source_artists")
            .select("""
                    id,
                    source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                    entity!inner(*)
                    """)
            .eq("source", value: sourceID.uuidString)
            .execute()
            .value
        print("SourceArtists successfully loaded")
    } catch {
        print("Failed to fetch SourceArtists: \(error)")
    }
    return sourceArtists
}

func loadSourceAuthors(sourceID: UUID) async -> [SourceCreator<Author>] {
    var sourceAuthors = [SourceCreator<Author>]()
    do {
        sourceAuthors = try await supabase
            .from("source_authors")
            .select("""
                    id, 
                    source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                    entity!inner(*)
                    """)
            .eq("source", value: sourceID.uuidString)
            .execute()
            .value
        print("SourceAuthors successfully loaded")
    } catch {
        print("Failed to fetch SourceAuthors: \(error)")
    }
    return sourceAuthors
}

func loadSourceFacts(entityField: String, sourceID: UUID) async -> [Fact] {
    var facts = [Fact]()
    do {
        facts = try await supabase
            .from("facts")
            .select("id, fact, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), keywords")
            .eq(entityField, value: sourceID.uuidString)
            .execute()
            .value
        print("Facts successfully loaded")
    } catch {
        print("Failed to fetch Facts: \(error)")
    }
    return facts
}
