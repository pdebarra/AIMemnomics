//
//  AIMemnomicsApp.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

@main
struct AIMemnomicsApp: App {
    @State private var showSplash = true // Controls splash visibility

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                ContentView() // Which now loads MainMenuView
            }
        }
    }
}
