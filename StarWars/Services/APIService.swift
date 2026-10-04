import Foundation
import Apollo
import ApolloAPI
import ApolloSQLite
import StarWarsAPI



// Structure for cursor pagination info
struct PageInfo {
    let endCursor: String?
    let hasNextPage: Bool
    
    init(endCursor: String?, hasNextPage: Bool) {
        self.endCursor = endCursor
        self.hasNextPage = hasNextPage
    }
}

// People connection model for our application
struct PeopleConnection {
    var edges: [PeopleEdge]?
    let pageInfo: PageInfo
    let totalCount: Int
    
    init(edges: [PeopleEdge]?, pageInfo: PageInfo, totalCount: Int) {
        self.edges = edges
        self.pageInfo = pageInfo
        self.totalCount = totalCount
    }
}

// Edge type for our application
struct PeopleEdge {
    let node: Character
    let cursor: String
    
    init(node: Character, cursor: String) {
        self.node = node
        self.cursor = cursor
    }
}



// Planet connection model for our application
struct PlanetConnection {
    var edges: [PlanetEdge]?
    let pageInfo: PageInfo
    let totalCount: Int
    
    init(edges: [PlanetEdge]?, pageInfo: PageInfo, totalCount: Int) {
        self.edges = edges
        self.pageInfo = pageInfo
        self.totalCount = totalCount
    }
}

// Edge type for our application
struct PlanetEdge {
    let node: Planet
    let cursor: String
    
    init(node: Planet, cursor: String) {
        self.node = node
        self.cursor = cursor
    }
}

// Starship connection model for our application
struct StarshipConnection {
    var edges: [StarshipEdge]?
    let pageInfo: PageInfo
    let totalCount: Int
    
    init(edges: [StarshipEdge]?, pageInfo: PageInfo, totalCount: Int) {
        self.edges = edges
        self.pageInfo = pageInfo
        self.totalCount = totalCount
    }
}

// Edge type for our application
struct StarshipEdge {
    let node: Starship
    let cursor: String
    
    init(node: Starship, cursor: String) {
        self.node = node
        self.cursor = cursor
    }
}



class APIService {
    static let shared = APIService()
    
    // GraphQL endpoint URL
    private let endpointURL = URL(string: "https://swapi-graphql.netlify.app/graphql")!
    
    // Define the Apollo Client instance
    private(set) lazy var client: ApolloClient = {        
        // Define the path for the SQLite cache file
        let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true
        ).first!
        let documentsURL = URL(fileURLWithPath: documentsPath)
        let sqliteFileURL = documentsURL.appendingPathComponent("starwars_apollo_cache.sqlite")

        // Create the SQLite cache
        let sqliteCache = try? SQLiteNormalizedCache(fileURL: sqliteFileURL)

        // Create a store with the cache
        let store = ApolloStore(cache: sqliteCache ?? InMemoryNormalizedCache())

        // Configure the network transport
        let transport = RequestChainNetworkTransport(interceptorProvider: DefaultInterceptorProvider(store: store),
                                                 endpointURL: endpointURL)

        // Create the client
        return ApolloClient(networkTransport: transport, store: store)
    }()

    private init() {}

    
    
    // Fetches a list of characters using Apollo Client
    func fetchCharacters(after cursor: String? = nil, completion: @escaping (Result<PeopleConnection, Error>) -> Void) {
        print("Fetching characters from GraphQL endpoint (Cursor: \(cursor ?? "nil"))")
        
        
        // Handle the optional cursor parameter properly for GraphQL
        let query = AllPeopleQuery(after: cursor.map { .some($0) } ?? .none)
        
        
        client.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                // Check for errors in the GraphQL response
                if let errors = graphQLResult.errors, !errors.isEmpty {
                    let errorMessage = errors.map { $0.localizedDescription }.joined(separator: ", ")
                    print("❌ GraphQL Error: \(errorMessage)")
                    return
                }
                
                // Get data from the result
                guard let data = graphQLResult.data, let allPeople = data.allPeople else {
                    print("⚠️ GraphQL response received, but 'allPeople' data is missing.")
                    return
                }
                
                
                var peopleConnection = PeopleConnection(
                    edges: [],
                    pageInfo: PageInfo(endCursor: allPeople.pageInfo.endCursor, 
                                       hasNextPage: allPeople.pageInfo.hasNextPage),
                    totalCount: allPeople.totalCount ?? 0
                )
                
                // Map the edges to our model type
                if let edges = allPeople.edges {
                    peopleConnection.edges = edges.compactMap { edge -> PeopleEdge? in
                        guard let node = edge?.node else { return nil }
                        
                        
                        let homeworld = node.homeworld?.name != nil ? Character.Homeworld(name: node.homeworld?.name) : nil
                        let species = node.species?.name != nil ? Character.Species(name: node.species?.name) : nil
                        let filmConnection = FilmConnectionSummary(totalCount: node.filmConnection?.totalCount ?? 0)
                        
                        let character = Character(
                            id: node.id,
                            name: node.name,
                            filmConnection: filmConnection,
                            height: node.height,
                            mass: node.mass,
                            birthYear: node.birthYear,
                            hairColor: node.hairColor,
                            eyeColor: node.eyeColor,
                            skinColor: node.skinColor,
                            gender: node.gender,
                            homeworld: homeworld,
                            species: species,
                            created: node.created,
                            edited: node.edited)
                        
                        return PeopleEdge(node: character, cursor: edge?.cursor ?? "")
                    }
                }
                
                print("✅ Successfully decoded GraphQL response. HasNextPage: \(peopleConnection.pageInfo.hasNextPage). Edges: \(peopleConnection.edges?.count ?? 0)")
                completion(.success(peopleConnection))
                
            case .failure(let error):
                print("❌ Apollo Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

    // Fetches a list of planets using Apollo Client 
    func fetchPlanets(after cursor: String? = nil, completion: @escaping (Result<PlanetConnection, Error>) -> Void) {
        print("Fetching planets from GraphQL endpoint (Cursor: \(cursor ?? "nil"))")
        
        
        let query = AllPlanetsQuery(after: cursor.map { .some($0) } ?? .none)
        
        // Execute the query using our Apollo client
        client.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                // Check for errors in the GraphQL response
                if let errors = graphQLResult.errors, !errors.isEmpty {
                    let errorMessage = errors.map { $0.localizedDescription }.joined(separator: ", ")
                    print("❌ GraphQL Error: \(errorMessage)")
                    completion(.failure(NSError(domain: "APIService", code: -5, 
                                             userInfo: [NSLocalizedDescriptionKey: "GraphQL Error: \(errorMessage)"])))                    
                    return
                }
                
                // Get data from the result
                guard let data = graphQLResult.data, let allPlanets = data.allPlanets else {
                    print("⚠️ GraphQL response received, but 'allPlanets' data is missing.")
                    completion(.failure(NSError(domain: "APIService", code: -4, 
                                             userInfo: [NSLocalizedDescriptionKey: "Data path 'allPlanets' missing in GraphQL response"])))
                    return
                }
                
                
                var planetConnection = PlanetConnection(
                    edges: [],
                    pageInfo: PageInfo(endCursor: allPlanets.pageInfo.endCursor, 
                                       hasNextPage: allPlanets.pageInfo.hasNextPage),
                    totalCount: allPlanets.totalCount ?? 0
                )
                
                // Map the edges to our model type
                if let edges = allPlanets.edges {
                    planetConnection.edges = edges.compactMap { edge -> PlanetEdge? in
                        guard let node = edge?.node else { return nil }
                        
                        
                        let filmConnection = FilmConnectionSummary(totalCount: node.filmConnection?.totalCount ?? 0)
                        
                        let planet = Planet(
                            id: node.id,
                            name: node.name,
                            filmConnection: filmConnection,
                            diameter: node.diameter,
                            rotationPeriod: node.rotationPeriod,
                            orbitalPeriod: node.orbitalPeriod,
                            gravity: node.gravity,
                            population: node.population,
                            climates: node.climates,
                            terrains: node.terrains,
                            created: node.created,
                            edited: node.edited
                        )
                        
                        return PlanetEdge(node: planet, cursor: edge?.cursor ?? "")
                    }
                }
                
                print("✅ Successfully decoded GraphQL planets response. HasNextPage: \(planetConnection.pageInfo.hasNextPage). Edges: \(planetConnection.edges?.count ?? 0)")
                completion(.success(planetConnection))
                
            case .failure(let error):
                print("❌ Apollo Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    // Fetches a list of starships using Apollo Client with type-safe queries
    func fetchStarships(after cursor: String? = nil, completion: @escaping (Result<StarshipConnection, Error>) -> Void) {
        print("Fetching starships from GraphQL endpoint (Cursor: \(cursor ?? "nil"))")
        
        // Create a type-safe query using the generated code
        let query = AllStarshipsQuery(after: cursor.map { .some($0) } ?? .none)
        
        // Execute the query using our Apollo client
        client.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):
                // Check for errors in the GraphQL response
                if let errors = graphQLResult.errors, !errors.isEmpty {
                    let errorMessage = errors.map { $0.localizedDescription }.joined(separator: ", ")
                    print("❌ GraphQL Error: \(errorMessage)")
                    completion(.failure(NSError(domain: "APIService", code: -5, 
                                             userInfo: [NSLocalizedDescriptionKey: "GraphQL Error: \(errorMessage)"])))                    
                    return
                }
                
                // Get data from the result
                guard let data = graphQLResult.data, let allStarships = data.allStarships else {
                    print("⚠️ GraphQL response received, but 'allStarships' data is missing.")
                    completion(.failure(NSError(domain: "APIService", code: -4, 
                                             userInfo: [NSLocalizedDescriptionKey: "Data path 'allStarships' missing in GraphQL response"])))
                    return
                }
                
                // Convert the Apollo-generated type to our model type
                
                var starshipConnection = StarshipConnection(
                    edges: [],
                    pageInfo: PageInfo(endCursor: allStarships.pageInfo.endCursor, 
                                       hasNextPage: allStarships.pageInfo.hasNextPage),
                    totalCount: allStarships.totalCount ?? 0
                )
                
                // Map the edges to our model type
                if let edges = allStarships.edges {
                    starshipConnection.edges = edges.compactMap { edge -> StarshipEdge? in
                        guard let node = edge?.node else { return nil }
                        
                        // Convert Apollo Starship to our Starship model with direct mapping
                        let filmConnection = FilmConnectionSummary(totalCount: node.filmConnection?.totalCount ?? 0)
                        
                        let starship = Starship(
                            id: node.id,
                            name: node.name,
                            filmConnection: filmConnection,
                            model: node.model,
                            starshipClass: node.starshipClass,
                            manufacturers: node.manufacturers,
                            costInCredits: node.costInCredits,
                            length: node.length,
                            crew: node.crew,
                            passengers: node.passengers,
                            maxAtmospheringSpeed: node.maxAtmospheringSpeed,
                            hyperdriveRating: node.hyperdriveRating,
                            mglt: node.mglt,
                            cargoCapacity: node.cargoCapacity,
                            consumables: node.consumables,
                            created: node.created,
                            edited: node.edited)
                        
                        return StarshipEdge(node: starship, cursor: edge?.cursor ?? "")
                    }
                }
                
                print("✅ Successfully decoded GraphQL starships response. HasNextPage: \(starshipConnection.pageInfo.hasNextPage). Edges: \(starshipConnection.edges?.count ?? 0)")
                completion(.success(starshipConnection))
                
            case .failure(let error):
                print("❌ Apollo Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}


