//
//  ExplanationView.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

struct ExplanationView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Understanding the Major System")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()

                Text("""
The Major System is a mnemonic technique used to remember numbers. It works by converting numbers into consonant sounds, then forming words by adding vowels. These words are easier to visualize and remember.

### How It Works
1. Each digit (0-9) is assigned a specific consonant sound.
2. Combine the sounds to create a word for each number.
3. Use the word to create vivid mental images to remember the number.

### Digit-to-Sound Mapping
- 0 → **s** or **z** (e.g., Sea, Zoo)
- 1 → **t** or **d** (e.g., Tie, Dog)
- 2 → **n** (e.g., Net, Nail)
- 3 → **m** (e.g., Map, Mom)
- 4 → **r** (e.g., Rose, Rain)
- 5 → **l** (e.g., Log, Lily)
- 6 → **j**, **sh**, or **ch** (e.g., Shoe, Chess)
- 7 → **k** or **g** (e.g., Cat, Goose)
- 8 → **f** or **v** (e.g., Fan, Fish)
- 9 → **p** or **b** (e.g., Pie, Bat)

### Example:
- **23** → "Nemo" (N = 2, M = 3)
- **45** → "Roll" (R = 4, L = 5)

By associating these words with numbers, you can easily recall sequences of digits.
""")
                    .font(.body)
                    .padding()

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Major System Explanation")
    }
}

#Preview {
    ExplanationView()
}
