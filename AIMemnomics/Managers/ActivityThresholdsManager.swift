//
//  ActivityThresholdsManager.swift
//  AIMemnomics
//
//  Created by Patrick Barry on 03/02/2025.
//

import SwiftUI

class ActivityThresholdsManager: ObservableObject {
    @AppStorage("lowActivityThreshold") var lowActivityThreshold = 5
    @AppStorage("mediumActivityThreshold") var mediumActivityThreshold = 15
    @AppStorage("highActivityThreshold") var highActivityThreshold = 30
}
