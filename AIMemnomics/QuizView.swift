//
//  QuizView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

struct QuizView: View {
    @AppStorage("selectedDataset") private var selectedDataset = "numzi" // Selected JSON file
    @State private var quizData: [MajorSystemEntry] = []
    @State private var currentIndex = 0
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var isCorrect = false

    var body: some View {
        VStack {
            if quizData.isEmpty {
                Text("No questions available.")
                    .font(.title)
                    .padding()
            } else {
                Text("What is the word for:")
                    .font(.title)

                Text(quizData[currentIndex].number)
                    .font(.system(size: 80, weight: .bold))
                    .padding()

                TextField("Your answer", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .multilineTextAlignment(.center)

                Button("Check Answer") {
                    isCorrect = userAnswer.lowercased() == quizData[currentIndex].word.lowercased()
                    showResult = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                if showResult {
                    Text(isCorrect ? "✅ Correct!" : "❌ Try Again")
                        .font(.title)
                        .foregroundColor(isCorrect ? .green : .red)
                        .padding()
                }

                Button("Next") {
                    userAnswer = ""
                    showResult = false
                    currentIndex = Int.random(in: 0..<quizData.count) // Pick a random question
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Quiz Mode")
        .onAppear {
            quizData = loadMajorSystemData(from: selectedDataset).shuffled() // Shuffle dataset on load
            currentIndex = Int.random(in: 0..<quizData.count) // Start with a random question
        }
    }
}

#Preview {
    QuizView()
}
