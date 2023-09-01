//
//  PlayerStatePersistable.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-03.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

/// A protocol defining methods for managing player state persistence.
protocol PlayerStatePersistable {
    /// Save playback time for a given URL.
    func put(time: Double, for url: URL)
    
    /// Retrieve playback time for a given URL.
    /// - Returns: The saved playback time.
    func get(for url: URL) -> Double
}
