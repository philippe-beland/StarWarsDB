import SwiftUI

struct SourceBrowserView: View {
    @State private var selectedSourceType: SourceType? = nil
    @State var availableSeries: [Serie] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select a type", selection: $selectedSourceType) {
                    Text("All").tag(nil as SourceType?)
                    ForEach(SourceType.allCases, id: \.self) { sourceType in
                        Text(sourceType.rawValue).tag(sourceType as SourceType?)
                    }
                }
                .pickerStyle(.segmented)
                
                if let selectedType = selectedSourceType,
                   (selectedType == .tvShow || selectedType == .comics || selectedType == .shortStory) {
                    SerieListBrowserView(
                        sourceType: selectedType, 
                        series: getFilteredSeries(for: selectedType)
                    )
                } else {
                    SourceListBrowserView(selectedType: selectedSourceType)
                }
            }
        }
        .task {
            availableSeries = await loadSeries()
        }
    }
    
    private func getFilteredSeries(for sourceType: SourceType) -> [Serie] {
        var filtered = availableSeries.filter { $0.sourceType == sourceType }
        let allSerieOption = Serie(name: "All", sourceType: sourceType, comments: "")
        filtered.insert(allSerieOption, at: 0)
        return filtered
    }
}

#Preview {
    SourceBrowserView()
}
