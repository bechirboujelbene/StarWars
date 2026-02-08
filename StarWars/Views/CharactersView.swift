import SwiftUI

// View to display the list of Star Wars characters
struct CharactersView: View {
    @StateObject private var viewModel = CharactersViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading && viewModel.characters.isEmpty {
                    // Show loading indicator only on initial load
                    ProgressView("Loading Characters...")
                        .scaleEffect(1.5)
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    // Show error message
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .padding(.bottom, 5)
                        Text("Error")
                            .font(.headline)
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Retry") {
                            viewModel.refreshCharacters()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    
                    // Filter Toggle
                    Toggle("Show Favorites Only", isOn: $viewModel.showOnlyFavorites)
                        .padding(.horizontal)

                    List {
                        // Use the filtered list
                        ForEach(viewModel.filteredCharacters) { character in
                            
                            NavigationLink(destination: CharacterDetailView(character: character)) {
                                
                                HStack {
                                    CharacterRow(character: character)
                                    Spacer()
                                    if viewModel.isFavorite(character: character) {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: false) { // Add swipe action
                                Button {
                                    viewModel.toggleFavorite(character: character)
                                } label: {
                                    Label(viewModel.isFavorite(character: character) ? "Unfavorite" : "Favorite",
                                          systemImage: viewModel.isFavorite(character: character) ? "star.slash.fill" : "star.fill")
                                }
                                .tint(viewModel.isFavorite(character: character) ? .gray : .blue)
                            }
                            .onAppear {
                                // Load more when the last item appears
                                if character.id == viewModel.characters.last?.id && !viewModel.showOnlyFavorites && viewModel.canLoadMorePages {
                                    viewModel.loadMoreCharacters()
                                }
                            }
                        }
                        
                        // Show loading indicator at the bottom if loading more pages
                        if viewModel.isLoading && !viewModel.characters.isEmpty {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        print("Pull to refresh triggered")
                        viewModel.showOnlyFavorites = false
                        viewModel.refreshCharacters()
                    }
                }
            }
            .navigationTitle("Characters")
        }
        .navigationViewStyle(.stack)
    }
}

// Simple row view for displaying a character's name
struct CharacterRow: View {
    let character: Character

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(character.name ?? "Unknown") 
                .font(.headline)
            
            
            let filmCount = character.filmConnection?.totalCount ?? 0
            Text("\(filmCount) \(filmCount == 1 ? "film" : "films")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8) 
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
