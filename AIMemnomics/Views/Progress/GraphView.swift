//
//  GraphView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 15/02/2025.
//

import SwiftUI
import Charts

struct GraphView: View {
    @State private var progressHistory: [ProgressEntry] = []
    @StateObject private var activityThresholds = ActivityThresholdsManager()

    var body: some View {
        ScrollView {
            VStack {
                Text("📊 Progress Over Time")
                    .font(.headline)
                    .padding()

                ProgressGraphView(progressHistory: progressHistory)
                    .padding(.bottom, 20)

                Text("📅 Activity Calendar")
                    .font(.headline)
                    .padding()

                CalendarHeatmap(progressHistory: progressHistory,
                                lowThreshold: activityThresholds.lowActivityThreshold,
                                mediumThreshold: activityThresholds.mediumActivityThreshold,
                                highThreshold: activityThresholds.highActivityThreshold)
                    .frame(height: 250)
                    .padding()
            }
        }
        .onAppear {
            progressHistory = loadProgressHistory()
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
    GraphView()
}
