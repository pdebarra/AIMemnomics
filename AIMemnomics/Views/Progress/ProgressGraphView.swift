//
//  ProgressGraphView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI
import Charts

struct ProgressGraphView: View {
    let progressHistory: [ProgressEntry]

    var body: some View {
        VStack {
            Text("Accuracy Over Time")
                .font(.headline)

            Chart {
                ForEach(progressHistory) { entry in
                    LineMark(
                        x: .value("Date", entry.date),
                        y: .value("Accuracy", entry.accuracy)
                    )
                }
            }
            .frame(height: 200)
        }
        .padding()
    }
}

