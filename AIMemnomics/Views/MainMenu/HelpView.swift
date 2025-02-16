//
//  HelpView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 16/02/2025.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("📖 Understanding the Major System")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)

                Text("""
                The **Major System** is a mnemonic technique that helps you remember numbers by converting them into words.
                
                🧠 **Each digit (0-9) is assigned a specific sound:**
                """)
                    .font(.body)
                    .padding(.horizontal)

        

                Text("🔢 **Number-to-Sound Mapping**")
                    .font(.headline)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 5) {
                    majorSystemRule(number: "0", sound: "S, Z, Soft C", example: "Zero → **S**un")
                    majorSystemRule(number: "1", sound: "T, D", example: "One → **T**ea")
                    majorSystemRule(number: "2", sound: "N", example: "Two → **N**et")
                    majorSystemRule(number: "3", sound: "M", example: "Three → **M**oon")
                    majorSystemRule(number: "4", sound: "R", example: "Four → **R**ose")
                    majorSystemRule(number: "5", sound: "L", example: "Five → **L**ion")
                    majorSystemRule(number: "6", sound: "J, SH, CH", example: "Six → **CH**ess")
                    majorSystemRule(number: "7", sound: "K, Hard C, G", example: "Seven → **G**oal")
                    majorSystemRule(number: "8", sound: "F, V", example: "Eight → **F**ish")
                    majorSystemRule(number: "9", sound: "P, B", example: "Nine → **P**ipe")
                }
                .padding(.horizontal)

                Text("📝 **Example Conversion**")
                    .font(.headline)
                    .padding(.top)

                Text("""
                Let’s say you want to remember the number **42**.
                - **4** → 'R'
                - **2** → 'N'
                - Possible word: **"Rain"**
                - Visualize a **rainstorm** to associate with 42.
                """)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("How It Works")
    }

    // Helper function to format each rule
    func majorSystemRule(number: String, sound: String, example: String) -> some View {
        HStack {
            Text("\(number):")
                .fontWeight(.bold)
                .frame(width: 30, alignment: .leading)
            Text(sound)
                .foregroundColor(.blue)
            Spacer()
            Text(example)
                .italic()
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    HelpView()
}
