//
//  SettingsView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedDataset") private var selectedDataset = "numzi" // Default dataset

    var body: some View {
        Form {
            Section(header: Text("Select Peg Word List")) {
                Picker("Dataset", selection: $selectedDataset) {
                    Text("Numzi").tag("numzi")
                    Text("Alternative").tag("alternative")
                }
                .pickerStyle(SegmentedPickerStyle()) // You can also use .MenuPickerStyle()
            }
        }
        .navigationTitle("Settings")
    }
}
