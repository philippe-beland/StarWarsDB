import SwiftUI

// Protocol that all Add views should conform to
protocol AddEntityView: View {
    associatedtype EntityType: BaseEntity
    var onAdd: (EntityType) -> Void { get }
}

struct AddSourceEntitySheet<T: Entity>: View {
    var onAdd: (T) -> Void
    
    var body: some View {
        AddViewFactory.createView(for: T.self, onAdd: onAdd)
    }
}

// Factory for creating the appropriate Add view
struct AddViewFactory {
    @ViewBuilder
    static func createView<T: BaseEntity>(for type: T.Type, onAdd: @escaping (T) -> Void) -> some View {
        switch type {
        case is Character.Type:
            AddCharacterView(onAdd: onAdd as! (Character) -> Void)
        case is Creature.Type:
            AddCreatureView(onAdd: onAdd as! (Creature) -> Void)
        case is Droid.Type:
            AddDroidView(onAdd: onAdd as! (Droid) -> Void)
        case is Organization.Type:
            AddOrganizationView(onAdd: onAdd as! (Organization) -> Void)
        case is Planet.Type:
            AddPlanetView(onAdd: onAdd as! (Planet) -> Void)
        case is Species.Type:
            AddSpeciesView(onAdd: onAdd as! (Species) -> Void)
        case is StarshipModel.Type:
            AddStarshipModelView(onAdd: onAdd as! (StarshipModel) -> Void)
        case is Starship.Type:
            AddStarshipView(onAdd: onAdd as! (Starship) -> Void)
        case is Misc.Type:
            AddMiscView(onAdd: onAdd as! (Misc) -> Void)
        case is Arc.Type:
            AddArcView(onAdd: onAdd as! (Arc) -> Void)
        case is Serie.Type:
            AddSerieView(onAdd: onAdd as! (Serie) -> Void)
        case is Artist.Type:
            AddArtistView(onAdd: onAdd as! (Artist) -> Void)
        default:
            Text("Unsupported entity type")
        }
    }
}

#Preview {
    AddSourceEntitySheet<Creature>(onAdd: { _ in })
}
