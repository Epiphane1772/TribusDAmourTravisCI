//
//  PlayerStatePersistence.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-16.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

/// A class responsible for managing player state persistence.
class PlayerStatePersistence {
    
    static let shared = PlayerStatePersistence()
    
    private init() {}
    
    /// Generate a key for the given URL.
    func key(for url: URL) -> String {
        let storageKey = "PlayerState-\(url.absoluteString)"
        print("[DEBUG] Generated key for URL: \(storageKey)")
        return storageKey
    }
    
    /// Save playback time for a given URL.
    func put(time: Double, for url: URL) {
        let storageKey = key(for: url)
        print("[DEBUG] Saving time \(time) for key \(storageKey).")
        UserDefaults.standard.setValue(time, forKey: storageKey)
    }
    
    /// Retrieve playback time for a given URL.
    func get(for url: URL) -> Double {
        let storageKey = key(for: url)
        let savedTime = UserDefaults.standard.double(forKey: storageKey)
        print("[DEBUG] Fetching time for key \(storageKey): \(savedTime).")
        return savedTime
    }
}
