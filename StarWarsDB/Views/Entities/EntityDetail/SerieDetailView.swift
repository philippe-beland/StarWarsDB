import SwiftUI

struct SerieInfoSection: View {
    @State var serie: Serie
    
    var body: some View {
        Section("Serie Infos") {
        }
    }
}

struct SerieDetailView: View {
    @Bindable var serie: Serie
    @Environment(\.dismiss) var dismiss
    
    @State private var sources = [SourceEntity]()
    
    var body: some View {
        NavigationStack {
            EntityDetailContentView(entity: serie, sourceEntities: sources, InfosSection: SerieInfoSection(serie: serie))
        }
        .toolbar {
            Button ("Update", action: serie.update)
        }
    }
}

#Preview {
    SerieDetailView(serie: .example)
}
