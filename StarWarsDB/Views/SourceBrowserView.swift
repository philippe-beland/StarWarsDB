import SwiftUI

struct SourceBrowserView: View {
    @State private var sourceType: SourceType = .all
    @State var series: [Serie] = []
    
    private var filteredSeries: [Serie] {
        var filtered = series.filter { $0.sourceType == sourceType }
        let allSerie = Serie(name: "All", sourceType: sourceType, comments: "")
        filtered.insert(allSerie, at: 0)
        return filtered
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select a type", selection: $sourceType) {
                    ForEach(SourceType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                
                if sourceType == .tvShow || sourceType == .comics || sourceType == .shortStory {
                    SerieListBrowserView(sourceType: sourceType, series: filteredSeries)
                } else {
                    SourceListBrowserView(selectedView: sourceType)
                }
            }
        }
        .task {
            series = await loadSeries()
        }
    }
}

#Preview {
    SourceBrowserView()
}
