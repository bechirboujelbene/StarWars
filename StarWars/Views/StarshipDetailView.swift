import SwiftUI

struct StarshipDetailView: View {
    let starship: Starship

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {

                // Header Icon
                Image(systemName: "airplane.circle.fill") // Starship icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.accentColor)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .center)

                // Section for Specifications
                CardView(title: "Specifications") {
                    DetailRow(label: "Model", value: starship.model ?? "Unknown", systemImageName: "tag.circle") // Model
                    DetailRow(label: "Class", value: starship.starshipClass?.capitalized ?? "Unknown", systemImageName: "shippingbox.circle") // Class
                    DetailRow(label: "Cost", value: formatCost(starship.costInCredits), systemImageName: "creditcard.circle") // Cost
                    DetailRow(label: "Length", value: formatLength(starship.length), systemImageName: "ruler") // Length
                }

                // Section for Capacity
                CardView(title: "Capacity") {
                    DetailRow(label: "Crew", value: starship.crew ?? "N/A", systemImageName: "person.2.circle") // Crew
                    DetailRow(label: "Passengers", value: starship.passengers ?? "N/A", systemImageName: "person.3.circle") // Passengers
                }

                // Section for Performance
                CardView(title: "Performance") {
                    DetailRow(label: "Hyperdrive Rating", value: formatRating(starship.hyperdriveRating), systemImageName: "gauge.high") // Hyperdrive
                    DetailRow(label: "MGLT", value: formatMGLT(starship.mglt), systemImageName: "speedometer") // MGLT
                }
                
                // Section for Film Appearances
                CardView(title: "Appearances") {
                    DetailRow(label: "Film Appearances", value: formatFilmCount(starship.filmConnection?.totalCount), systemImageName: "film")
                }

            }
            .padding()
        }
        .navigationTitle(starship.name ?? "Starship Details")
        .navigationBarTitleDisplayMode(.large)
    }

    

    private func formatCost(_ cost: Double?) -> String {
        guard let cost = cost else { return "Unknown" }
        if cost == 0 { return "N/A" } 
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "" 
        formatter.maximumFractionDigits = 0
        return "\(formatter.string(from: NSNumber(value: cost)) ?? "Unknown") credits"
    }

    private func formatLength(_ length: Double?) -> String {
        guard let length = length else { return "N/A" }
        return String(format: "%.1f m", length)
    }

    private func formatRating(_ rating: Double?) -> String {
        guard let rating = rating else { return "N/A" }
        return "Class \(rating)"
    }
    
    private func formatMGLT(_ mglt: Int?) -> String {
        guard let mglt = mglt else { return "N/A" }
        return "\(mglt) MGLT"
    }

    private func formatFilmCount(_ count: Int?) -> String {
        let filmCount = count ?? 0
        return "\(filmCount) \(filmCount == 1 ? "film" : "films")"
    }
}

// Preview Provider
struct StarshipDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            StarshipDetailView(starship: Starship(
                id: "9",
                name: "Death Star",
                filmConnection: FilmConnectionSummary(totalCount: 1),
                model: "DS-1 Orbital Battle Station",
                starshipClass: "Deep Space Mobile Battlestation",
                manufacturers: ["Imperial Department of Military Research", "Sienar Fleet Systems"],
                costInCredits: 1000000000000,
                length: 120000,
                crew: "342,953",
                passengers: "843,342",
                maxAtmospheringSpeed: 0,
                hyperdriveRating: 4.0,
                mglt: 10,
                cargoCapacity: 1000000000000,
                consumables: "3 years",
                created: "2014-12-10T16:36:50.509000Z",
                edited: "2014-12-20T21:26:24.783000Z"
            ))
        }
    }
}
