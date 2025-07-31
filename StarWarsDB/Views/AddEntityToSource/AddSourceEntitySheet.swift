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
    static func createView<T: BaseEntity>(for type: T.Type, onAdd: @escaping (T) -> Void) -> some View {
        switch type {
        case is Character.Type:
            return AnyView(AddCharacterView(onAdd: onAdd as! (Character) -> Void))
        case is Creature.Type:
            return AnyView(AddCreatureView(onAdd: onAdd as! (Creature) -> Void))
        case is Droid.Type:
            return AnyView(AddDroidView(onAdd: onAdd as! (Droid) -> Void))
        case is Organization.Type:
            return AnyView(AddOrganizationView(onAdd: onAdd as! (Organization) -> Void))
        case is Planet.Type:
            return AnyView(AddPlanetView(onAdd: onAdd as! (Planet) -> Void))
        case is Species.Type:
            return AnyView(AddSpeciesView(onAdd: onAdd as! (Species) -> Void))
        case is StarshipModel.Type:
            return AnyView(AddStarshipModelView(onAdd: onAdd as! (StarshipModel) -> Void))
        case is Starship.Type:
            return AnyView(AddStarshipView(onAdd: onAdd as! (Starship) -> Void))
        case is Misc.Type:
            return AnyView(AddMiscView(onAdd: onAdd as! (Misc) -> Void))
        case is Arc.Type:
            return AnyView(AddArcView(onAdd: onAdd as! (Arc) -> Void))
        case is Serie.Type:
            return AnyView(AddSerieView(onAdd: onAdd as! (Serie) -> Void))
        case is Artist.Type:
            return AnyView(AddArtistView(onAdd: onAdd as! (Artist) -> Void))
        default:
            return AnyView(Text("Unsupported entity type"))
        }
    }
}

#Preview {
    AddSourceEntitySheet<Creature>(onAdd: { _ in })
}
