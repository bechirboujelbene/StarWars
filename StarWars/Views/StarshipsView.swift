import SwiftUI

// View to display the list of Star Wars starships
struct StarshipsView: View {
    @StateObject private var viewModel = StarshipsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading && viewModel.starships.isEmpty {
                    // Show loading indicator only on initial load
                    ProgressView("Loading Starships...")
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
                            viewModel.refreshStarships()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    // Show the list of starships
                    List {
                        ForEach(viewModel.starships) { starship in
                            // Wrap row in NavigationLink to the detail view
                            NavigationLink(destination: StarshipDetailView(starship: starship)) {
                                StarshipRow(starship: starship)
                            }
                            .onAppear {
                                // Load more when the last item appears
                                if starship.id == viewModel.starships.last?.id && viewModel.canLoadMorePages {
                                    print("Last starship appeared, loading more...")
                                    viewModel.loadMoreStarships()
                                }
                            }
                        }
                        
                        // Show loading indicator at the bottom if loading more pages
                        if viewModel.isLoading && !viewModel.starships.isEmpty {
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
                        print("Pull to refresh triggered for starships")
                        viewModel.refreshStarships()
                    }
                }
            }
            .navigationTitle("Starships")
        }
        .navigationViewStyle(.stack)
    }
}

// Simple row view for displaying a starship's name and film count
struct StarshipRow: View {
    let starship: Starship

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text(starship.name ?? "Unknown Starship") 
                .font(.headline)
            
            
            let filmCount = starship.filmConnection?.totalCount ?? 0
            Text("\(filmCount) \(filmCount == 1 ? "film" : "films")")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8) 
    }
}

struct StarshipsView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipsView()
    }
}
