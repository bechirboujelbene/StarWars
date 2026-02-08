import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            CharactersView()
                .tabItem {
                    Label("Characters", systemImage: "person.3")
                }

            StarshipsView()
                .tabItem {
                    Label("Starships", systemImage: "airplane")
                }

            PlanetsView()
                .tabItem {
                    Label("Planets", systemImage: "globe")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
