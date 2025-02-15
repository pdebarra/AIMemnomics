//
//  ProgressManager.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import Foundation
import SwiftUI

struct ProgressManager {
    @AppStorage("flashcardsReviewed") static private var flashcardsReviewed = 0
    @AppStorage("quizAttempts") static private var quizAttempts = 0
    @AppStorage("correctAnswers") static private var correctAnswers = 0
    @AppStorage("lastPlayedDate") static private var lastPlayedDate = ""

    // 🚀 Check if the day has changed, save progress, and reset if needed
    static func checkDateChangeAndSaveProgress() {
        let today = formattedDate()
        
        if lastPlayedDate != today {
            saveProgress() // Save previous day's progress
            resetProgress() // Reset for the new day
        }
    }

    static func saveProgress() {
        let today = formattedDate()
        var history = loadProgressHistory()

        // If the day has changed, save the previous day's stats
        if lastPlayedDate != today {
            if !lastPlayedDate.isEmpty {
                let previousEntry = ProgressEntry(
                    date: lastPlayedDate,
                    flashcardsReviewed: flashcardsReviewed,
                    quizAttempts: quizAttempts,
                    correctAnswers: correctAnswers
                )
                history.append(previousEntry)
            }

            // Reset progress for the new day
            resetProgress()
        }

        // ✅ Check if today's entry already exists
        if let index = history.firstIndex(where: { $0.date == today }) {
            // ✅ Update existing entry instead of replacing
            history[index].flashcardsReviewed = flashcardsReviewed
            history[index].quizAttempts = quizAttempts
            history[index].correctAnswers = correctAnswers
        } else {
            // ✅ Create a new entry if today’s progress is not recorded yet
            let todayEntry = ProgressEntry(
                date: today,
                flashcardsReviewed: flashcardsReviewed,
                quizAttempts: quizAttempts,
                correctAnswers: correctAnswers
            )
            history.append(todayEntry)
        }

        // Save updated history back to UserDefaults
        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: "progressHistory")
        }
    }

    static func resetProgress() {
        flashcardsReviewed = 0
        quizAttempts = 0
        correctAnswers = 0
        lastPlayedDate = formattedDate()
    }

    static func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    static func loadProgressHistory() -> [ProgressEntry] {
        if let savedData = UserDefaults.standard.data(forKey: "progressHistory") {
            if let decoded = try? JSONDecoder().decode([ProgressEntry].self, from: savedData) {
                return decoded
            }
        }
        return []
    }
}
