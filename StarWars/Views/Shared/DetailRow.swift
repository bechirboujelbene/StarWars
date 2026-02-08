import SwiftUI

// Reusable row view for displaying labeled details consistently
struct DetailRow: View {
    let label: String
    let value: String
    let systemImageName: String?

    var body: some View {
        HStack(alignment: .top) {
            
            HStack(spacing: 5) {
                if let imageName = systemImageName {
                    Image(systemName: imageName)
                        .foregroundColor(.accentColor)
                        .frame(width: 20)
                }
                Text(label)
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            .frame(width: 150, alignment: .leading)
            Spacer()
            Text(value)
                .font(.body.weight(.medium))
                .multilineTextAlignment(.trailing)
        }
       
    }
}
