//
//  SplashScreenView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var scale = 0.8
    @State private var opacity = 0.5

    var body: some View {
        if isActive {
            MainMenuView() // Replace with your main screen
        } else {
            VStack {
                Image(systemName: "brain.head.profile") // Replace with your app logo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            scale = 1.2
                            opacity = 1.0
                        }
                    }

                Text("AIMemnomics")
                    .font(.largeTitle)
                    .bold()
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            opacity = 1.0
                        }
                    }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
