import SwiftUI

struct CharacterInfoSection: View {
    @State var character: Character
    
    var body: some View {
        Section("Character Infos") {
            MultiFieldView<Character>(fieldName: "Aliases", infos: character.aliases)
            GenderPicker(gender: $character.gender)
            EditableLinkedEntityField(
                entity: Binding(
                    get: {character.species ?? Species.empty },
                    set: {character.species = ($0) }),
                )
            EditableLinkedEntityField(
                entity: Binding(
                    get: {character.homeworld ?? Planet.empty },
                    set: {character.homeworld = ($0) }),
                )
            //MultiFieldView(fieldName: "Affiliation", entities: character.affiliations)
            EditableTextField(fieldName: "First Appearance", info: $character.firstAppearance)
        }
    }
}

struct CharacterDetailView: View {
    @Bindable var character: Character
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var sourceCharacters = [SourceEntity<Character>]()
    @State private var selectedOption: SourceType = .movies
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(
                headerSection: SectionHeaderView(
                    name: $character.name,
                    url: character.url
                ),
                sidePanel: SidePanelView(
                    id: character.id,
                    comments: Binding(
                        get: { character.comments ?? "" },
                        set: { character.comments = $0 }
                    ),
                    description: character.description,
                    InfosSection: CharacterInfoSection(character: character)
                ),
                sourceEntities: sourceCharacters)
        }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update") {
                Task {
                    await character.update()
                }
            }
        }
    }
    
    private func loadInitialSources() async {
        sourceCharacters = await loadCharacterSources(characterID: character.id)
    }
}

#Preview {
    CharacterDetailView(character: .example)
}
