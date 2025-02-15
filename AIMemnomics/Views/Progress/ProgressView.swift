import SwiftUI
import Charts

struct ProgressView: View {
    @State private var progressHistory: [ProgressEntry] = []
    
    var body: some View {
        TabView {
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }

            if !progressHistory.isEmpty {
                GraphView()
                    .tabItem {
                        Label("Graph", systemImage: "chart.line.uptrend.xyaxis")
                    }
            }
            
            MistakesView()
                .tabItem {
                    Label("Mistakes", systemImage: "xmark.circle.fill")
                }
        }
        .padding()
        .onAppear {
            progressHistory = loadProgressHistory() // Assign return value
        }
    }


    // MARK: - Logic Functions
    func loadProgressHistory() -> [ProgressEntry] {
        if let savedData = UserDefaults.standard.data(forKey: "progressHistory") {
            if let decoded = try? JSONDecoder().decode([ProgressEntry].self, from: savedData) {
                self.progressHistory = decoded
                return decoded
            }
        }
        return []
    }
}

#Preview {
    ProgressView()
}
