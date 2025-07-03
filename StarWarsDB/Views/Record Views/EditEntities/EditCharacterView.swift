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

struct EditCharacterView: View {
    @Bindable var character: Character
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var sourceCharacters = [SourceCharacter]()
    
    @State private var selectedOption: SourceType = .movies
    
    var body: some View {
        NavigationStack {
            EntityContentView(entity: character, sourceEntities: sourceCharacters, InfosSection: CharacterInfoSection(character: character))
        }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: character.update)
        }
    }
    
    private func loadInitialSources() async {
        sourceCharacters = await loadCharacterSources(characterID: character.id)
    }
}

#Preview {
    EditCharacterView(character: .example)
}
