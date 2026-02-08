import Foundation
import Combine


@MainActor
class StarshipsViewModel: ObservableObject {
    @Published var starships: [Starship] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    // Use cursor for pagination
    @Published private(set) var nextCursor: String? = nil
    @Published private(set) var canLoadMorePages = true

    private var apiService = APIService.shared

    init() {
       
        loadMoreStarships(cursor: nil)
    }

    // Fetches the next set of starships from the API using a cursor
    func loadMoreStarships(cursor: String? = nil) {
        let cursorToFetch = cursor ?? self.nextCursor

        guard !isLoading && (canLoadMorePages || cursor == nil) else {
            if isLoading { print("StarshipsViewModel: Already loading.") }
            else if !canLoadMorePages { print("StarshipsViewModel: No more pages to load.") }
            return
        }

        isLoading = true
        if cursor == nil { errorMessage = nil }
        print("StarshipsViewModel: Loading starships after cursor: \(cursorToFetch ?? "nil")")

        // Call the API service to fetch starships
        apiService.fetchStarships(after: cursorToFetch) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let connection):
                    // Extract starships from the 'edges'
                    let newStarships = connection.edges?.compactMap { $0.node } ?? []
                    print("StarshipsViewModel: Received \(newStarships.count) starships. Total count: \(connection.totalCount)")
                    
                    self.starships.append(contentsOf: newStarships)
                    
                    // Update pagination info
                    self.nextCursor = connection.pageInfo.endCursor
                    self.canLoadMorePages = connection.pageInfo.hasNextPage
                    
                    print("StarshipsViewModel: Current total starships: \(self.starships.count), Next cursor: \(self.nextCursor ?? "nil"), Can load more: \(self.canLoadMorePages)")
                    
                case .failure(let error):
                    print("StarshipsViewModel: Error fetching starships - \(error.localizedDescription)")
                    self.errorMessage = "Failed to load starships: \(error.localizedDescription)"
                    self.canLoadMorePages = false // Stop pagination on error
                }
            }
        }
    }

    // Function to reset and load the first page
    func refreshStarships() {
        print("StarshipsViewModel: Refreshing starships...")
        starships = []
        nextCursor = nil
        canLoadMorePages = true
        isLoading = false
        errorMessage = nil
        loadMoreStarships(cursor: nil)
    }
}
