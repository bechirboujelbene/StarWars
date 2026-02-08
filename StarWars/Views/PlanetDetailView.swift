import SwiftUI

struct PlanetDetailView: View {
    let planet: Planet

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                // Header Icon
                Image(systemName: "globe.americas.fill") // Planet icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.accentColor)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .center) // Center the icon
                
                // Section for Physical Characteristics
                CardView(title: "Physical Characteristics") {
                    DetailRow(label: "Diameter", value: formatDiameter(planet.diameter), systemImageName: "arrow.up.left.and.arrow.down.right.circle") // Diameter icon
                    DetailRow(label: "Rotation Period", value: formatPeriod(planet.rotationPeriod, unit: "hours"), systemImageName: "arrow.triangle.2.circlepath.circle") // Rotation
                    DetailRow(label: "Orbital Period", value: formatPeriod(planet.orbitalPeriod, unit: "days"), systemImageName: "calendar.circle") // Orbit
                    DetailRow(label: "Gravity", value: planet.gravity ?? "N/A", systemImageName: "arrow.down.to.line.circle") // Gravity
                }
                
                // Section for Environment
                CardView(title: "Environment") {
                    DetailRow(label: "Climates", value: formatStringArray(planet.climates), systemImageName: "cloud.sun") // Climate
                    DetailRow(label: "Terrains", value: formatStringArray(planet.terrains), systemImageName: "mountain.2") // Terrain
                }
                
                // Section for Population
                CardView(title: "Population") {
                    DetailRow(label: "Population", value: formatPopulation(planet.population), systemImageName: "person.3.sequence") // Population
                }
                
                // Section for Film Appearances
                CardView(title: "Appearances") {
                    DetailRow(label: "Film Appearances", value: formatFilmCount(planet.filmConnection?.totalCount), systemImageName: "film")
                }
                
            }
            .padding()
        }
        .navigationTitle(planet.name ?? "Planet Details")
        .navigationBarTitleDisplayMode(.large)
    }
    
   
    
    private func formatDiameter(_ diameter: Int?) -> String {
        guard let diameter = diameter else { return "N/A" }
        return "\(diameter) km"
    }
    
    private func formatPeriod(_ period: Int?, unit: String) -> String {
        guard let period = period else { return "N/A" }
        return "\(period) \(unit)"
    }
    
    private func formatPopulation(_ population: Double?) -> String {
        guard let population = population else { return "Unknown" }
      
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0 
        return formatter.string(from: NSNumber(value: population)) ?? "Unknown"
    }
    
    private func formatStringArray(_ array: [String?]?) -> String {
        guard let array = array, !array.isEmpty else { return "N/A" }
        return array.compactMap { $0 }.map { $0.capitalized }.joined(separator: ", ")
    }
    
    private func formatFilmCount(_ count: Int?) -> String {
        let filmCount = count ?? 0
        return "\(filmCount) \(filmCount == 1 ? "film" : "films")"
    }
}

// Preview Provider
struct PlanetDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PlanetDetailView(planet: Planet(
                id: "1",
                name: "Tatooine",
                filmConnection: FilmConnectionSummary(totalCount: 5),
                diameter: 10465,
                rotationPeriod: 23,
                orbitalPeriod: 304,
                gravity: "1 standard",
                population: 200000,
                climates: ["arid"],
                terrains: ["desert"],
                created: "2014-12-09T13:50:49.641000Z",
                edited: "2014-12-20T20:58:18.411000Z"
            ))
        }
    }
}
