import SwiftUI

struct AppearanceView: View {
    let appearance: AppearanceType
    
    var body: some View {
        switch appearance {
        case .present: Button(text: "Present", color: .green.opacity(0.5))
        case .mentioned: Button(text: "Mentionned", color: .blue.opacity(0.5))
        case .flashback: Button(text: "Flashback", color: .purple.opacity(0.5))
        case .image: Button(text: "Image", color: .pink.opacity(0.5))
        case .indirectMentioned: Button(text: "Indirect Mention", color: .yellow.opacity(0.5))
        case .vision: Button(text: "Vision", color: .cyan.opacity(0.5))
        }
    }
    
    struct Button: View {
        var text: String
        var color: Color
        
        var body: some View {
            Text(text)
                .font(.caption)
                .padding(Constants.Spacing.sm)
                .background(color)
        }
    }
}

#Preview {
    AppearanceView(appearance: .present)
}
