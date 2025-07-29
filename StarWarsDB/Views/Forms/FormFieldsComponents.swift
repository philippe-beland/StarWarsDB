import SwiftUI

struct EditableTextField: View {
    var fieldName: String
    var info: Binding<String>
    var isVertical: Bool = false
    
    var body: some View {
        if isVertical {
            VStack {
                Text("\(fieldName):")
                    .font(.footnote)
                    .bold()
            TextField("Enter \(fieldName.lowercased())", text: info)
                .multilineTextAlignment(.trailing)
            }
        } else {
            HStack {
                Text("\(fieldName):")
                    .font(.footnote)
                    .bold()
                TextField("Enter \(fieldName.lowercased())", text: info)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

// TODO: Refactor this whole class
struct MultiFieldView<T: Entity>: View {
    var fieldName: String
    var infos: [String] = []
    var entities: [T] = []
    
    var body: some View {
        HStack {
            Text(T.displayName).bold()
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

struct EditableLinkedBaseEntityField<T: BaseEntity>: View {
    @Binding var baseEntity: T
        
    var body: some View {
        HStack {
            Text("\(T.displayName):")
                .font(.footnote)
                .bold()
            Spacer()
            EditableLinkedBaseEntity(baseEntity: $baseEntity) {
                Text(baseEntity.name.isEmpty ? "Select \(T.displayName)" : baseEntity.name)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct EditableLinkedEntityField<T: Entity>: View {
    @Binding var entity: T
        
    var body: some View {
        HStack {
            Text("\(T.displayName):")
                .font(.footnote)
                .bold()
            Spacer()
            EditableLinkedEntity(entity: $entity) {
                Text(entity.name.isEmpty ? "Select \(T.displayName)" : entity.name)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct EditableLinkedEntity<T: Entity, Label: View>: View {
    @Binding var entity: T
    var label: () -> Label
    
    @State private var showEntitySelection: Bool = false
    
    var body: some View {
        Button {
            showEntitySelection.toggle()
        } label: {
            label()
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showEntitySelection) {
            EntitySelectorView<T>(sourceEntities: []) { selectedEntities, _ in
                if let selected = selectedEntities.first {
                    entity = selected
                }
            }
        }
    }
}

struct EditableLinkedBaseEntity<T: BaseEntity, Label: View>: View {
    @Binding var baseEntity: T
    var label: () -> Label
    
    @State private var showEntitySelection: Bool = false
    
    var body: some View {
        Button {
            showEntitySelection.toggle()
        } label: {
            label()
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showEntitySelection) {
            BaseEntitySelectorView<T>() { selectedEntity in
                baseEntity = selectedEntity
            }
        }
    }
}

#Preview {
    @Previewable @State var info = "Luke Skywalker"
    let fieldName = "Name"
    
    EditableTextField(fieldName: fieldName, info: $info)
    MultiFieldView<Character>(fieldName: fieldName)

//    EditableLinkedEntityField<Planet>(
//        entity: Planet.empty,
//    )

}
