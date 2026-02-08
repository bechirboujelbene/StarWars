import SwiftUI

struct CharacterDetailView: View {
    let character: Character

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // Header Icon
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.accentColor)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .center) // Center the icon
                
                // Section for Physical Attributes
                CardView(title: "Physical Attributes") {
                    DetailRow(label: "Height", value: formatHeight(character.height), systemImageName: "ruler")
                    DetailRow(label: "Mass", value: formatMass(character.mass), systemImageName: "scalemass")
                    DetailRow(label: "Hair Color", value: character.hairColor?.capitalized ?? "N/A", systemImageName: "face.smiling") // Example icon
                    DetailRow(label: "Eye Color", value: character.eyeColor?.capitalized ?? "N/A", systemImageName: "eye")
                    DetailRow(label: "Skin Color", value: character.skinColor?.capitalized ?? "N/A", systemImageName: "person.fill") // Example icon
                }
                
                // Section for Background
                CardView(title: "Background") {
                    DetailRow(label: "Birth Year", value: character.birthYear ?? "Unknown", systemImageName: "calendar")
                    DetailRow(label: "Homeworld", value: character.homeworld?.name ?? "Unknown", systemImageName: "house")
                    DetailRow(label: "Species", value: character.species?.name ?? "Unknown", systemImageName: "figure.stand") // Example icon
                }
                
                // Section for Film Appearances (using existing count)
                CardView(title: "Appearances") {
                    DetailRow(label: "Film Appearances", value: formatFilmCount(character.filmConnection?.totalCount), systemImageName: "film")
                }
                
                // Section for Record Info
                CardView(title: "Record Info") {
                    DetailRow(label: "Created", value: formatDate(character.created), systemImageName: "calendar.badge.plus")
                    DetailRow(label: "Edited", value: formatDate(character.edited), systemImageName: "calendar.badge.clock")
                }

            }
            .padding()
        }
        .navigationTitle(character.name ?? "Character Details")
        .navigationBarTitleDisplayMode(.large) // Make title larger
    }
    
    // Helper function to format height
    private func formatHeight(_ height: Int?) -> String {
        guard let height = height else { return "N/A" }
        let heightInMeters = Double(height) / 100.0
        return String(format: "%.2f m", heightInMeters)
    }
    
    // Helper function to format mass
    private func formatMass(_ mass: Double?) -> String {
        guard let mass = mass else { return "N/A" }
        return "\(mass) kg"
    }
    
    // Helper function to format film count
    private func formatFilmCount(_ count: Int?) -> String {
        let filmCount = count ?? 0
        return "\(filmCount) \(filmCount == 1 ? "film" : "films")"
    }
    
    // Helper function to format date strings (simple formatting)
    private func formatDate(_ dateString: String?) -> String {
        guard let dateString = dateString else { return "N/A" }
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds] // Handle potential fractional seconds
        
        if let date = formatter.date(from: dateString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .medium
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        } else {
            formatter.formatOptions = [.withInternetDateTime]
            if let date = formatter.date(from: dateString) {
                 let displayFormatter = DateFormatter()
                 displayFormatter.dateStyle = .medium
                 displayFormatter.timeStyle = .short
                 return displayFormatter.string(from: date)
            }
        }
        return dateString 
    }
}

// Preview Provider
struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            // Create a sample character for previewing
            CharacterDetailView(character: Character(
                id: "1", 
                name: "Luke Skywalker", 
                filmConnection: FilmConnectionSummary(totalCount: 4), 
                height: 172, 
                mass: 77,
                birthYear: "19BBY", 
                hairColor: "blond", 
                eyeColor: "blue", 
                skinColor: "fair", 
                gender: "male",
                homeworld: Character.Homeworld(name: "Tatooine"), 
                species: Character.Species(name: "Human"), 
                created: "2014-12-09T13:50:51.644000Z", 
                edited: "2014-12-20T21:17:56.891000Z"
            ))
        }
    }
}
