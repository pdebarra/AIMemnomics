//
//  QuizView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

struct QuizView: View {
    @State private var currentIndex = 0
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var isCorrect = false

    let quizData = [
        (number: "00", word: "S.O.S"),
        (number: "12", word: "Tin"),
        (number: "34", word: "Mower"),
        (number: "99", word: "Pope")
    ]

    var body: some View {
        VStack {
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
            }

            Button("Next") {
                userAnswer = ""
                showResult = false
                currentIndex = (currentIndex + 1) % quizData.count
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("Quiz Mode")
    }
}

#Preview {
    QuizView()
}
