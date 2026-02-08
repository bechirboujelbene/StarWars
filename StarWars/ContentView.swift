//
//  ContentView.swift
//  StarWars
//
//  Created by bechir boujelbene on 27.04.25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var authService = AuthenticationService()

    var body: some View {
        
        Group {
            if authService.isAuthenticated {
                // If authenticated, show the main app content
                MainTabView()
                    .environmentObject(authService)
            } else if authService.requiresPINEntry {
                
                PINEntryView()
                    .environmentObject(authService)
            } else {
                
                BiometricAuthView() 
                    .environmentObject(authService)
            }
        }
        
        .transition(.opacity.animation(.easeInOut))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
