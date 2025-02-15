//
//  MistakesView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 15/02/2025.
//

import SwiftUI

struct MistakesView: View {
    @AppStorage("incorrectAnswers") private var incorrectAnswersData: Data = Data()
    @State private var mostMissedNumbers: [String: Int] = [:]
    @State private var showDeleteConfirmation = false

    var body: some View {
        VStack {
            Text("❌ Review Mistakes")
                .font(.largeTitle)
                .padding()

            if mostMissedNumbers.isEmpty {
                Text("No mistakes recorded yet.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List {
                    ForEach(mostMissedNumbers.sorted(by: { $0.value > $1.value }), id: \.key) { key, value in
                        DisclosureGroup("\(key) (\(value) times)") {
                            Text("Word: \(getWordForNumber(key))")
                                .foregroundColor(.blue)
                                .padding(.leading, 10)
                        }
                    }
                    .onDelete(perform: deleteMistake)
                }

                Button("Clear All Mistakes", role: .destructive) {
                    showDeleteConfirmation = true
                }
                .alert("Are you sure?", isPresented: $showDeleteConfirmation) {
                    Button("Cancel", role: .cancel) {}
                    Button("Delete", role: .destructive) {
                        mostMissedNumbers.removeAll()
                    }
                }
            }
        }
        .onAppear {
            loadIncorrectAnswers()
        }
    }

    func deleteMistake(at offsets: IndexSet) {
        let keys = mostMissedNumbers.keys.sorted(by: { mostMissedNumbers[$0]! > mostMissedNumbers[$1]! })
        for index in offsets {
            mostMissedNumbers.removeValue(forKey: keys[index])
        }
    }

    func loadIncorrectAnswers() {
        if let decoded = try? JSONDecoder().decode([String: Int].self, from: incorrectAnswersData) {
            mostMissedNumbers = decoded
        }
    }
    
    func getWordForNumber(_ number: String) -> String {
        let data = loadMajorSystemData(from: "numzi")
        return data.first(where: { $0.number == number })?.word ?? "No word found"
    }
}

#Preview {
    MistakesView()
}
