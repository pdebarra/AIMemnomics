//
//  StatsView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 15/02/2025.
//

import SwiftUI

struct StatsView: View {
    @AppStorage("flashcardsReviewed") private var flashcardsReviewed = 0
    @AppStorage("quizAttempts") private var quizAttempts = 0
    @AppStorage("correctAnswers") private var correctAnswers = 0
    @State private var currentStreak = 0
    @State private var longestStreak = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Your Progress")
                    .font(.largeTitle)
                    .padding()

                progressBox(title: "📚 Flashcards Reviewed", value: "\(flashcardsReviewed)")
                progressBox(title: "🎯 Quiz Attempts", value: "\(quizAttempts)")
                progressBox(title: "✅ Correct Answers", value: "\(correctAnswers)")

                DisclosureGroup("🔥 Streaks") {
                    progressBox(title: "Current Streak", value: "\(currentStreak) days")
                    progressBox(title: "Longest Streak", value: "\(longestStreak) days")
                }
            }
            .padding()
        }
    }

    private func progressBox(title: String, value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.primary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    StatsView()
}

#Preview {
    StatsView()
}
