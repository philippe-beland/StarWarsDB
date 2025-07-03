import SwiftUI

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

struct EditArcView: View {
    @Bindable var arc: Arc
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State private var sources = [SourceEntity]()
    
    var body: some View {
        NavigationStack {
            EntityContentView(entity: arc, sourceEntities: sources, InfosSection: ArcInfoSection(arc: arc))
        }
        .toolbar {
            Button ("Update", action: arc.update)
        }
    }
}

#Preview {
    EditArcView(arc: .example)
}
