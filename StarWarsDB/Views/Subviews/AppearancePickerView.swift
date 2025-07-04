import SwiftUI

struct AppearancePickerView: View {
    @Binding var appearance: AppearanceType
    
    var body: some View {
        HStack {
            Button("Present") { appearance = .present }
                .tint((appearance == .present) ? .green.opacity(0.5) : .gray)
            Button("Mentionned") { appearance = .mentioned }
                .tint((appearance == .mentioned) ? .blue.opacity(0.5) : .gray)
            Button("Flashback") { appearance = .flashback }
                .tint((appearance == .flashback) ? .purple.opacity(0.5) : .gray)
            Button("Image") { appearance = .image }
                .tint((appearance == .image) ? .yellow.opacity(0.5) : .gray)
            Button("Vision") { appearance = .vision }
                .tint((appearance == .vision) ? .pink.opacity(0.5) : .gray)
        }
        .font(.caption.bold())
        .buttonStyle(.borderedProminent)
        .padding(10)
    }
}

#Preview {
    AppearancePickerView(appearance: .present)
}






