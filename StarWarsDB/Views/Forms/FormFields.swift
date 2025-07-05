import SwiftUI

struct FieldView: View {
    var fieldName: String
    var info: Binding<String>
    
    var body: some View {
        HStack {
            Text("\(fieldName):")
                .font(.footnote)
                .bold()
            TextField("Enter \(fieldName.lowercased())", text: info)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct FieldVStack: View {
    var fieldName: String
    var info: Binding<String>
    
    var body: some View {
        VStack {
            Text("\(fieldName):")
                .bold()
            TextField("Info", text: info)
        }
    }
}

struct MultiFieldView: View {
    var fieldName: String
    var infos: [String] = []
    var entities: [Entity] = []
    
    var body: some View {
        HStack {
            Text(fieldName).bold()
            Spacer()
            VStack {
                ForEach(infos, id:\.self) { info in
                    Text(info)
                }
                ForEach(entities) { entity in
                    Text(entity.name)
                }
            }
        }
        .font(.footnote)
    }
}

struct MultiFieldVStack: View {
    var fieldName: String
    var infos: [String] = []
    var entities: [Entity] = []
    
    var body: some View {
        VStack {
            Text("\(fieldName):")
                .bold()
            ForEach(infos, id:\.self) { info in
                Text(info)
            }
            ForEach(entities) { entity in
                Text(entity.name)
            }
        }
    }
}

#Preview {
    @Previewable @State var info = "Luke Skywalker"
    var fieldName = "Name"
    
    FieldView(fieldName: fieldName, info: $info)
    FieldVStack(fieldName: fieldName, info: $info)
    MultiFieldView(fieldName: fieldName)
    MultiFieldVStack(fieldName: fieldName)
}
