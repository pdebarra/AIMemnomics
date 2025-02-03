//
//  ProgressView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

struct ProgressView: View {
    @AppStorage("correctAnswers") private var correctAnswers = 0
    @AppStorage("totalAttempts") private var totalAttempts = 0

    var accuracy: Double {
        totalAttempts > 0 ? (Double(correctAnswers) / Double(totalAttempts)) * 100 : 0
    }

    var body: some View {
        VStack {
            Text("Your Progress")
                .font(.largeTitle)
                .padding()

            Text("Correct Answers: \(correctAnswers)")
                .font(.title2)
            Text("Total Attempts: \(totalAttempts)")
                .font(.title2)
            Text("Accuracy: \(accuracy, specifier: "%.1f")%")
                .font(.title)
                .foregroundColor(accuracy > 50 ? .green : .red)
                .padding()

            Button("Reset Progress") {
                correctAnswers = 0
                totalAttempts = 0
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationTitle("Progress")
    }
}

#Preview {
    ProgressView()
}
