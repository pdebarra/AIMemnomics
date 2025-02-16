import SwiftUI

struct MainMenuView: View {
    private let sectionWidth: CGFloat = 250  // Standardized width
    private let largeButtonHeight: CGFloat = 120
    private let smallButtonHeight: CGFloat = 100
    private let buttonSpacing: CGFloat = 15
    private let helpButtonHeight: CGFloat = 60

    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // **Gradient Background**
                LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()

                VStack {
                    // **Title**
                    Text("AIMemnomics")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(.top, 20)
                    
                    // **First Section - Two Large Buttons**
                    LazyVGrid(columns: [GridItem(.flexible())], spacing: buttonSpacing) {
                        MainMenuButton(title: "📚 Flashcards", destination: FlashcardView(), color: Color.orange, height: largeButtonHeight)
                        MainMenuButton(title: "🎯 Quiz", destination: QuizView(), color: Color.green, height: largeButtonHeight)
                    }
                    .frame(width: sectionWidth)

                    // **Ensure Equal Spacing Before the Second Section**
                    .padding(.bottom, buttonSpacing) // Matches button spacing

                    // **Second Section - Two Side-by-Side Buttons**
                    LazyVGrid(columns: columns, spacing: buttonSpacing) {
                        MainMenuButton(title: "📊 Progress", destination: ProgressView(), color: Color.blue, height: smallButtonHeight)
                        MainMenuButton(title: "⚙️ Settings", destination: SettingsView(), color: Color.gray, height: smallButtonHeight)
                    }
                    .frame(width: sectionWidth)

                    Spacer()

                    // **Help Button - Bottom of Screen**
                    MainMenuButton(title: "❓ Help", destination: HelpView(), color: Color.red, height: helpButtonHeight)
                        .frame(width: sectionWidth / 1.5)
                        .padding(.bottom, 25)
                }
            }
        }
    }
}

// **Refactored Button Component**
struct MainMenuButton<Destination: View>: View {
    var title: String
    var destination: Destination
    var color: Color
    var height: CGFloat
    @State private var isPressed = false

    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, minHeight: height)
                .background(color.gradient)
                .cornerRadius(20)
                .shadow(color: color.opacity(0.5), radius: 8, x: 4, y: 4)
        }
        .simultaneousGesture(TapGesture().onEnded {
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
            }
        })
    }
}

#Preview {
    MainMenuView()
}
