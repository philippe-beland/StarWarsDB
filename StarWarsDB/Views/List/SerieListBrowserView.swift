import SwiftUI

struct SerieListBrowserView: View {
    var sourceType: SourceType
    var series: [Serie]
    
    @StateObject var searchContext = SearchContext()
    
    private var filteredSeries: [Serie] {
        series.filter {
            if searchContext.debouncedQuery != "" {
                return $0.name.localizedStandardContains(searchContext.debouncedQuery)
            } else {
                return true
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search", text: $searchContext.query)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                List(filteredSeries) { serie in
                    NavigationLink(destination: SourceListBrowserView(selectedType: sourceType, serie: serie)) {
                        Text(serie.name)
                    }
                }
            }
        }
    }
}

#Preview {
    let mockSeries = [
        Serie(name: "Darth Vader(2020)", sourceType: .comics, comments: ""),
        Serie(name: "Age of Rebellion", sourceType: .comics, comments: "")
    ]
    SerieListBrowserView(sourceType: .comics, series: mockSeries)
}
