//
//  CalendarHeatmap.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

struct CalendarHeatmap: View {
    let progressHistory: [ProgressEntry]
    let lowThreshold: Int
    let mediumThreshold: Int
    let highThreshold: Int

    private let daysInWeek = 7

    var body: some View {
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date()
        let endDate = Date()

        let allDates = generateDateRange(from: startDate, to: endDate)
        let progressMap = createProgressMap()

        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5), count: daysInWeek), spacing: 5) {
            ForEach(allDates, id: \.self) { date in
                let activityLevel = progressMap[formattedDate(for: date)] ?? 0
                let color = determineColor(for: activityLevel)

                Circle()
                    .fill(color)
                    .frame(width: 20, height: 20)
                    .overlay(Text(dateIndicator(for: date))
                        .font(.caption)
                        .foregroundColor(.white))
            }
        }
    }

    func generateDateRange(from startDate: Date, to endDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = startDate

        while date <= endDate {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }

        return dates
    }

    func createProgressMap() -> [String: Int] {
        var map: [String: Int] = [:]
        for entry in progressHistory {
            let date = entry.date
            let totalActivity = entry.flashcardsReviewed + entry.quizAttempts
            map[date] = totalActivity
        }
        return map
    }

    func determineColor(for activity: Int) -> Color {
        switch activity {
        case 0:
            return Color.gray.opacity(0.3) // No activity
        case 1..<lowThreshold:
            return Color.blue.opacity(0.3) // Low activity
        case lowThreshold..<mediumThreshold:
            return Color.blue.opacity(0.6) // Medium activity
        case mediumThreshold..<highThreshold:
            return Color.blue.opacity(0.9) // High activity
        default:
            return Color.blue // Very high activity
        }
    }

    func formattedDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    func dateIndicator(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarHeatmap(progressHistory: [], lowThreshold: 5, mediumThreshold: 15, highThreshold: 30)
}
