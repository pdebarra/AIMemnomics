//
//  HistoryView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 15/02/2025.
//

import SwiftUI

struct HistoryView: View {
    @State private var progressHistory: [ProgressEntry] = []

    var body: some View {
        List(progressHistory) { entry in
            VStack(alignment: .leading, spacing: 8) {
                Text(entry.date)
                    .font(.headline)
                    .foregroundColor(.primary)

                HStack {
                    Text("📚 Flashcards Reviewed: \(entry.flashcardsReviewed)")
                    Spacer()
                    Text("🎯 Quiz Attempts: \(entry.quizAttempts)")
                }
                .font(.subheadline)

                HStack {
                    Text("✅ Correct Answers: \(entry.correctAnswers)")
                    Spacer()
                    Text("📊 Accuracy: \(entry.accuracy, specifier: "%.1f")%")
                        .foregroundColor(entry.accuracy > 50 ? .green : .red)
                }
                .font(.subheadline)
            }
            .padding(.vertical, 5)
        }
        .navigationTitle("Progress History")
        .onAppear {
            progressHistory = loadProgressHistory().sorted { $0.date > $1.date }
        }
    }

    func loadProgressHistory() -> [ProgressEntry] {
        if let savedData = UserDefaults.standard.data(forKey: "progressHistory") {
            if let decoded = try? JSONDecoder().decode([ProgressEntry].self, from: savedData) {
                return decoded
            }
        }
        return []
    }
}

#Preview {
    HistoryView()
}
