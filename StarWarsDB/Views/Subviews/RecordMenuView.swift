import SwiftUI

struct EntityMenuView: View {
    var imageName: String
    var type: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                
            Text(type)
        }
    }
}

#Preview {
    EntityMenuView(imageName: "Luke_Skywalker", type: "Character")
}
