import SwiftUI

struct SerieInfoSection: View {
    @State var serie: Serie
    
    var body: some View {
        Section("Serie Infos") {
        }
    }
}

struct EditSerieView: View {
    @Bindable var serie: Serie
    @Environment(\.dismiss) var dismiss
    
    @State private var sources = [SourceItem]()
    
    var body: some View {
        NavigationStack {
            RecordContentView(record: serie, sourceItems: sources, InfosSection: SerieInfoSection(serie: serie))
        }
        .toolbar {
            Button ("Update", action: serie.update)
        }
    }
}

#Preview {
    EditSerieView(serie: .example)
}
