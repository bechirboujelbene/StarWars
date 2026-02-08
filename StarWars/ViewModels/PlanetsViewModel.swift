import Foundation
import Combine

// ViewModel responsible for PlanetsView
@MainActor
class PlanetsViewModel: ObservableObject {
    @Published var planets: [Planet] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    // Use cursor for pagination
    @Published private(set) var nextCursor: String? = nil
    @Published private(set) var canLoadMorePages = true

    private var apiService = APIService.shared

    init() {
        
        loadMorePlanets(cursor: nil)
    }

    // Fetches the next set of planets from the API using a cursor
    func loadMorePlanets(cursor: String? = nil) {
        let cursorToFetch = cursor ?? self.nextCursor

        guard !isLoading && (canLoadMorePages || cursor == nil) else {
            if isLoading { print("PlanetsViewModel: Already loading.") }
            else if !canLoadMorePages { print("PlanetsViewModel: No more pages to load.") }
            return
        }

        isLoading = true
        if cursor == nil { errorMessage = nil }
        print("PlanetsViewModel: Loading planets after cursor: \(cursorToFetch ?? "nil")")

        // Call the API service to fetch more planets
        apiService.fetchPlanets(after: cursorToFetch) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let connection):
                    // Extract planets from the 'edges'
                    let newPlanets = connection.edges?.compactMap { $0.node } ?? []
                    print("PlanetsViewModel: Received \(newPlanets.count) planets. Total count: \(connection.totalCount)")
                    
                    self.planets.append(contentsOf: newPlanets)
                    
                    // Update pagination info
                    self.nextCursor = connection.pageInfo.endCursor
                    self.canLoadMorePages = connection.pageInfo.hasNextPage
                    
                    print("PlanetsViewModel: Current total planets: \(self.planets.count), Next cursor: \(self.nextCursor ?? "nil"), Can load more: \(self.canLoadMorePages)")
                    
                case .failure(let error):
                    print("PlanetsViewModel: Error fetching planets - \(error.localizedDescription)")
                    self.errorMessage = "Failed to load planets: \(error.localizedDescription)"
                    self.canLoadMorePages = false
                }
            }
        }
    }

    // Function to reset and load the first page (pull-to-refresh)
    func refreshPlanets() {
        print("PlanetsViewModel: Refreshing planets...")
        planets = []
        nextCursor = nil
        canLoadMorePages = true
        isLoading = false
        errorMessage = nil
        loadMorePlanets(cursor: nil)
    }
}
