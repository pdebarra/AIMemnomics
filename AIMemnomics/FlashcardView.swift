import SwiftUI

import SwiftUI

struct FlashcardView: View {
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
                    showWord = false
                    currentIndex = Int.random(in: 0..<flashcards.count) // Randomly pick a new flashcard
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
        .onAppear {
            flashcards = loadMajorSystemData(from: selectedDataset).shuffled() // Shuffle on load
            currentIndex = Int.random(in: 0..<flashcards.count) // Start with a random index
        }
    }
}

#Preview {
    FlashcardView()
}
