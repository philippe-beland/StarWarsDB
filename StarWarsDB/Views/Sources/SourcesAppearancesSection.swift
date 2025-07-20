import SwiftUI

struct EntityAppearanceSection<T: Entity>: View {
    var sourceEntities: Binding<[SourceEntity<T>]>
    @Binding var activeSheet: ActiveSheet?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            EntitySectionHeader<T>(
                title: T.displayName,
                activeSheet: $activeSheet,
                sourceEntities: sourceEntities
            )
            ScrollAppearancesView(
                sourceEntities: sourceEntities
            )
        }
    }
}

struct SourcesAppearancesSection: View {
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
                    ChooseEntityView<Character>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.characters) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Droid.self {
                    ChooseEntityView<Droid>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.droids) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Creature.self {
                    ChooseEntityView<Creature>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.creatures) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Organization.self {
                    ChooseEntityView<Organization>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.organizations) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Planet.self {
                    ChooseEntityView<Planet>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.planets) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Species.self {
                    ChooseEntityView<Species>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.species) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == StarshipModel.self {
                    ChooseEntityView<StarshipModel>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.starshipModels) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Starship.self {
                    ChooseEntityView<Starship>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.starships) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Varia.self {
                    ChooseEntityView<Varia>(isSourceEntity: true, serie: serie, sourceEntities: sourceEntities.varias) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                }
                
            case .referenceSheet(let type):
                if type == Character.self {
                    ReferenceEntityView<Character>(url: url, sourceEntities: getBinding(for: \.characters))
                } else if type == Droid.self {
                    ReferenceEntityView<Droid>(url: url, sourceEntities: getBinding(for: \.droids))
                } else if type == Creature.self {
                    ReferenceEntityView<Creature>(url: url, sourceEntities: getBinding(for: \.creatures))
                } else if type == Organization.self {
                    ReferenceEntityView<Organization>(url: url, sourceEntities: getBinding(for: \.organizations))
                } else if type == Planet.self {
                    ReferenceEntityView<Planet>(url: url, sourceEntities: getBinding(for: \.planets))
                } else if type == Species.self {
                    ReferenceEntityView<Species>(url: url, sourceEntities: getBinding(for: \.species))
                } else if type == StarshipModel.self {
                    ReferenceEntityView<StarshipModel>(url: url, sourceEntities: getBinding(for: \.starshipModels))
                } else if type == Starship.self {
                    ReferenceEntityView<Starship>(url: url, sourceEntities: getBinding(for: \.starships))
                } else if type == Varia.self {
                    ReferenceEntityView<Varia>(url: url, sourceEntities: getBinding(for: \.varias))
                }
                
            case .expandedSheet(let type):
                if type == Character.self {
                    ExpandedSourceEntityView<Character>(sourceEntities: getBinding(for: \.characters))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Droid.self {
                    ExpandedSourceEntityView<Droid>(sourceEntities: getBinding(for: \.droids))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Creature.self {
                    ExpandedSourceEntityView<Creature>(sourceEntities: getBinding(for: \.creatures))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Organization.self {
                    ExpandedSourceEntityView<Organization>(sourceEntities: getBinding(for: \.organizations))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Planet.self {
                    ExpandedSourceEntityView<Planet>(sourceEntities: getBinding(for: \.planets))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Species.self {
                    ExpandedSourceEntityView<Species>(sourceEntities: getBinding(for: \.species))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == StarshipModel.self {
                    ExpandedSourceEntityView<StarshipModel>(sourceEntities: getBinding(for: \.starshipModels))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Starship.self {
                    ExpandedSourceEntityView<Starship>(sourceEntities: getBinding(for: \.starships))
                        .onDisappear {
                            refreshID = UUID()
                        }
                } else if type == Varia.self {
                    ExpandedSourceEntityView<Varia>(sourceEntities: getBinding(for: \.varias))
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
    SourcesAppearancesSection(sourceEntities: $sourceEntities, activeSheet: $activeSheet, onAddEntity: { _, _ in })
}
