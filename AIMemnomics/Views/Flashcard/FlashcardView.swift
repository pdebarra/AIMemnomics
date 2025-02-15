//
//  FlashcardView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

struct FlashcardView: View {
    @AppStorage("flashcardsReviewed") private var flashcardsReviewed = 0
    @AppStorage("selectedDataset") private var selectedDataset = "numzi" // Selected JSON file
    @State private var flashcards: [MajorSystemEntry] = []
    @State private var currentIndex = 0
    @State private var showWord = false

    var body: some View {
        VStack {
            if flashcards.isEmpty {
                Text("No flashcards available.")
                    .font(.title)
                    .padding()
            } else {
                Text(flashcards[currentIndex].number)
                    .font(.system(size: 100, weight: .bold))
                    .padding()

                if showWord {
                    Text(flashcards[currentIndex].word)
                        .font(.title)
                        .transition(.opacity)
                }

                Button(action: {
                    withAnimation {
                        showWord.toggle()
                    }
                }) {
                    Text(showWord ? "Hide Word" : "Reveal Word")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Button(action: {
                    ProgressManager.checkDateChangeAndSaveProgress()
                    showWord = false

                    if !flashcards.isEmpty {
                        currentIndex = Int.random(in: 0..<flashcards.count) // Randomly pick a new flashcard
                        flashcardsReviewed += 1 // Track flashcard usage
                    }
                    
                    ProgressManager.saveProgress()
                }) {
                    Text("Next Flashcard")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
        .navigationTitle("Flashcards")
        .task {
            loadFlashcards()
            pickRandomFlashcard()
        }
        .onDisappear {
            ProgressManager.saveProgress() // Auto-save when user leaves the screen
        }
    }

    func loadFlashcards() {
        flashcards = loadMajorSystemData(from: selectedDataset).shuffled()
    }

    func pickRandomFlashcard() {
        if !flashcards.isEmpty {
            currentIndex = Int.random(in: 0..<flashcards.count)
        }
    }
}

#Preview {
    FlashcardView()
}
