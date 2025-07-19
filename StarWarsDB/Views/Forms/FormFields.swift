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

struct MultiFieldView<T: Entity>: View {
    var fieldName: String
    var infos: [String] = []
    var entities: [T] = []
    
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

struct MultiFieldVStack<T: Entity>: View {
    var fieldName: String
    var infos: [String] = []
    var entities: [T] = []
    
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
    let fieldName = "Name"
    
    FieldView(fieldName: fieldName, info: $info)
    FieldVStack(fieldName: fieldName, info: $info)
    MultiFieldView<Character>(fieldName: fieldName)
    MultiFieldVStack<Planet>(fieldName: fieldName)
}
