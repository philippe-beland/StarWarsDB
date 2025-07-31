//
//  LoadItemsSource.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2/8/25.
//

import Foundation

func loadCharacterSources(characterID: UUID) async -> [SourceCharacter] {
    var sourceItems = [SourceCharacter]()
    do {
        sourceItems =
            try await supabase
            .from("source_characters")
            .select(
                "id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), entity!inner(id, name, aliases, species(id, name, homeworld(*), first_appearance, comments), homeworld(*), gender, affiliations, first_appearance, comments), appearance"
            )
            .eq("entity", value: characterID.uuidString)
            .execute()
            .value
        print("SourceCharacters successfully loaded")
    } catch {
        print("Failed to fetch SourceCharacters: \(error)")
    }
    return sourceItems
}

func loadCreatureSources(creatureID: UUID) async -> [SourceCreature] {
    var sourceItems = [SourceCreature]()
    do {
        sourceItems =
            try await supabase
            .from("source_creatures")
            .select(
                "id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), entity!inner(id, name, designation, homeworld(*), first_appearance, comments), appearance"
            )
            .eq("entity", value: creatureID.uuidString)
            .execute()
            .value
        print("SourceCreatures successfully loaded")
    } catch {
        print("Failed to fetch SourceCreatures: \(error)")
    }
    return sourceItems
}

func loadDroidSources(droidID: UUID) async -> [SourceDroid] {
    var sourceItems = [SourceDroid]()
    do {
        sourceItems =
            try await supabase
            .from("source_droids")
            .select(
                "id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), entity!inner(*), appearance"
            )
            .eq("entity", value: droidID.uuidString)
            .execute()
            .value
        print("SourceDroids successfully loaded")
    } catch {
        print("Failed to fetch SourceDroids: \(error)")
    }
    return sourceItems
}

func loadOrganizationSources(organizationID: UUID) async -> [SourceOrganization]
{
    var sourceItems = [SourceOrganization]()
    do {
        sourceItems =
            try await supabase
            .from("source_organizations")
            .select(
                "id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), entity!inner(*), appearance"
            )
            .eq("entity", value: organizationID.uuidString)
            .execute()
            .value
        print("SourceOrganizations successfully loaded")
    } catch {
        print("Failed to fetch SourceOrganizations: \(error)")
    }
    return sourceItems
}

func loadPlanetSources(planetID: UUID) async -> [SourcePlanet] {
    var sourceItems = [SourcePlanet]()
    do {
        sourceItems =
            try await supabase
            .from("source_planets")
            .select(
                "id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), entity!inner(*), appearance"
            )
            .eq("entity", value: planetID.uuidString)
            .execute()
            .value
        print("SourcePlanets successfully loaded")
    } catch {
        print("Failed to fetch SourcePlanets: \(error)")
    }
    return sourceItems
}

func loadSpeciesSources(speciesID: UUID) async -> [SourceSpecies] {
    var sourceItems = [SourceSpecies]()
    do {
        sourceItems =
            try await supabase
            .from("source_species")
            .select(
                "id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), entity!inner(id, name, homeworld(*), first_appearance, comments), appearance"
            )
            .eq("entity", value: speciesID.uuidString)
            .execute()
            .value
        print("SourceSpecies successfully loaded")
    } catch {
        print("Failed to fetch SourceSpecies: \(error)")
    }
    return sourceItems
}

func loadStarshipSources(starshipID: UUID) async -> [SourceStarship] {
    var sourceItems = [SourceStarship]()
    do {
        sourceItems =
            try await supabase
            .from("source_starships")
            .select(
                "id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), entity!inner(id, name, first_appearance, comments), appearance"
            )
            .eq("entity", value: starshipID.uuidString)
            .execute()
            .value
        print("SourceStarships successfully loaded")
    } catch {
        print("Failed to fetch SourceStarships: \(error)")
    }
    return sourceItems
}

func loadStarshipModelSources(starshipModelID: UUID) async
    -> [SourceStarshipModel]
{
    var sourceItems = [SourceStarshipModel]()
    do {
        sourceItems =
            try await supabase
            .from("source_starship_models")
            .select(
                "id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), entity!inner(*), appearance"
            )
            .eq("entity", value: starshipModelID.uuidString)
            .execute()
            .value
        print("SourceStarshipModels successfully loaded")
    } catch {
        print("Failed to fetch SourceStarshipModels: \(error)")
    }
    return sourceItems
}

func loadVariaSources(variaID: UUID) async -> [SourceVaria] {
    var sourceItems = [SourceVaria]()
    do {
        sourceItems =
            try await supabase
            .from("source_varias")
            .select(
                "id, source!inner(id, name, serie(*), number, arc(id, name, serie(*), comments), era, source_type, publication_date, universe_year, number_pages, is_done, comments), entity!inner(*), appearance"
            )
            .eq("entity", value: variaID.uuidString)
            .execute()
            .value
        print("SourceVarias successfully loaded")
    } catch {
        print("Failed to fetch SourceVarias: \(error)")
    }
    return sourceItems
}
