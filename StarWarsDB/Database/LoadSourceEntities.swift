import Foundation

func loadSourceCharacters(sourceID: UUID) async -> [SourceEntity<Character>] {
    var sourceEntities = [SourceEntity<Character>]()
    do {
        sourceEntities = try await supabase
            .rpc("load_sourcecharacters", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceCharacters successfully loaded")
    } catch {
        print("Failed to fetch SourceCharacters: \(error)")
    }
    return sourceEntities
}

func loadSourceCreatures(sourceID: UUID) async -> [SourceEntity<Creature>] {
    var sourceEntities = [SourceEntity<Creature>]()
    do {
        sourceEntities = try await supabase
            .rpc("load_sourcecreatures", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceCreatures successfully loaded")
    } catch {
        print("Failed to fetch SourceCreatures: \(error)")
    }
    return sourceEntities
}

func loadSourceDroids(sourceID: UUID) async -> [SourceEntity<Droid>] {
    var sourceEntities = [SourceEntity<Droid>]()
    do {
        sourceEntities = try await supabase
            .rpc("load_sourcedroids", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceDroids successfully loaded")
    } catch {
        print("Failed to fetch SourceDroids: \(error)")
    }
    return sourceEntities
}

func loadSourceOrganizations(sourceID: UUID) async -> [SourceEntity<Organization>] {
    var sourceEntities = [SourceEntity<Organization>]()
    do {
        sourceEntities = try await supabase
            .rpc("load_sourceorganizations", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceOrganizations successfully loaded")
    } catch {
        print("Failed to fetch SourceOrganizations: \(error)")
    }
    return sourceEntities
}

func loadSourcePlanets(sourceID: UUID) async -> [SourceEntity<Planet>] {
    var sourceEntities = [SourceEntity<Planet>]()
    do {
        sourceEntities = try await supabase
            .rpc("load_sourceplanets", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourcePlanets successfully loaded")
    } catch {
        print("Failed to fetch SourcePlanets: \(error)")
    }
    return sourceEntities
}

func loadSourceSpecies(sourceID: UUID) async -> [SourceEntity<Species>] {
    var sourceEntities = [SourceEntity<Species>]()
    do {
        sourceEntities = try await supabase
            .rpc("load_sourcespecies", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceSpecies successfully loaded")
    } catch {
        print("Failed to fetch SourceSpecies: \(error)")
    }
    return sourceEntities
}

func loadSourceStarships(sourceID: UUID) async -> [SourceEntity<Starship>] {
    var sourceEntities = [SourceEntity<Starship>]()
    do {
        sourceEntities = try await supabase
            .rpc("load_sourcestarships", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceStarships successfully loaded")
    } catch {
        print("Failed to fetch SourceStarships: \(error)")
    }
    return sourceEntities
}

func loadSourceStarshipModels(sourceID: UUID) async -> [SourceEntity<StarshipModel>] {
    var sourceEntities = [SourceEntity<StarshipModel>]()
    do {
        sourceEntities = try await supabase
            .rpc("load_sourcestarshipmodels", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceStarshipModels successfully loaded")
    } catch {
        print("Failed to fetch SourceStarshipModels: \(error)")
    }
    return sourceEntities
}

func loadSourceVarias(sourceID: UUID) async -> [SourceEntity<Varia>] {
    var sourceEntities = [SourceEntity<Varia>]()
    do {
        sourceEntities = try await supabase
            .rpc("load_sourcevarias", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceVarias successfully loaded")
    } catch {
        print("Failed to fetch SourceVarias: \(error)")
    }
    return sourceEntities
}

func loadSourceArtists(sourceID: UUID) async -> [SourceEntity<Artist>] {
    var sourceEntities = [SourceEntity<Artist>]()
    do {
        sourceEntities = try await supabase
            .from("source_artists")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), artist!inner(*)")
            .eq("source", value: sourceID.uuidString)
            .execute()
            .value
        print("SourceArtists successfully loaded")
    } catch {
        print("Failed to fetch SourceArtists: \(error)")
    }
    return sourceEntities
}

func loadSourceAuthors(sourceID: UUID) async -> [SourceEntity<Author>] {
    var sourceEntities = [SourceEntity<Author>]()
    do {
        sourceEntities = try await supabase
            .from("source_authors")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), artist!inner(*)")
            .eq("source", value: sourceID.uuidString)
            .execute()
            .value
        print("SourceAuthors successfully loaded")
    } catch {
        print("Failed to fetch SourceAuthors: \(error)")
    }
    return sourceEntities
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
