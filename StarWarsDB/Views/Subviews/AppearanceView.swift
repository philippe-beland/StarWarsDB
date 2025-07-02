import SwiftUI

struct AppearanceView: View {
    @State var appearance: String
    
    var body: some View {
        switch appearance {
        case "1": Button(text: "Present", color: .green.opacity(0.5))
            case "2": Button(text: "Mentionned", color: .blue.opacity(0.5))
            case "3": Button(text: "Flashback", color: .purple.opacity(0.5))
            case "4": Button(text: "Image", color: .pink.opacity(0.5))
            case "5": Button(text: "Indirect Mention", color: .yellow.opacity(0.5))
            case "6": Button(text: "Vision", color: .cyan.opacity(0.5))
            default: Text("Absent")
        }
    }
    
    struct Button: View {
        var text: String
        var color: Color
        
        var body: some View {
            Text(text)
                .font(.caption)
                .padding(5)
                .background(color)
        }
    }
}
