import SwiftUI

struct SourcesAppearancesSection: View {
    @Binding var sourceEntities: SourceEntityCollection
    @Binding var activeSheet: ActiveSheet?
    var serie: Serie?
    var url: URL?
    let onAddEntity: (EntityType, Entity, AppearanceType) -> Void
    @State private var refreshID = UUID()
    
    var body: some View {
        VStack {
            Text("Appearances")
                .bold()
            TabView {
                ForEach(EntityType.sourceTypes, id: \.self) { entityType in
                    VStack(alignment: .leading, spacing: 8) {
                        EntitySectionHeader(
                            title: entityType.displayName,
                            entityType: entityType,
                            activeSheet: $activeSheet,
                            sourceEntities: getSourceEntitiesBinding(for: entityType)
                        )
                        ScrollAppearancesView(
                            sourceEntities: getSourceEntitiesBinding(for: entityType),
                            entityType: entityType
                        )
                        .id(refreshID)
                    }
                    .padding()
                    .tabItem {
                        Label(entityType.displayName, systemImage: entityType.iconName)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .entitySheet(let type):
                ChooseEntityView(entityType: type, isSourceEntity: true, serie: serie, sourceEntities: getSourceEntities(for: type)) { selectedEntities, appearance in
                    for selectedEntity in selectedEntities {
                        onAddEntity(type, selectedEntity, appearance)
                        if type == .character && appearance != .mentioned {
                            if let character = selectedEntity as? Character {
                                if let species = character.species {
                                    if species.name.lowercased() != "droid" {
                                        onAddEntity(.species, species, appearance)
                                    }
                                }
                            }
                        } else if type == .starship && appearance != .mentioned {
                            if let starship = selectedEntity as? Starship {
                                if let model = starship.model {
                                    onAddEntity(.starshipModel, model, appearance)
                                }
                            }
                        }
                    }
                }
                
            case .referenceSheet(let type):
                ReferenceEntityView(entityType: type, url: url, sourceEntities: getSourceEntitiesBinding(for: type))
                
            case .expandedSheet(let type):
                ExpandedSourceEntityView(sourceEntities: getSourceEntitiesBinding(for: type), entityType: type)
                    .onDisappear {
                        refreshID = UUID()
                    }
            }
        }
    }
    
    private func getSourceEntities(for entityType: EntityType) -> [SourceEntity] {
        switch entityType {
        case .character:
            return sourceEntities.characters as [SourceEntity]
        case .droid:
            return sourceEntities.droids as [SourceEntity]
        case .creature:
            return sourceEntities.creatures as [SourceEntity]
        case .organization:
            return sourceEntities.organizations as [SourceEntity]
        case .planet:
            return sourceEntities.planets as [SourceEntity]
        case .species:
            return sourceEntities.species as [SourceEntity]
        case .starshipModel:
            return sourceEntities.starshipModels as [SourceEntity]
        case .starship:
            return sourceEntities.starships as [SourceEntity]
        case .varia:
            return sourceEntities.varias as [SourceEntity]
        default:
            return []
        }
    }
    
    private func getSourceEntitiesBinding(for entityType: EntityType) -> Binding<[SourceEntity]> {
        switch entityType {
        case .character:
            return Binding(
                get: { sourceEntities.characters as [SourceEntity] },
                set: { newEntities in
                    var updatedCollection = sourceEntities
                    updatedCollection.characters = newEntities.compactMap { $0 as? SourceCharacter }
                    sourceEntities = updatedCollection
                }
            )
        case .droid:
            return Binding(
                get: { sourceEntities.droids as [SourceEntity] },
                set: { newEntities in
                    var updatedCollection = sourceEntities
                    updatedCollection.droids = newEntities.compactMap { $0 as? SourceDroid }
                    sourceEntities = updatedCollection
                }
            )
        case .creature:
            return Binding(
                get: { sourceEntities.creatures as [SourceEntity] },
                set: { newEntities in
                    var updatedCollection = sourceEntities
                    updatedCollection.creatures = newEntities.compactMap { $0 as? SourceCreature }
                    sourceEntities = updatedCollection
                }
            )
        case .organization:
            return Binding(
                get: { sourceEntities.organizations as [SourceEntity] },
                set: { newEntities in
                    var updatedCollection = sourceEntities
                    updatedCollection.organizations = newEntities.compactMap { $0 as? SourceOrganization }
                    sourceEntities = updatedCollection
                }
            )
        case .planet:
            return Binding(
                get: { sourceEntities.planets as [SourceEntity] },
                set: { newEntities in
                    var updatedCollection = sourceEntities
                    updatedCollection.planets = newEntities.compactMap { $0 as? SourcePlanet }
                    sourceEntities = updatedCollection
                }
            )
        case .species:
            return Binding(
                get: { sourceEntities.species as [SourceEntity] },
                set: { newEntities in
                    var updatedCollection = sourceEntities
                    updatedCollection.species = newEntities.compactMap { $0 as? SourceSpecies }
                    sourceEntities = updatedCollection
                }
            )
        case .starshipModel:
            return Binding(
                get: { sourceEntities.starshipModels as [SourceEntity] },
                set: { newEntities in
                    var updatedCollection = sourceEntities
                    updatedCollection.starshipModels = newEntities.compactMap { $0 as? SourceStarshipModel }
                    sourceEntities = updatedCollection
                }
            )
        case .starship:
            return Binding(
                get: { sourceEntities.starships as [SourceEntity] },
                set: { newEntities in
                    var updatedCollection = sourceEntities
                    updatedCollection.starships = newEntities.compactMap { $0 as? SourceStarship }
                    sourceEntities = updatedCollection
                }
            )
        case .varia:
            return Binding(
                get: { sourceEntities.varias as [SourceEntity] },
                set: { newEntities in
                    var updatedCollection = sourceEntities
                    updatedCollection.varias = newEntities.compactMap { $0 as? SourceVaria }
                    sourceEntities = updatedCollection
                }
            )
        default:
            return .constant([]) // Return an empty, immutable Binding for unsupported cases
        }
    }
}
