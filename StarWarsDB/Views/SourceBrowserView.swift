import SwiftUI

struct SourceBrowserView: View {
    @State private var selectedSourceType: SourceType = .all
    @State var availableSeries: [Serie] = []
    
    private var filteredSeries: [Serie] {
        var filtered = availableSeries.filter { $0.sourceType == selectedSourceType }
        let allSerieOption = Serie(name: "All", sourceType: selectedSourceType, comments: "")
        filtered.insert(allSerieOption, at: 0)
        return filtered
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select a type", selection: $selectedSourceType) {
                    ForEach(SourceType.allCases, id: \.self) { sourceType in
                        Text(sourceType.rawValue).tag(sourceType)
                    }
                }
                .pickerStyle(.segmented)
                
                if selectedSourceType == .tvShow || selectedSourceType == .comics || selectedSourceType == .shortStory {
                    SerieListBrowserView(sourceType: selectedSourceType, series: filteredSeries)
                } else {
                    SourceListBrowserView(selectedView: selectedSourceType)
                }
            }
        }
        .task {
            availableSeries = await loadSeries()
        }
    }
}

#Preview {
    SourceBrowserView()
}
