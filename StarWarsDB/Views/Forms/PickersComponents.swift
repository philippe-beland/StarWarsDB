import SwiftUI

struct GenderPicker: View {
    @Binding var gender: Gender
    
    var body: some View {
        HStack{
            Picker(selection: $gender, label: Text("Gender").font(.footnote).bold()) {
                ForEach(Gender.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
        }
    }
}

struct RegionPicker: View {
    @Binding var region: Region
    
    var body: some View {
        HStack{
            Picker(selection: $region, label: Text("Region").font(.footnote).bold()) {
                ForEach(Region.allCases, id: \.self) {
                    Text($0.rawValue)
                        .font(.footnote)
                }
            }
        }
    }
}

struct YearPicker: View {
    let era: Era
    @Binding var universeYear: Float
    var yearString: String {
        "\(abs(Int(universeYear))) \(universeYear > 0 ? "ABY" : "BBY")"
    }
    
    var body: some View {
        VStack {
            Slider(value: $universeYear,
                   in: era.minimum...era.maximum,
                   step: 1,
                   minimumValueLabel: Text("\(Int(era.minimum))"),
                   maximumValueLabel: Text("\(Int(era.maximum))"),
                   label: {
                Text(yearString).font(.footnote).bold()
            }
            )
            Text(yearString).font(.footnote).bold()
        }
    }
}

struct PublicationDatePicker: View {
    @Binding var date: Date
    
    var body: some View {
        DatePicker("Publication Date", selection: $date, displayedComponents: [.date])
            .datePickerStyle(.compact)
            .labelsHidden()
    }
}

struct EraPicker: View {
    @Binding var era: Era
    
    var body: some View {
        Picker(selection: $era, label: Text("Era").font(.footnote).bold()) {
            ForEach(Era.allCases, id: \.self) {
                Text($0.rawValue)
                    .font(.footnote)
            }
        }
    }
}

struct SourceTypePicker: View {
    @Binding var sourceType: SourceType
    
    var body: some View {
        Picker(selection: $sourceType, label: Text("Source Type").font(.footnote).bold()) {
            ForEach(SourceType.allCases, id: \.self) {
                Text($0.rawValue)
                    .font(.footnote)
            }
        }
    }
}

#Preview {
    @Previewable @State var gender: Gender = .Male
    @Previewable @State var region: Region = .unknownRegion
    @Previewable @State var universeYear: Float = 0
    @Previewable @State var publicationDate: Date = Date()
    @Previewable @State var era: Era = .dawnJedi
    @Previewable @State var sourceType: SourceType = .novels
    
    GenderPicker(gender: $gender)
    RegionPicker(region: $region)
    YearPicker(era: .dawnJedi, universeYear: $universeYear)
    PublicationDatePicker(date: $publicationDate)
    EraPicker(era: $era)
    SourceTypePicker(sourceType: $sourceType)
}
