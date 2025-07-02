import SwiftUI

struct SourcesAppearancesSection: View {
    @Binding var sourceItems: SourceItemCollection
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
                            sourceItems: getSourceItemsBinding(for: entityType)
                        )
                        ScrollAppearancesView(
                            sourceItems: getSourceItemsBinding(for: entityType),
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
                ChooseEntityView(entityType: type, isSourceItem: true, serie: serie, sourceItems: getSourceItems(for: type)) { selectedEntities, appearance in
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
                ReferenceItemView(entityType: type, url: url, sourceItems: getSourceItemsBinding(for: type))
                
            case .expandedSheet(let type):
                ExpandedSourceItemView(sourceItems: getSourceItemsBinding(for: type), entityType: type)
                    .onDisappear {
                        refreshID = UUID()
                    }
            }
        }
    }
    
    private func getSourceItems(for entityType: EntityType) -> [SourceItem] {
        switch entityType {
        case .character:
            return sourceItems.characters as [SourceItem]
        case .droid:
            return sourceItems.droids as [SourceItem]
        case .creature:
            return sourceItems.creatures as [SourceItem]
        case .organization:
            return sourceItems.organizations as [SourceItem]
        case .planet:
            return sourceItems.planets as [SourceItem]
        case .species:
            return sourceItems.species as [SourceItem]
        case .starshipModel:
            return sourceItems.starshipModels as [SourceItem]
        case .starship:
            return sourceItems.starships as [SourceItem]
        case .varia:
            return sourceItems.varias as [SourceItem]
        default:
            return []
        }
    }
    
    private func getSourceItemsBinding(for entityType: EntityType) -> Binding<[SourceItem]> {
        switch entityType {
        case .character:
            return Binding(
                get: { sourceItems.characters as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.characters = newItems.compactMap { $0 as? SourceCharacter }
                    sourceItems = updatedCollection
                }
            )
        case .droid:
            return Binding(
                get: { sourceItems.droids as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.droids = newItems.compactMap { $0 as? SourceDroid }
                    sourceItems = updatedCollection
                }
            )
        case .creature:
            return Binding(
                get: { sourceItems.creatures as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.creatures = newItems.compactMap { $0 as? SourceCreature }
                    sourceItems = updatedCollection
                }
            )
        case .organization:
            return Binding(
                get: { sourceItems.organizations as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.organizations = newItems.compactMap { $0 as? SourceOrganization }
                    sourceItems = updatedCollection
                }
            )
        case .planet:
            return Binding(
                get: { sourceItems.planets as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.planets = newItems.compactMap { $0 as? SourcePlanet }
                    sourceItems = updatedCollection
                }
            )
        case .species:
            return Binding(
                get: { sourceItems.species as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.species = newItems.compactMap { $0 as? SourceSpecies }
                    sourceItems = updatedCollection
                }
            )
        case .starshipModel:
            return Binding(
                get: { sourceItems.starshipModels as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.starshipModels = newItems.compactMap { $0 as? SourceStarshipModel }
                    sourceItems = updatedCollection
                }
            )
        case .starship:
            return Binding(
                get: { sourceItems.starships as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.starships = newItems.compactMap { $0 as? SourceStarship }
                    sourceItems = updatedCollection
                }
            )
        case .varia:
            return Binding(
                get: { sourceItems.varias as [SourceItem] },
                set: { newItems in
                    var updatedCollection = sourceItems
                    updatedCollection.varias = newItems.compactMap { $0 as? SourceVaria }
                    sourceItems = updatedCollection
                }
            )
        default:
            return .constant([]) // Return an empty, immutable Binding for unsupported cases
        }
    }
}
