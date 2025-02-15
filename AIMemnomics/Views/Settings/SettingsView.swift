//
//  SettingsView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedDataset") private var selectedDataset = "numzi" // Default dataset
    @StateObject private var activityThresholds = ActivityThresholdsManager()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select Peg Word List")) {
                    Picker("Dataset", selection: $selectedDataset) {
                        Text("Numzi").tag("numzi")
                        Text("Alternative").tag("alternative")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Progress Management")) {
                    NavigationLink("📊 Manage Progress History", destination: HistoryManagementView())
                }
                
                Section(header: Text("Activity Level Thresholds")) {
                    Stepper("Low Activity (≤ \(activityThresholds.lowActivityThreshold))",
                            value: $activityThresholds.lowActivityThreshold, in: 1...50)
                    
                    Stepper("Medium Activity (≤ \(activityThresholds.mediumActivityThreshold))",
                            value: $activityThresholds.mediumActivityThreshold, in: 1...100)
                    
                    Stepper("High Activity (≥ \(activityThresholds.highActivityThreshold))",
                            value: $activityThresholds.highActivityThreshold, in: 1...200)
                }            }
            .navigationTitle("Settings")
        }
    }
}


#Preview {
    SettingsView()
}
