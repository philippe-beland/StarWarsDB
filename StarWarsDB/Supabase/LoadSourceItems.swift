import Foundation

func loadSourceCharacters(sourceID: UUID) async -> [SourceCharacter] {
    var sourceItems = [SourceCharacter]()
    do {
        sourceItems = try await supabase
            .rpc("load_sourcecharacters", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceCharacters successfully loaded")
    } catch {
        print("Failed to fetch SourceCharacters: \(error)")
    }
    return sourceItems
}

func loadSourceCreatures(sourceID: UUID) async -> [SourceCreature] {
    var sourceItems = [SourceCreature]()
    do {
        sourceItems = try await supabase
            .rpc("load_sourcecreatures", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceCreatures successfully loaded")
    } catch {
        print("Failed to fetch SourceCreatures: \(error)")
    }
    return sourceItems
}

func loadSourceDroids(sourceID: UUID) async -> [SourceDroid] {
    var sourceItems = [SourceDroid]()
    do {
        sourceItems = try await supabase
            .rpc("load_sourcedroids", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceDroids successfully loaded")
    } catch {
        print("Failed to fetch SourceDroids: \(error)")
    }
    return sourceItems
}

func loadSourceOrganizations(sourceID: UUID) async -> [SourceOrganization] {
    var sourceItems = [SourceOrganization]()
    do {
        sourceItems = try await supabase
            .rpc("load_sourceorganizations", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceOrganizations successfully loaded")
    } catch {
        print("Failed to fetch SourceOrganizations: \(error)")
    }
    return sourceItems
}

func loadSourcePlanets(sourceID: UUID) async -> [SourcePlanet] {
    var sourceItems = [SourcePlanet]()
    do {
        sourceItems = try await supabase
            .rpc("load_sourceplanets", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourcePlanets successfully loaded")
    } catch {
        print("Failed to fetch SourcePlanets: \(error)")
    }
    return sourceItems
}

func loadSourceSpecies(sourceID: UUID) async -> [SourceSpecies] {
    var sourceItems = [SourceSpecies]()
    do {
        sourceItems = try await supabase
            .rpc("load_sourcespecies", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceSpecies successfully loaded")
    } catch {
        print("Failed to fetch SourceSpecies: \(error)")
    }
    return sourceItems
}

func loadSourceStarships(sourceID: UUID) async -> [SourceStarship] {
    var sourceItems = [SourceStarship]()
    do {
        sourceItems = try await supabase
            .rpc("load_sourcestarships", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceStarships successfully loaded")
    } catch {
        print("Failed to fetch SourceStarships: \(error)")
    }
    return sourceItems
}

func loadSourceStarshipModels(sourceID: UUID) async -> [SourceStarshipModel] {
    var sourceItems = [SourceStarshipModel]()
    do {
        sourceItems = try await supabase
            .rpc("load_sourcestarshipmodels", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceStarshipModels successfully loaded")
    } catch {
        print("Failed to fetch SourceStarshipModels: \(error)")
    }
    return sourceItems
}

func loadSourceVarias(sourceID: UUID) async -> [SourceVaria] {
    var sourceItems = [SourceVaria]()
    do {
        sourceItems = try await supabase
            .rpc("load_sourcevarias", params: ["source_id": sourceID])
            .execute()
            .value
        print("SourceVarias successfully loaded")
    } catch {
        print("Failed to fetch SourceVarias: \(error)")
    }
    return sourceItems
}

func loadSourceArtists(recordID: UUID) async -> [SourceArtist] {
    var sourceItems = [SourceArtist]()
    do {
        sourceItems = try await supabase
            .from("source_artists")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), artist!inner(*)")
            .eq("source", value: recordID.uuidString)
            .execute()
            .value
        print("SourceArtists successfully loaded")
    } catch {
        print("Failed to fetch SourceArtists: \(error)")
    }
    return sourceItems
}

func loadSourceAuthors(recordID: UUID) async -> [SourceAuthor] {
    var sourceItems = [SourceAuthor]()
    do {
        sourceItems = try await supabase
            .from("source_authors")
            .select("id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), artist!inner(*)")
            .eq("source", value: recordID.uuidString)
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
