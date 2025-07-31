import SwiftUI

struct EntityAppearanceSection<T: TrackableEntity>: View {
    var sourceEntities: [SourceEntity<T>]
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
    @Bindable var viewModel: EditSourceViewModel
    var serie: Serie?
    var url: URL?
    let onAddEntity: (any Entity, AppearanceType) -> Void
    
    var body: some View {
        VStack {
            Text("Appearances")
                .bold()
            TabView {
                // Characters
                EntityAppearanceSection<Character>(
                    sourceEntities: viewModel.characters,
                    activeSheet: $viewModel.activeSheet
                )
                .padding(Constants.Spacing.md)
                .tabItem { Text(Character.displayName) }

                // Species
                EntityAppearanceSection<Species>(
                    sourceEntities: viewModel.species,
                    activeSheet: $viewModel.activeSheet,
                )
                .padding(Constants.Spacing.md)
                .tabItem { Text(Species.displayName) }

                // Planets
                EntityAppearanceSection<Planet>(
                    sourceEntities: viewModel.planets,
                    activeSheet: $viewModel.activeSheet,
                )
                .padding(Constants.Spacing.md)
                .tabItem { Text(Planet.displayName) }

                // Organizations
                EntityAppearanceSection<Organization>(
                    sourceEntities: viewModel.organizations,
                    activeSheet: $viewModel.activeSheet,
                )
                .padding(Constants.Spacing.md)
                .tabItem { Text(Organization.displayName) }

                // Starships
                EntityAppearanceSection<Starship>(
                    sourceEntities: viewModel.starships,
                    activeSheet: $viewModel.activeSheet,
                )
                .padding(Constants.Spacing.md)
                .tabItem { Text(Starship.displayName) }

                // Starship Models
                EntityAppearanceSection<StarshipModel>(
                    sourceEntities: viewModel.starshipModels,
                    activeSheet: $viewModel.activeSheet,
                )
                .padding(Constants.Spacing.md)
                .tabItem { Text(StarshipModel.displayName) }

                // Creatures
                EntityAppearanceSection<Creature>(
                    sourceEntities: viewModel.creatures,
                    activeSheet: $viewModel.activeSheet,
                )
                .padding(Constants.Spacing.md)
                .tabItem { Text(Creature.displayName) }
                
                // Droids
                EntityAppearanceSection<Droid>(
                    sourceEntities: viewModel.droids,
                    activeSheet: $viewModel.activeSheet,
                )
                .padding(Constants.Spacing.md)
                .tabItem { Text(Droid.displayName) }
                
                // Miscellaneous
                EntityAppearanceSection<Misc>(
                    sourceEntities: viewModel.misc,
                    activeSheet: $viewModel.activeSheet,
                )
                .padding(Constants.Spacing.md)
                .tabItem { Text(Misc.displayName) }
            }
        }
        .sheet(item: $viewModel.activeSheet) { sheet in
            switch sheet {
            case .add(let type):
                if type == Character.self {
                    EntitySelectorView<Character>(serie: serie, sourceEntities: viewModel.characters) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Droid.self {
                    EntitySelectorView<Droid>(serie: serie, sourceEntities: viewModel.droids) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Creature.self {
                    EntitySelectorView<Creature>(serie: serie, sourceEntities: viewModel.creatures) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Organization.self {
                    EntitySelectorView<Organization>(serie: serie, sourceEntities: viewModel.organizations) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Planet.self {
                    EntitySelectorView<Planet>(serie: serie, sourceEntities: viewModel.planets) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Species.self {
                    EntitySelectorView<Species>(serie: serie, sourceEntities: viewModel.species) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == StarshipModel.self {
                    EntitySelectorView<StarshipModel>(serie: serie, sourceEntities: viewModel.starshipModels) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Starship.self {
                    EntitySelectorView<Starship>(serie: serie, sourceEntities: viewModel.starships) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                } else if type == Misc.self {
                    EntitySelectorView<Misc>(serie: serie, sourceEntities: viewModel.misc) { selectedEntities, appearance in
                        for selectedEntity in selectedEntities {
                            onAddEntity(selectedEntity, appearance)
                            // Handle related entities
                            handleRelatedEntities(selectedEntity, appearance)
                        }
                    }
                }
                
            case .referenceSheet(let type):
                if type == Character.self {
                    SourceEntityReferenceView<Character>(url: url, sourceEntities: viewModel.characters)
                } else if type == Droid.self {
                    SourceEntityReferenceView<Droid>(url: url, sourceEntities: viewModel.droids)
                } else if type == Creature.self {
                    SourceEntityReferenceView<Creature>(url: url, sourceEntities: viewModel.creatures)
                } else if type == Organization.self {
                    SourceEntityReferenceView<Organization>(url: url, sourceEntities: viewModel.organizations)
                } else if type == Planet.self {
                    SourceEntityReferenceView<Planet>(url: url, sourceEntities: viewModel.planets)
                } else if type == Species.self {
                    SourceEntityReferenceView<Species>(url: url, sourceEntities: viewModel.species)
                } else if type == StarshipModel.self {
                    SourceEntityReferenceView<StarshipModel>(url: url, sourceEntities: viewModel.starshipModels)
                } else if type == Starship.self {
                    SourceEntityReferenceView<Starship>(url: url, sourceEntities: viewModel.starships)
                } else if type == Misc.self {
                    SourceEntityReferenceView<Misc>(url: url, sourceEntities: viewModel.misc)
                }
                
            case .expandedSheet(let type):
                if type == Character.self {
                    SourceEntityExpandedView(sourceEntities: $viewModel.characters)
                    
                } else if type == Droid.self {
                    SourceEntityExpandedView(sourceEntities: $viewModel.droids)

                } else if type == Creature.self {
                    SourceEntityExpandedView(sourceEntities: $viewModel.creatures)

                } else if type == Organization.self {
                    SourceEntityExpandedView(sourceEntities: $viewModel.organizations)

                } else if type == Planet.self {
                    SourceEntityExpandedView(sourceEntities: $viewModel.planets)

                } else if type == Species.self {
                    SourceEntityExpandedView(sourceEntities: $viewModel.species)

                } else if type == StarshipModel.self {
                    SourceEntityExpandedView(sourceEntities: $viewModel.starshipModels)

                } else if type == Starship.self {
                    SourceEntityExpandedView(sourceEntities: $viewModel.starships)

                } else if type == Misc.self {
                    SourceEntityExpandedView(sourceEntities: $viewModel.misc)
                }
            }
        }
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
    @Previewable @State var viewModel = EditSourceViewModel(source: .example)
    SourceAppearancesSection(viewModel: viewModel, onAddEntity: { _, _ in })
}
