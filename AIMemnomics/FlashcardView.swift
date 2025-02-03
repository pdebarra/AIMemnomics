import SwiftUI

struct FlashcardView: View {
    @State private var currentIndex = 0
    @State private var showWord = false

    let flashcards = [
        (number: "00", word: "S.O.S"),
        (number: "12", word: "Tin"),
        (number: "34", word: "Mower"),
        (number: "99", word: "Pope")
    ]

    var body: some View {
        VStack {
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
                currentIndex = (currentIndex + 1) % flashcards.count
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
        .navigationTitle("Flashcards")
    }
}

#Preview {
    FlashcardView()
}
