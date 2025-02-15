//
//  ProgressEntry.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 15/02/2025.
//

import Foundation

struct ProgressEntry: Codable, Identifiable {
    var id = UUID()
    var date: String  // Format: "YYYY-MM-DD"
    var flashcardsReviewed: Int
    var quizAttempts: Int
    var correctAnswers: Int

    var accuracy: Double {
        return quizAttempts > 0 ? (Double(correctAnswers) / Double(quizAttempts)) * 100 : 0
    }
}
