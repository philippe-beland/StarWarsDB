//
//  InfosSectionsView.swift
//  StarWarsDB
//
//  Created by Philippe Beland on 12/24/24.
//

import SwiftUI

struct CharacterInfoSection: View {
    @State var character: Character
    
    var body: some View {
        Section("Character Infos") {
            MultiFieldView(fieldName: "Aliases", infos: character.aliases)
            GenderPicker(gender: $character.gender)
            EditEntityInfoView(
                fieldName: "Species",
                entity: Binding(
                    get: {character.species ?? Species.empty },
                    set: {character.species = ($0 as! Species) }),
                entityType: .species)
            EditEntityInfoView(
                fieldName: "Homeworld",
                entity: Binding(
                    get: {character.homeworld ?? Planet.empty },
                    set: {character.homeworld = ($0 as! Planet) }),
                entityType: .planet)
            //MultiFieldView(fieldName: "Affiliation", entities: character.affiliations)
            FieldView(fieldName: "First Appearance", info: $character.firstAppearance)
        }
    }
}

struct ArtistInfoSection: View {
    @State var artist: Artist
    
    var body: some View {
        Section("Artist Infos") {
        }
    }
}

struct CreatureInfoSection: View {
    @State var creature: Creature
    
    var body: some View {
        Section("Creature Infos") {
            EditEntityInfoView(
                fieldName: "Homeworld",
                entity: Binding(
                    get: {creature.homeworld ?? Planet.empty },
                    set: {creature.homeworld = ($0 as! Planet) }),
                entityType: .planet)
            FieldView(fieldName: "First Appearance", info: $creature.firstAppearance)
        }
    }
}

struct DroidInfoSection: View {
    @State var droid: Droid
    
    var body: some View {
        Section("Droid Infos") {
            FieldView(fieldName: "First Appearance", info: $droid.firstAppearance)
        }
    }
}

struct OrganizationInfoSection: View {
    @State var organization: Organization
    
    var body: some View {
        Section("Organization Infos") {
            FieldView(fieldName: "First Appearance", info: $organization.firstAppearance)
        }
    }
}

struct PlanetInfoSection: View {
    @State var planet: Planet
    
    var body: some View {
        Section("Planet Infos") {
            RegionPicker(region: $planet.region)
            FieldView(fieldName: "Sector", info: $planet.sector)
            FieldView(fieldName: "System", info: $planet.system)
            FieldView(fieldName: "Capital", info: $planet.capitalCity)
//            MultiFieldView(fieldName: "Destinations", infos: $planet.destinations)
            FieldView(fieldName: "First Appearance", info: $planet.firstAppearance)

        }
    }
}

struct SpeciesInfoSection: View {
    @State var species: Species
    
    var body: some View {
        Section("Species Infos") {
            EditEntityInfoView(
                fieldName: "Homeworld",
                entity: Binding(
                    get: {species.homeworld ?? Planet.empty },
                    set: {species.homeworld = ($0 as! Planet) }),
                entityType: .planet)
            FieldView(fieldName: "First Appearance", info: $species.firstAppearance)
        }
    }
}

struct StarshipModelInfoSection: View {
    @State var starshipModel: StarshipModel
    
    var body: some View {
        Section("Starship Model Infos") {
            FieldView(fieldName: "Class Type", info: $starshipModel.classType)
            FieldView(fieldName: "Line", info: $starshipModel.line)
            FieldView(fieldName: "First Appearance", info: $starshipModel.firstAppearance)
        }
    }
}

struct StarshipInfoSection: View {
    @State var starship: Starship
    
    var body: some View {
        Section("Starship Infos") {
            EditEntityInfoView(
                fieldName: "Model",
                entity: Binding(
                    get: {starship.model ?? StarshipModel.empty },
                    set: {starship.model = ($0 as! StarshipModel) }),
                entityType: .starshipModel)
            FieldView(fieldName: "First Appearance", info: $starship.firstAppearance)
        }
    }
}

struct VariaInfoSection: View {
    @State var varia: Varia
    
    var body: some View {
        Section("Varia Infos") {
            FieldView(fieldName: "First Appearance", info: $varia.firstAppearance)
        }
    }
}

struct ArcInfoSection: View {
    @State var arc: Arc
    
    var body: some View {
        Section("Arc Infos") {
            EditEntityInfoView(
                fieldName: "Serie",
                entity: Binding(
                    get: {arc.serie ?? StarshipModel.empty },
                    set: {arc.serie = ($0 as! Serie) }),
                entityType: .serie)
        }
    }
}

struct SerieInfoSection: View {
    @State var serie: Serie
    
    var body: some View {
        Section("Serie Infos") {
        }
    }
}
