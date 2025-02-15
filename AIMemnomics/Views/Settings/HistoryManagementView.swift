//
//  HistoryManagementView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

struct HistoryManagementView: View {
    @State private var progressHistory: [ProgressEntry] = []

    var body: some View {
        VStack {
            Text("Manage History")
                .font(.largeTitle)
                .padding()

            if progressHistory.isEmpty {
                Text("No history available.")
                    .foregroundColor(.gray)
            } else {
                List {
                    ForEach(progressHistory) { entry in
                        HStack {
                            Text(entry.date)
                                .font(.headline)
                            Spacer()
                            Text("\(entry.accuracy, specifier: "%.1f")%")
                                .foregroundColor(entry.accuracy > 50 ? .green : .red)
                        }
                    }
                    .onDelete(perform: deleteEntry)
                }
            }

            Button("Clear All History", role: .destructive) {
                clearAllHistory()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .onAppear {
            loadProgressHistory()
        }
    }

    // Load progress history from UserDefaults
    private func loadProgressHistory() {
        if let savedData = UserDefaults.standard.data(forKey: "progressHistory") {
            if let decoded = try? JSONDecoder().decode([ProgressEntry].self, from: savedData) {
                self.progressHistory = decoded
            }
        }
    }

    // Delete a single entry
    private func deleteEntry(at offsets: IndexSet) {
        progressHistory.remove(atOffsets: offsets)
        saveUpdatedHistory()
    }

    // Clear all history
    private func clearAllHistory() {
        progressHistory.removeAll()
        saveUpdatedHistory()
    }

    // Save updated history back to UserDefaults
    private func saveUpdatedHistory() {
        if let encoded = try? JSONEncoder().encode(progressHistory) {
            UserDefaults.standard.set(encoded, forKey: "progressHistory")
        }
    }
}

#Preview {
    HistoryManagementView()
}
