import SwiftUI

struct ChooseSourceView: View {
    @State private var sourceType: SourceType = .all
    @State var series: [Serie] = []
    
    private var filteredSeries: [Serie] {
        series.filter { $0.sourceType == sourceType }
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
                    ListSerieView(sourceType: sourceType, series: filteredSeries)
                } else {
                    ListSourcesView(selectedView: sourceType)
                }
            }
        }
        .task {
            series = await loadSeries()
        }
    }
}

//#Preview {
//    ChooseSourceTypeView()
//}
