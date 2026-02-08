import Foundation
import Combine

// ViewModel responsible for managing CharactersView
@MainActor // Ensure UI updates happen on the main thread
class CharactersViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    // Use cursor for pagination
    @Published private(set) var nextCursor: String? = nil 
    @Published private(set) var canLoadMorePages = true
    @Published var favoriteCharacterIDs: Set<String> = [] //  favorites characters
    @Published var showOnlyFavorites: Bool = false

    private var apiService = APIService.shared

    init() {
        
        loadMoreCharacters(cursor: nil)
    }

    // Fetches the next set of characters from the API using a cursor
    func loadMoreCharacters(cursor: String? = nil) {
        // Check if we should use the stored nextCursor if no specific cursor is provided
        
        let cursorToFetch = cursor ?? self.nextCursor
        
        // Prevent loading if already loading, or if there are no more pages
        guard !isLoading && (canLoadMorePages || cursor == nil) else {
             if isLoading {
                 print("ViewModel: Already loading.")
             } else if !canLoadMorePages {
                 print("ViewModel: No more pages to load.")
             }
            return
        }

        isLoading = true
        
        if cursor == nil { 
            errorMessage = nil
        }
        print("ViewModel: Loading characters after cursor: \(cursorToFetch ?? "nil")")

        // Call the GraphQL fetch method
        apiService.fetchCharacters(after: cursorToFetch) { [weak self] result in
            guard let self = self else { return }
            
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let connection):
                    // Extract next characters from the 'edges'
                    let newCharacters = connection.edges?.compactMap { $0.node } ?? []
                    print("ViewModel: Received \(newCharacters.count) characters. Total count: \(connection.totalCount)")
                    
                    // Append new characters
                    self.characters.append(contentsOf: newCharacters)
                    
                    // Update pagination info
                    self.nextCursor = connection.pageInfo.endCursor
                    self.canLoadMorePages = connection.pageInfo.hasNextPage
                    
                    print("ViewModel: Current total characters: \(self.characters.count), Next cursor: \(self.nextCursor ?? "nil"), Can load more: \(self.canLoadMorePages)")
                    
                case .failure(let error):
                    print("ViewModel: Error fetching characters - \(error.localizedDescription)")
                    self.errorMessage = "Failed to load characters: \(error.localizedDescription)"
                    
                    self.canLoadMorePages = false
                }
            }
        }
    }
    
    // return filtered characters
    var filteredCharacters: [Character] {
        if showOnlyFavorites {
            return characters.filter { favoriteCharacterIDs.contains($0.id) }
        } else {
            return characters
        }
    }
    
    // Check if a character is a favorite
    func isFavorite(character: Character) -> Bool {
        favoriteCharacterIDs.contains(character.id)
    }
    
    // Toggle favorite status
    func toggleFavorite(character: Character) {
        let id = character.id
        if favoriteCharacterIDs.contains(id) {
            favoriteCharacterIDs.remove(id)
        } else {
            favoriteCharacterIDs.insert(id)
        }
    }
    
    
    func refreshCharacters() {
        print("ViewModel: Refreshing characters...")
        characters = []
        nextCursor = nil // Reset cursor for the first page
        canLoadMorePages = true
        isLoading = false // Reset loading state
        errorMessage = nil
        favoriteCharacterIDs = [] // Reset favorites
        showOnlyFavorites = false // Reset filter
        // Load the first set of data without a cursor
        loadMoreCharacters(cursor: nil)
    }
}
