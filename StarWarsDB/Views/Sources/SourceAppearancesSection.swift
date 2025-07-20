import SwiftUI

struct EntityAppearanceSection<T: Entity>: View {
    var sourceEntities: Binding<[SourceEntity<T>]>
    @Binding var activeSheet: ActiveSheet?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            EntitySectionHeaderView<T>(
                title: T.displayName,
                activeSheet: $activeSheet,
                sourceEntities: sourceEntities
            )
            EntityAppearancesScrollView(
                sourceEntities: sourceEntities
            )
        }
    }
}

struct SourceAppearancesSection: View {
    @Binding var sourceEntities: SourceEntityCollection
    @Binding var activeSheet: ActiveSheet?
    var serie: Serie?
    var url: URL?
    let onAddEntity: (any Entity, AppearanceType) -> Void

    @State private var refreshID = UUID()
    
    var body: some View {
        VStack {
            Text("Appearances")
                .bold()
            TabView {
                // Characters
                EntityAppearanceSection<Character>(
                    sourceEntities: getBinding(for: \.characters),
                    activeSheet: $activeSheet
                )
                .padding()
                .tabItem {
                    Label(Character.displayName, systemImage: Character.exampleImageName)
                }

                // Species
                EntityAppearanceSection<Species>(
                    sourceEntities: getBinding(for: \.species),
                    activeSheet: $activeSheet
                )
                .padding()
                .tabItem {
                    Label(Species.displayName, systemImage: Species.exampleImageName)
                }

                // Planets
                EntityAppearanceSection<Planet>(
                    sourceEntities: getBinding(for: \.planets),
                    activeSheet: $activeSheet
                )
                .padding()
                .tabItem {
                    Label(Planet.displayName, systemImage: Planet.exampleImageName)
                }

                // Organizations
                EntityAppearanceSection<Organization>(
                    sourceEntities: getBinding(for: \.organizations),
                    activeSheet: $activeSheet
                )
                .padding()
                .tabItem {
                    Label(Organization.displayName, systemImage: Organization.exampleImageName)
                }

                // Starships
                EntityAppearanceSection<Starship>(
                    sourceEntities: getBinding(for: \.starships),
                    activeSheet: $activeSheet
                )
                .padding()
                .tabItem {
                    Label(Starship.displayName, systemImage: Starship.exampleImageName)
                }

                // Starship Models
                EntityAppearanceSection<StarshipModel>(
                    sourceEntities: getBinding(for: \.starshipModels),
                    activeSheet: $activeSheet
                )
                .padding()
                .tabItem {
                    Label(StarshipModel.displayName, systemImage: StarshipModel.exampleImageName)
                }

                // Creatures
                EntityAppearanceSection<Creature>(
                    sourceEntities: getBinding(for: \.creatures),
                    activeSheet: $activeSheet
                )
                .padding()
                .tabItem {
                    Label(Creature.displayName, systemImage: Creature.exampleImageName)
                }
                
                // Droids
                EntityAppearanceSection<Droid>(
                    sourceEntities: getBinding(for: \.droids),
                    activeSheet: $activeSheet
                )
                .padding()
                .tabItem {
                    Label(Droid.displayName, systemImage: Droid.exampleImageName)
                }
                
                // Varia
                EntityAppearanceSection<Varia>(
                    sourceEntities: getBinding(for: \.varias),
                    activeSheet: $activeSheet
                )
                .padding()
                .tabItem {
                    Label(Varia.displayName, systemImage: Varia.exampleImageName)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .add(let type):
                if type == Character.self {
                    EntitySelectorView<Character>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.characters) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Droid.self {
                    EntitySelectorView<Droid>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.droids) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Creature.self {
                    EntitySelectorView<Creature>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.creatures) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Organization.self {
                    EntitySelectorView<Organization>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.organizations) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Planet.self {
                    EntitySelectorView<Planet>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.planets) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Species.self {
                    EntitySelectorView<Species>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.species) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == StarshipModel.self {
                    EntitySelectorView<StarshipModel>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.starshipModels) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Starship.self {
                    EntitySelectorView<Starship>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.starships) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Varia.self {
                    EntitySelectorView<Varia>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.varias) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                }
                
            case .referenceSheet(let type):
                if type == Character.self {
                    SourceEntityReferenceView<Character>(url: url, sourceEntities: getBinding(for: \.characters))
                } else if type == Droid.self {
                    SourceEntityReferenceView<Droid>(url: url, sourceEntities: getBinding(for: \.droids))
                } else if type == Creature.self {
                    SourceEntityReferenceView<Creature>(url: url, sourceEntities: getBinding(for: \.creatures))
                } else if type == Organization.self {
                    SourceEntityReferenceView<Organization>(url: url, sourceEntities: getBinding(for: \.organizations))
                } else if type == Planet.self {
                    SourceEntityReferenceView<Planet>(url: url, sourceEntities: getBinding(for: \.planets))
                } else if type == Species.self {
                    SourceEntityReferenceView<Species>(url: url, sourceEntities: getBinding(for: \.species))
                } else if type == StarshipModel.self {
                    SourceEntityReferenceView<StarshipModel>(url: url, sourceEntities: getBinding(for: \.starshipModels))
                } else if type == Starship.self {
                    SourceEntityReferenceView<Starship>(url: url, sourceEntities: getBinding(for: \.starships))
                } else if type == Varia.self {
                    SourceEntityReferenceView<Varia>(url: url, sourceEntities: getBinding(for: \.varias))
                }
                
            case .expandedSheet(let type):
                if type == Character.self {
                    SourceEntityExpandedView<Character>(sourceEntities: getBinding(for: \.characters))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Droid.self {
                    SourceEntityExpandedView<Droid>(sourceEntities: getBinding(for: \.droids))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Creature.self {
                    SourceEntityExpandedView<Creature>(sourceEntities: getBinding(for: \.creatures))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Organization.self {
                    SourceEntityExpandedView<Organization>(sourceEntities: getBinding(for: \.organizations))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Planet.self {
                    SourceEntityExpandedView<Planet>(sourceEntities: getBinding(for: \.planets))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Species.self {
                    SourceEntityExpandedView<Species>(sourceEntities: getBinding(for: \.species))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == StarshipModel.self {
                    SourceEntityExpandedView<StarshipModel>(sourceEntities: getBinding(for: \.starshipModels))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Starship.self {
                    SourceEntityExpandedView<Starship>(sourceEntities: getBinding(for: \.starships))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Varia.self {
                    SourceEntityExpandedView<Varia>(sourceEntities: getBinding(for: \.varias))
                        .onDisappear {
                            refreshID = UUID()
                        }
                }
            }
        }
    }
    
    // Helper function to create bindings
    private func getBinding<T: Entity>(for keyPath: WritableKeyPath<SourceEntityCollection, [SourceEntity<T>]>) -> Binding<[SourceEntity<T>]> {
        Binding(
            get: { sourceEntities[keyPath: keyPath] },
            set: { sourceEntities[keyPath: keyPath] = $0 }
        )
    }
    
    // Helper method to handle related entities
    private func handleRelatedEntities(_ entity: any Entity, _ appearance: AppearanceType) {
        if appearance == .mentioned { return }
        
        if let character = entity as? Character {
            if let species = character.species, species.name.lowercased() != "droid" {
                onAddEntity(species, appearance)
            }
        } else if let starship = entity as? Starship {
            if let model = starship.model {
                onAddEntity(model, appearance)
            }
        }
    }
}

#Preview {
    @Previewable @State var sourceEntities: SourceEntityCollection = .init()
    @Previewable @State var activeSheet: ActiveSheet? = EditSourceViewModel(source: .example).activeSheet
    SourceAppearancesSection(sourceEntities: $sourceEntities, activeSheet: $activeSheet, onAddEntity: { _, _ in })
}
