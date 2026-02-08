import Foundation

// Data model for a Star Wars character, aligned with GraphQL schema
struct Character: Codable, Identifiable {
    
    let id: String
    let name: String?
    let filmConnection: FilmConnectionSummary? // Use shared model

    
    let height: Int?
    let mass: Double?
    let birthYear: String?
    let hairColor: String?
    let eyeColor: String?
    let skinColor: String?
    let gender: String?
    let homeworld: Homeworld?
    let species: Species?

    // Timestamps
    let created: String?
    let edited: String?

    // Nested struct for Homeworld name
    struct Homeworld: Codable {
        let name: String?
    }
    
    // Nested struct for Species name
    struct Species: Codable {
        let name: String?
    }
}
