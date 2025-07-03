import SwiftUI

struct VariaInfoSection: View {
    @State var varia: Varia
    
    var body: some View {
        Section("Varia Infos") {
            FieldView(fieldName: "First Appearance", info: $varia.firstAppearance)
        }
    }
}

struct EditVariaView: View {
    @Bindable var varia: Varia
    @Environment(\.dismiss) var dismiss
    
    @State private var sourceVarias = [SourceVaria]()
    
    var body: some View {
        NavigationStack {
            EntityContentView(entity: varia, sourceEntities: sourceVarias, InfosSection: VariaInfoSection(varia: varia))
            }
        .task { await loadInitialSources() }
        .toolbar {
            Button ("Update", action: varia.update)
        }
        }
    
    private func loadInitialSources() async {
        sourceVarias = await loadVariaSources(variaID: varia.id)
    }
}

#Preview {
    EditVariaView(varia: .example)
}
