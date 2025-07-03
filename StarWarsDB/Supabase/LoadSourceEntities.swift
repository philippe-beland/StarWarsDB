import Foundation

func loadSourceCharacters(sourceID: UUID) async -> [SourceCharacter] {
    var sourceEntities = [SourceCharacter]()
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

func loadSourceCreatures(sourceID: UUID) async -> [SourceCreature] {
    var sourceEntities = [SourceCreature]()
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

func loadSourceDroids(sourceID: UUID) async -> [SourceDroid] {
    var sourceEntities = [SourceDroid]()
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

func loadSourceOrganizations(sourceID: UUID) async -> [SourceOrganization] {
    var sourceEntities = [SourceOrganization]()
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

func loadSourcePlanets(sourceID: UUID) async -> [SourcePlanet] {
    var sourceEntities = [SourcePlanet]()
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

func loadSourceSpecies(sourceID: UUID) async -> [SourceSpecies] {
    var sourceEntities = [SourceSpecies]()
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

func loadSourceStarships(sourceID: UUID) async -> [SourceStarship] {
    var sourceEntities = [SourceStarship]()
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

func loadSourceStarshipModels(sourceID: UUID) async -> [SourceStarshipModel] {
    var sourceEntities = [SourceStarshipModel]()
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

func loadSourceVarias(sourceID: UUID) async -> [SourceVaria] {
    var sourceEntities = [SourceVaria]()
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

func loadSourceArtists(sourceID: UUID) async -> [SourceArtist] {
    var sourceEntities = [SourceArtist]()
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

func loadSourceAuthors(sourceID: UUID) async -> [SourceAuthor] {
    var sourceEntities = [SourceAuthor]()
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
