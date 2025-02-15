//
//  QuizView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI
import Speech

struct QuizView: View {
    @AppStorage("quizAttempts") private var quizAttempts = 0
    @AppStorage("correctAnswers") private var correctAnswers = 0
    @AppStorage("selectedDataset") private var selectedDataset = "numzi" // Selected JSON file
    @AppStorage("incorrectAnswers") private var incorrectAnswersData: Data = Data() // Persistent incorrect answers

    @State private var quizData: [MajorSystemEntry] = []
    @State private var currentIndex = 0
    @State private var userAnswer = ""
    @State private var showResult = false
    @State private var isCorrect = false
    @State private var incorrectAnswers: [String: Int] = [:] // Track most missed numbers
    @State private var showCorrectAnswer = false // Track if we should reveal the correct answer

    
    @State private var isListening = false
    private let speechRecognizer = SpeechRecognizer()
    
    var body: some View {
        VStack {
            if quizData.isEmpty {
                Text("No questions available.")
                    .font(.title)
                    .padding()
            } else {
                Text("What is the word for:")
                    .font(.title)

                Text(quizData[currentIndex].number)
                    .font(.system(size: 80, weight: .bold))
                    .padding()
                
                // Voice input button
                if isListening {
                    Text("🎤 Listening... Speak Now")
                        .foregroundColor(.blue)
                        .padding()
                } else {
                    Button("🎤 Use Voice Input") {
                        hideKeyboard()
                        startListening()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                if isListening {
                    Button("Stop Listening") {
                        isListening = false
                        speechRecognizer.stopTranscription() // Implement this in `SpeechRecognizer`
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                TextField("Your answer", text: $userAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .multilineTextAlignment(.center)

                Button("Check Answer") {
                    hideKeyboard()
                    ProgressManager.checkDateChangeAndSaveProgress()
                    quizAttempts += 1 // Track attempts

                    let correctWord = quizData[currentIndex].word.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                    let userResponse = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

                    if userResponse == correctWord {
                        correctAnswers += 1
                        isCorrect = true
                        showCorrectAnswer = false // Hide the correct answer since they got it right
                    } else {
                        isCorrect = false
                        showCorrectAnswer = true // Show correct answer when user is wrong
                        let missedNumber = quizData[currentIndex].number
                        incorrectAnswers[missedNumber, default: 0] += 1
                        saveIncorrectAnswers()
                    }

                    ProgressManager.saveProgress()
                    showResult = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

                if showResult {
                    Text(isCorrect ? "✅ Correct!" : "❌ Try Again")
                        .font(.title)
                        .foregroundColor(isCorrect ? .green : .red)
                        .padding()

                    // Show the correct answer only when the guess is wrong
                    if showCorrectAnswer {
                        Text("Correct answer: \(quizData[currentIndex].word)")
                            .font(.headline)
                            .foregroundColor(.orange)
                            .padding()
                    }
                }

                Button("Next") {
                    hideKeyboard()
                    userAnswer = ""
                    showResult = false
                    showCorrectAnswer = false // Hide correct answer when moving to next question
                    loadNextQuestion()
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Quiz Mode")
        .task {
            loadQuizData()
        }
        .onDisappear {
            ProgressManager.saveProgress() // Auto-save when user leaves
        }
        .onTapGesture {
            hideKeyboard() // Dismiss the keyboard when tapping outside
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    
    func startListening() {
        // Stop any ongoing transcription before starting a new one
        speechRecognizer.stopTranscription()

        isListening = true
        speechRecognizer.transcribe { recognizedText in
            DispatchQueue.main.async {
                self.userAnswer = recognizedText
                self.isListening = false
            }
        }
    }

    // Loads quiz data and picks a new random question
    func loadQuizData() {
        quizData = loadMajorSystemData(from: selectedDataset).shuffled()
        loadIncorrectAnswers()
        loadNextQuestion()
    }

    // Selects a new question and ensures randomness
    func loadNextQuestion() {
        quizData.shuffle() // Always shuffle before picking a new question
        currentIndex = Int.random(in: 0..<quizData.count)
    }

    // Saves incorrect answers persistently
    func saveIncorrectAnswers() {
        if let encoded = try? JSONEncoder().encode(incorrectAnswers) {
            incorrectAnswersData = encoded
        }
    }

    // Loads persistent incorrect answers
    func loadIncorrectAnswers() {
        if let decoded = try? JSONDecoder().decode([String: Int].self, from: incorrectAnswersData) {
            incorrectAnswers = decoded
        }
    }
}

#Preview {
    QuizView()
}
