import Foundation

func loadCharacterSources(characterID: UUID) async -> [SourceEntity<Character>] {
    var sourceEntities = [SourceEntity<Character>]()
    do {
        sourceEntities =
            try await supabase
            .from("source_characters")
            .select(
                """
                id, 
                source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                entity!inner(id, name, aliases, species(id, name, homeworld(*), first_appearance, comments), homeworld(*), gender, affiliations, first_appearance, comments), 
                appearance
                """
            )
            .eq("entity", value: characterID.uuidString)
            .execute()
            .value
        databaseLogger.info("SourceCharacters successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch SourceCharacters: \(error)")
    }
    return sourceEntities
}

func loadCreatureSources(creatureID: UUID) async -> [SourceEntity<Creature>] {
    var sourceEntities = [SourceEntity<Creature>]()
    do {
        sourceEntities =
            try await supabase
            .from("source_creatures")
            .select(
                """
                id, 
                source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                entity!inner(id, name, designation, homeworld(*), first_appearance, comments), 
                appearance
                """
            )
            .eq("entity", value: creatureID.uuidString)
            .execute()
            .value
        databaseLogger.info("SourceCreatures successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch SourceCreatures: \(error)")
    }
    return sourceEntities
}

func loadDroidSources(droidID: UUID) async -> [SourceEntity<Droid>] {
    var sourceEntities = [SourceEntity<Droid>]()
    do {
        sourceEntities =
            try await supabase
            .from("source_droids")
            .select(
                """
                id, 
                source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                entity!inner(*), 
                appearance
                """
            )
            .eq("entity", value: droidID.uuidString)
            .execute()
            .value
        databaseLogger.info("SourceDroids successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch SourceDroids: \(error)")
    }
    return sourceEntities
}

func loadOrganizationSources(organizationID: UUID) async -> [SourceEntity<Organization>]
{
    var sourceEntities = [SourceEntity<Organization>]()
    do {
        sourceEntities =
            try await supabase
            .from("source_organizations")
            .select(
                """
                id, 
                source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                entity!inner(*), 
                appearance
                """
            )
            .eq("entity", value: organizationID.uuidString)
            .execute()
            .value
        databaseLogger.info("SourceOrganizations successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch SourceOrganizations: \(error)")
    }
    return sourceEntities
}

func loadPlanetSources(planetID: UUID) async -> [SourceEntity<Planet>] {
    var sourceEntities = [SourceEntity<Planet>]()
    do {
        sourceEntities =
            try await supabase
            .from("source_planets")
            .select(
                """
                id, 
                source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                entity!inner(*), 
                appearance
                """
            )
            .eq("entity", value: planetID.uuidString)
            .execute()
            .value
        databaseLogger.info("SourcePlanets successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch SourcePlanets: \(error)")
    }
    return sourceEntities
}

func loadSpeciesSources(speciesID: UUID) async -> [SourceEntity<Species>] {
    var sourceEntities = [SourceEntity<Species>]()
    do {
        sourceEntities =
            try await supabase
            .from("source_species")
            .select(
                """
                id, 
                source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                entity!inner(id, name, homeworld(*), first_appearance, comments), 
                appearance
                """
            )
            .eq("entity", value: speciesID.uuidString)
            .execute()
            .value
        databaseLogger.info("SourceSpecies successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch SourceSpecies: \(error)")
    }
    return sourceEntities
}

func loadStarshipSources(starshipID: UUID) async -> [SourceEntity<Starship>] {
    var sourceEntities = [SourceEntity<Starship>]()
    do {
        sourceEntities =
            try await supabase
            .from("source_starships")
            .select(
                """
                id, 
                source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                entity!inner(id, name, first_appearance, comments), 
                appearance
                """
            )
            .eq("entity", value: starshipID.uuidString)
            .execute()
            .value
        databaseLogger.info("SourceStarships successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch SourceStarships: \(error)")
    }
    return sourceEntities
}

func loadStarshipModelSources(starshipModelID: UUID) async
    -> [SourceEntity<StarshipModel>]
{
    var sourceEntities = [SourceEntity<StarshipModel>]()
    do {
        sourceEntities =
            try await supabase
            .from("source_starship_models")
            .select(
                """
                id, 
                source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                entity!inner(*), 
                appearance
                """
            )
            .eq("entity", value: starshipModelID.uuidString)
            .execute()
            .value
        databaseLogger.info("SourceStarshipModels successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch SourceStarshipModels: \(error)")
    }
    return sourceEntities
}

func loadMiscSources(miscID: UUID) async -> [SourceEntity<Misc>] {
    var sourceEntities = [SourceEntity<Misc>]()
    do {
        sourceEntities =
            try await supabase
            .from("source_misc")
            .select(
                """
                id, 
                source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), 
                entity!inner(*), 
                appearance
                """
            )
            .eq("entity", value: miscID.uuidString)
            .execute()
            .value
        databaseLogger.info("SourceMisc successfully loaded")
    } catch {
        databaseLogger.error("Failed to fetch SourceMisc: \(error)")
    }
    return sourceEntities
}
