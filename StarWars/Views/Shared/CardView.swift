import SwiftUI

// A reusable view that displays content within a styled card container.
struct CardView<Content: View>: View {
    let title: String?
    let content: Content

    
    init(title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title = title {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 8) 
            }
            
            // Display the main content provided to the card
            content
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}

// Preview Provider for CardView
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 20) {
                CardView(title: "Sample Card Title") {
                    Text("This is the content inside the card.")
                    Text("It can contain multiple views arranged in a VStack or HStack.")
                    DetailRow(label: "Example", value: "Data", systemImageName: "star")
                }
                
                CardView {
                    Text("This card has no title.")
                    DetailRow(label: "Another", value: "Row", systemImageName: "heart")
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}
