import Foundation

@MainActor
@Observable
final class EditSourceViewModel {
    var characters: [SourceEntity<Character>] = []
    var creatures: [SourceEntity<Creature>] = []
    var droids: [SourceEntity<Droid>] = []
    var organizations: [SourceEntity<Organization>] = []
    var planets: [SourceEntity<Planet>] = []
    var species: [SourceEntity<Species>] = []
    var starships: [SourceEntity<Starship>] = []
    var starshipModels: [SourceEntity<StarshipModel>] = []
    var misc: [SourceEntity<Misc>] = []
    var artists: [SourceCreator<Artist>] = []
    var authors: [SourceCreator<Author>] = []
    var activeSheet: ActiveSheet?
    var source: Source
    
    init(source: Source) {
        self.source = source
    }
    
    enum SourceError: Error {
        case invalidEntityType
        case duplicateEntity
        case saveFailed
    }
    
    private func createSourceEntity<T: TrackableEntity>(entity: T, appearance: AppearanceType) -> SourceEntity<T> {
        return SourceEntity<T>(source: source, entity: entity, appearance: appearance)
    }
    
    private func createSourceCreator<T: CreatorEntity>(creator: T) -> SourceCreator<T> {
        return SourceCreator<T>(source: source, creator: creator)
    }
        
    private func saveSourceEntity<T: Entity>(_ sourceEntity: SourceEntity<T>) throws {      
        if let characterEntity = sourceEntity as? SourceEntity<Character> {
        if characters.contains(where: { $0.entity.id == characterEntity.entity.id }) {
            throw SourceError.duplicateEntity
        }
        characters.append(characterEntity)
        } else if let creatureEntity = sourceEntity as? SourceEntity<Creature> {
            if creatures.contains(where: { $0.entity.id == creatureEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            creatures.append(creatureEntity)
        } else if let droidEntity = sourceEntity as? SourceEntity<Droid> {
            if droids.contains(where: { $0.entity.id == droidEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            droids.append(droidEntity)
        } else if let organizationEntity = sourceEntity as? SourceEntity<Organization> {
            if organizations.contains(where: { $0.entity.id == organizationEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            organizations.append(organizationEntity)
        } else if let planetEntity = sourceEntity as? SourceEntity<Planet> {
            if planets.contains(where: { $0.entity.id == planetEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            planets.append(planetEntity)
        } else if let speciesEntity = sourceEntity as? SourceEntity<Species> {
            if species.contains(where: { $0.entity.id == speciesEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            species.append(speciesEntity)
        } else if let starshipEntity = sourceEntity as? SourceEntity<Starship> {
            if starships.contains(where: { $0.entity.id == starshipEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            starships.append(starshipEntity)
        } else if let starshipModelEntity = sourceEntity as? SourceEntity<StarshipModel> {
            if starshipModels.contains(where: { $0.entity.id == starshipModelEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            starshipModels.append(starshipModelEntity)
        } else if let miscEntity = sourceEntity as? SourceEntity<Misc> {
            if misc.contains(where: { $0.entity.id == miscEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            misc.append(miscEntity)
        } else {
            fatalError("Unsupported entity type")
        }
        
        sourceEntity.save()
    }

    func addSourceEntity<T: TrackableEntity>(entity: T, appearance: AppearanceType) {
        do {
            let newEntity = createSourceEntity(entity: entity, appearance: appearance)
            try saveSourceEntity(newEntity)
        } catch SourceError.duplicateEntity {
            appLogger.info("This sourceEntity is already in the source")
        } catch {
            appLogger.error("Failed to add SourceEntity: \(error.localizedDescription)")
        }
    }
    
//    func addSourceCreator<T: CreatorEntity>(creator: T) {
//        do {
//            let newCreator = createSourceCreator(creator: creator)
//            try saveSourceEntity(newCreator)
//        } catch SourceError.duplicateEntity {
//            appLogger.info("This sourceEntity is already in the source")
//        } catch {
//            appLogger.error("Failed to add SourceEntity: \(error.localizedDescription)")
//        }
//    }

    func loadInitialSources() async {
        async let _characters = loadSourceCharacters(sourceID: source.id)
        async let _creatures = loadSourceCreatures(sourceID: source.id)
        async let _droids = loadSourceDroids(sourceID: source.id)
        async let _organizations = loadSourceOrganizations(sourceID: source.id)
        async let _planets = loadSourcePlanets(sourceID: source.id)
        async let _species = loadSourceSpecies(sourceID: source.id)
        async let _starships = loadSourceStarships(sourceID: source.id)
        async let _starshipModels = loadSourceStarshipModels(sourceID: source.id)
        async let _misc = loadSourceMisc(sourceID: source.id)
        async let _artists = loadSourceArtists(sourceID: source.id)
        async let _authors = loadSourceAuthors(sourceID: source.id)
        

        characters = await _characters
        creatures = await _creatures
        droids = await _droids
        organizations = await _organizations
        planets = await _planets
        species = await _species
        starships = await _starships
        starshipModels = await _starshipModels
        misc = await _misc
        artists = await _artists
        authors = await _authors
    }

    func addAnyEntity(_ entity: any Entity, appearance: AppearanceType) {
        // Handle the type checking inside the view model
        if let character = entity as? Character {
            addSourceEntity(entity: character, appearance: appearance)
        } else if let droid = entity as? Droid {
            addSourceEntity(entity: droid, appearance: appearance)
        } else if let creature = entity as? Creature {
            addSourceEntity(entity: creature, appearance: appearance)
        } else if let organization = entity as? Organization {
            addSourceEntity(entity: organization, appearance: appearance)
        } else if let planet = entity as? Planet {
            addSourceEntity(entity: planet, appearance: appearance)
        } else if let species = entity as? Species {
            addSourceEntity(entity: species, appearance: appearance)
        } else if let starship = entity as? Starship {
            addSourceEntity(entity: starship, appearance: appearance)
        } else if let starshipModel = entity as? StarshipModel {
            addSourceEntity(entity: starshipModel, appearance: appearance)
        } else if let misc = entity as? Misc {
            addSourceEntity(entity: misc, appearance: appearance)
        }
    }
}
