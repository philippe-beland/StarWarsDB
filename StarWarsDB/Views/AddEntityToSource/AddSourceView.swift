import SwiftUI

struct AddSourceView: View {
    @Environment(\.dismiss) var dismiss: DismissAction
    
    @State var name: String = ""
    @State private var serie: Serie?
    @State private var number: Int?
    @State private var arc: Arc?
    @State private var era: Era = .ageRebellion
    @State private var sourceType: SourceType = .comics
    @State private var publicationDate: Date = Date()
    @State private var universeYear: Float = 0
    @State private var numberPages: Int?
    @State private var isDone: Bool = false
    @State private var comments: String = ""
    
    var onSourceCreation: (Source) -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Name", text: $name)
                    .font(.title.bold())
                    .padding()
                
                Form {
                    Section("Source Infos") {
//                        EditEntityInfoView(
//                            fieldName: "Serie",
//                            entity: Binding(
//                                get: {serie ?? Serie.empty },
//                                set: {serie = ($0 ) }),
//                            )
                        HStack {
                            Text("Number:")
                                .font(.footnote)
                                .bold()
                            Spacer()
                            TextField("Number", value: $number, format: .number)
                        }
//                        EditEntityInfoView(
//                            fieldName: "Arc",
//                            entity: Binding(
//                                get: {arc ?? Arc.empty },
//                                set: {arc = ($0 ) }),
//                            )
                        EraPicker(era: $era)
                        SourceTypePicker(sourceType: $sourceType)
                        PublicationDatePicker(date: $publicationDate)
                        YearPicker(era: era, universeYear: $universeYear)
                        //AuthorsVStack(fieldName: "Authors")
                        //ArtistsVStack(fieldName: "Artists")
                        Text(numberPages?.description ?? "")
                    }
                    
                    CommentsView(comments: $comments)
                    Section {
                        Button("Save", action: saveSource)
                            .disabled(name.isEmpty && number == nil)
                    }
                }
                .navigationTitle("Add New Source")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    private func saveSource() {
        let newSource = Source(name: name, serie: serie, number: number, arc: arc, era: era, sourceType: sourceType, publicationDate: publicationDate, universeYear: universeYear, numberPages: numberPages, comments: comments)
        
        newSource.save()
        onSourceCreation(newSource)
        dismiss()
    }
}

#Preview {
    AddSourceView(onSourceCreation: { _ in })
}
