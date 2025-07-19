import Foundation

@MainActor
class EditSourceViewModel: ObservableObject {
    @Published var sourceEntities = SourceEntityCollection()
    @Published var activeSheet: ActiveSheet?
    var source: Source
    
    init(source: Source) {
        self.source = source
    }
    
    enum SourceError: Error {
        case invalidEntityType
        case duplicateEntity
        case saveFailed
    }
    
    private func createSourceEntity<T: Entity>(entity: T, appearance: AppearanceType) -> SourceEntity<T> {
        return SourceEntity<T>(source: source, entity: entity, appearance: appearance)
    }
        
    private func saveSourceEntity<T: Entity>(_ sourceEntity: SourceEntity<T>) throws {      
        if let characterEntity = sourceEntity as? SourceEntity<Character> {
        if sourceEntities.characters.contains(where: { $0.entity.id == characterEntity.entity.id }) {
            throw SourceError.duplicateEntity
        }
        sourceEntities.characters.append(characterEntity)
        } else if let creatureEntity = sourceEntity as? SourceEntity<Creature> {
            if sourceEntities.creatures.contains(where: { $0.entity.id == creatureEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            sourceEntities.creatures.append(creatureEntity)
        } else if let droidEntity = sourceEntity as? SourceEntity<Droid> {
            if sourceEntities.droids.contains(where: { $0.entity.id == droidEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            sourceEntities.droids.append(droidEntity)
        } else if let organizationEntity = sourceEntity as? SourceEntity<Organization> {
            if sourceEntities.organizations.contains(where: { $0.entity.id == organizationEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            sourceEntities.organizations.append(organizationEntity)
        } else if let planetEntity = sourceEntity as? SourceEntity<Planet> {
            if sourceEntities.planets.contains(where: { $0.entity.id == planetEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            sourceEntities.planets.append(planetEntity)
        } else if let speciesEntity = sourceEntity as? SourceEntity<Species> {
            if sourceEntities.species.contains(where: { $0.entity.id == speciesEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            sourceEntities.species.append(speciesEntity)
        } else if let starshipEntity = sourceEntity as? SourceEntity<Starship> {
            if sourceEntities.starships.contains(where: { $0.entity.id == starshipEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            sourceEntities.starships.append(starshipEntity)
        } else if let starshipModelEntity = sourceEntity as? SourceEntity<StarshipModel> {
            if sourceEntities.starshipModels.contains(where: { $0.entity.id == starshipModelEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            sourceEntities.starshipModels.append(starshipModelEntity)
        } else if let variaEntity = sourceEntity as? SourceEntity<Varia> {
            if sourceEntities.varias.contains(where: { $0.entity.id == variaEntity.entity.id }) {
                throw SourceError.duplicateEntity
            }
            sourceEntities.varias.append(variaEntity)
        } else {
            fatalError("Unsupported entity type")
        }
        
        sourceEntity.save()
    }

    func addSourceEntity<T: Entity>(entity: T, appearance: AppearanceType) {
        do {
            let newEntity = createSourceEntity(entity: entity, appearance: appearance)
            try saveSourceEntity(newEntity)
        } catch SourceError.duplicateEntity {
            print("This sourceEntity is already in the source")
        } catch {
            print("Failed to add SourceEntity: \(error.localizedDescription)")
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
        async let artists = loadSourceArtists(sourceID: source.id)
        async let authors = loadSourceAuthors(sourceID: source.id)

        sourceEntities.characters = await characters
        sourceEntities.creatures = await creatures
        sourceEntities.droids = await droids
        sourceEntities.organizations = await organizations
        sourceEntities.planets = await planets
        sourceEntities.species = await species
        sourceEntities.starships = await starships
        sourceEntities.starshipModels = await starshipModels
        sourceEntities.varias = await varias
        sourceEntities.artists = await artists
        sourceEntities.authors = await authors
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
        } else if let varia = entity as? Varia {
            addSourceEntity(entity: varia, appearance: appearance)
        }
    }
}
