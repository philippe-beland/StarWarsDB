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
    
    private func createSourceEntity(entityType: EntityType, entity: Entity, appearance: AppearanceType) -> SourceEntity {
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
        
    private func saveSourceEntity(_ sourceEntity: SourceEntity, entityType: EntityType) throws {
        switch entityType {
            case .character:
                if sourceEntities.characters.contains(sourceEntity as! SourceCharacter) {
                    throw SourceError.duplicateEntity
                }
                sourceEntities.characters.append(sourceEntity as! SourceCharacter)
            case .creature:
                if sourceEntities.creatures.contains(sourceEntity as! SourceCreature) {
                    throw SourceError.duplicateEntity
                }
                sourceEntities.creatures.append(sourceEntity as! SourceCreature)
            case .droid:
                if sourceEntities.droids.contains(sourceEntity as! SourceDroid) {
                    throw SourceError.duplicateEntity
                }
                sourceEntities.droids.append(sourceEntity as! SourceDroid)
            case .organization:
                if sourceEntities.organizations.contains(sourceEntity as! SourceOrganization) {
                    throw SourceError.duplicateEntity
                }
                sourceEntities.organizations.append(sourceEntity as! SourceOrganization)
            case .planet:
                if sourceEntities.planets.contains(sourceEntity as! SourcePlanet) {
                    throw SourceError.duplicateEntity
                }
                sourceEntities.planets.append(sourceEntity as! SourcePlanet)
            case .species:
                if sourceEntities.species.contains(sourceEntity as! SourceSpecies) {
                    throw SourceError.duplicateEntity
                }
                sourceEntities.species.append(sourceEntity as! SourceSpecies)
            case .starship:
                if sourceEntities.starships.contains(sourceEntity as! SourceStarship) {
                    throw SourceError.duplicateEntity
                }
                sourceEntities.starships.append(sourceEntity as! SourceStarship)
            case .starshipModel:
                if sourceEntities.starshipModels.contains(sourceEntity as! SourceStarshipModel) {
                    throw SourceError.duplicateEntity
                }
                sourceEntities.starshipModels.append(sourceEntity as! SourceStarshipModel)
            case .varia:
                if sourceEntities.varias.contains(sourceEntity as! SourceVaria) {
                    throw SourceError.duplicateEntity
                }
                sourceEntities.varias.append(sourceEntity as! SourceVaria)
            default:
                fatalError("Unsupported entity type")
        }
        sourceEntity.save()
    }

    func addSourceEntity(entityType: EntityType, entity: Entity, appearance: AppearanceType) {
        do {
            try validateEntity(entity, type: entityType)
            let newEntity = createSourceEntity(entityType: entityType, entity: entity, appearance: appearance)
            try saveSourceEntity(newEntity, entityType: entityType)
        } catch SourceError.duplicateEntity {
            print("This sourceEntity is already in the source")
        } catch {
            print("Failed to add SourceEntity: \(error.localizedDescription)")
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
}
