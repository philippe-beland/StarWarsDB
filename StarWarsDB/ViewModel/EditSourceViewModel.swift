//
//  EditSourceViewModel.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 2/8/25.
//

import Foundation

@MainActor
class EditSourceViewModel: ObservableObject {
    @Published var sourceItems = SourceItemCollection()
    @Published var activeSheet: ActiveSheet?
    var source: Source
    
    init(source: Source) {
        self.source = source
    }
    
    enum SourceError: Error {
        case invalidEntityType
        case duplicateItem
        case saveFailed
    }
    
    private func createSourceItem(entityType: EntityType, entity: Entity, appearance: AppearanceType) -> SourceItem {
        switch entityType {
        case .character:
            return SourceCharacter(source: source, entity: entity as! Character, appearance: appearance)
        case .creature:
            return SourceCreature(source: source, entity: entity as! Creature, appearance: appearance)
        case .droid:
            return SourceDroid(source: source, entity: entity as! Droid, appearance: appearance)
        case .organization:
            return SourceOrganization(source: source, entity: entity as! Organization, appearance: appearance)
        case .planet:
            return SourcePlanet(source: source, entity: entity as! Planet, appearance: appearance)
        case .species:
            return SourceSpecies(source: source, entity: entity as! Species, appearance: appearance)
        case .starship:
            return SourceStarship(source: source, entity: entity as! Starship, appearance: appearance)
        case .starshipModel:
            return SourceStarshipModel(source: source, entity: entity as! StarshipModel, appearance: appearance)
        case .varia:
            return SourceVaria(source: source, entity: entity as! Varia, appearance: appearance)
        default:
            fatalError("Unsupported entity type")
        }
    }
        
    private func saveSourceItem(_ item: SourceItem, entityType: EntityType) throws {
        switch entityType {
            case .character:
                if sourceItems.characters.contains(item as! SourceCharacter) {
                    throw SourceError.duplicateItem
                }
                sourceItems.characters.append(item as! SourceCharacter)
            case .creature:
                if sourceItems.creatures.contains(item as! SourceCreature) {
                    throw SourceError.duplicateItem
                }
                sourceItems.creatures.append(item as! SourceCreature)
            case .droid:
                if sourceItems.droids.contains(item as! SourceDroid) {
                    throw SourceError.duplicateItem
                }
                sourceItems.droids.append(item as! SourceDroid)
            case .organization:
                if sourceItems.organizations.contains(item as! SourceOrganization) {
                    throw SourceError.duplicateItem
                }
                sourceItems.organizations.append(item as! SourceOrganization)
            case .planet:
                if sourceItems.planets.contains(item as! SourcePlanet) {
                    throw SourceError.duplicateItem
                }
                sourceItems.planets.append(item as! SourcePlanet)
            case .species:
                if sourceItems.species.contains(item as! SourceSpecies) {
                    throw SourceError.duplicateItem
                }
                sourceItems.species.append(item as! SourceSpecies)
            case .starship:
                if sourceItems.starships.contains(item as! SourceStarship) {
                    throw SourceError.duplicateItem
                }
                sourceItems.starships.append(item as! SourceStarship)
            case .starshipModel:
                if sourceItems.starshipModels.contains(item as! SourceStarshipModel) {
                    throw SourceError.duplicateItem
                }
                sourceItems.starshipModels.append(item as! SourceStarshipModel)
            case .varia:
                if sourceItems.varias.contains(item as! SourceVaria) {
                    throw SourceError.duplicateItem
                }
                sourceItems.varias.append(item as! SourceVaria)
            default:
                fatalError("Unsupported entity type")
        }
        item.save()
    }

    func addSourceItem(entityType: EntityType, entity: Entity, appearance: AppearanceType) {
        do {
            try validateEntity(entity, type: entityType)
            let newItem = createSourceItem(entityType: entityType, entity: entity, appearance: appearance)
            try saveSourceItem(newItem, entityType: entityType)
        } catch SourceError.duplicateItem {
            print("This item is already in the source")
        } catch {
            print("Failed to add item: \(error.localizedDescription)")
        }
    }
    
    private func validateEntity (_ entity: Entity, type: EntityType) throws {
        guard entity.isValid(for: type) else {
            throw SourceError.invalidEntityType
        }
    }

    func loadInitialSources() async {
        async let characters = loadSourceCharacters(sourceID: source.id)
        async let creatures = loadSourceCreatures(sourceID: source.id)
        async let droids = loadSourceDroids(sourceID: source.id)
        async let organizations = loadSourceOrganizations(sourceID: source.id)
        async let planets = loadSourcePlanets(sourceID: source.id)
        async let species = loadSourceSpecies(sourceID: source.id)
        async let starships = loadSourceStarships(sourceID: source.id)
        async let starshipModels = loadSourceStarshipModels(sourceID: source.id)
        async let varias = loadSourceVarias(sourceID: source.id)
        async let artists = loadSourceArtists(recordID: source.id)
        async let authors = loadSourceAuthors(recordID: source.id)

        sourceItems.characters = await characters
        sourceItems.creatures = await creatures
        sourceItems.droids = await droids
        sourceItems.organizations = await organizations
        sourceItems.planets = await planets
        sourceItems.species = await species
        sourceItems.starships = await starships
        sourceItems.starshipModels = await starshipModels
        sourceItems.varias = await varias
        sourceItems.artists = await artists
        sourceItems.authors = await authors
    }
}
