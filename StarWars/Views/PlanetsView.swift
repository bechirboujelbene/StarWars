import SwiftUI

// View to display the list of Star Wars planets
struct PlanetsView: View {
    @StateObject private var viewModel = PlanetsViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading && viewModel.planets.isEmpty {
                    // Show loading indicator only on initial load
                    ProgressView("Loading Planets...")
                        .scaleEffect(1.5)
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    
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
                            viewModel.refreshPlanets()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    // Show the list of planets
                    List {
                        ForEach(viewModel.planets) { planet in
                            // Wrap row in NavigationLink to the detail view
                            NavigationLink(destination: PlanetDetailView(planet: planet)) {
                                PlanetRow(planet: planet)
                            }
                            .onAppear {
                                // Load more when the last item appears
                                if planet.id == viewModel.planets.last?.id && viewModel.canLoadMorePages {
                                    print("Last planet appeared, loading more...")
                                    viewModel.loadMorePlanets()
                                }
                            }
                        }
                        
                        // Show loading indicator at the bottom if loading more pages
                        if viewModel.isLoading && !viewModel.planets.isEmpty {
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
                        print("Pull to refresh triggered for planets")
                        viewModel.refreshPlanets()
                    }
                }
            }
            .navigationTitle("Planets")
        }
        .navigationViewStyle(.stack)
    }
}


struct PlanetRow: View {
    let planet: Planet

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
            Text(planet.name ?? "Unknown Planet") 
                .font(.headline)
            
            
            let filmCount = planet.filmConnection?.totalCount ?? 0
            Text("\(filmCount) \(filmCount == 1 ? "film" : "films")")
                .font(.subheadline)
                .foregroundColor(.secondary) 
        }
        .padding(.vertical, 8)
    }
}

struct PlanetsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetsView()
    }
}
