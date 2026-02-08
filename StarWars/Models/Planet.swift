import Foundation

// Data model for a Star Wars planet, aligned with GraphQL schema
struct Planet: Codable, Identifiable {
    let id: String // Use GraphQL Node ID
    let name: String?
    let filmConnection: FilmConnectionSummary? // Use shared model

    let diameter: Int?
    let rotationPeriod: Int?
    let orbitalPeriod: Int?
    let gravity: String?
    let population: Double?
    let climates: [String?]?
    let terrains: [String?]?
    
    // Timestamps
    let created: String?
    let edited: String?
}
