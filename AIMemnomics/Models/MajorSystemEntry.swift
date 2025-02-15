//
//  MajorSystemEntry.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import Foundation

struct MajorSystemEntry: Codable {
    let number: String
    let word: String
}

// Function to Load JSON Data
func loadMajorSystemData(from fileName: String) -> [MajorSystemEntry] {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("⚠️ JSON file '\(fileName)' not found!")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode([MajorSystemEntry].self, from: data)
    } catch {
        print("⚠️ Failed to load JSON from '\(fileName)': \(error.localizedDescription)")
        return []
    }
}
