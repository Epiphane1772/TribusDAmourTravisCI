//
//  PlayerStatePersistence.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-03. // Adjust to your original creation date
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

protocol PlayerStatePersistable {
    func put(time: Double, for url: URL)
    func get(for url: URL) -> Double
}

class PlayerStatePersistence: PlayerStatePersistable {
    static let shared = PlayerStatePersistence()
    private let userDefaultsKey = "PlayerStatePersistenceKey"

    private init() {}

    func put(time: Double, for url: URL) {
        var persistenceDict: [String: Double] = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: Double] ?? [:]
        persistenceDict[url.absoluteString] = time
        UserDefaults.standard.setValue(persistenceDict, forKey: userDefaultsKey)
    }

    func get(for url: URL) -> Double {
        let persistenceDict: [String: Double] = UserDefaults.standard.dictionary(forKey: userDefaultsKey) as? [String: Double] ?? [:]
        return persistenceDict[url.absoluteString] ?? 0.0
    }
}
