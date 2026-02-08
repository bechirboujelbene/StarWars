import Foundation

// Data model for a Star Wars starship, aligned with GraphQL schema
struct Starship: Codable, Identifiable {
    let id: String
    let name: String?
    let filmConnection: FilmConnectionSummary? // Use shared model
    
    let model: String?
    let starshipClass: String?
    let manufacturers: [String?]? 
    let costInCredits: Double?
    let length: Double?
    let crew: String?
    let passengers: String?
    let maxAtmospheringSpeed: Int?
    let hyperdriveRating: Double?
    let mglt: Int? 
    let cargoCapacity: Double?
    let consumables: String?
    
    // Timestamps
    let created: String?
    let edited: String?
}
