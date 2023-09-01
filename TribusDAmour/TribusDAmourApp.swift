//
//  TribusDAmourApp.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-01.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import SwiftUI
import AVFoundation

extension UserDefaults {
    func setDefaultValues() {
        if object(forKey: "isDarkMode") == nil {
            set(false, forKey: "isDarkMode")
        }
        if object(forKey: "voiceControl") == nil {
            set(false, forKey: "voiceControl")
        }
        if object(forKey: "voiceHints") == nil {
            set(false, forKey: "voiceHints")
        }
    }
}

@main
struct TribusDAmourApp: App {
    @State private var isDarkMode: Bool = UserDefaults.standard.bool(forKey: "isDarkMode")
    let persistenceController = PersistenceController.shared
    @StateObject var podcastViewModel = PodcastViewModel()
    @StateObject private var audioSessionHandler = AudioSessionHandler()

    init() {
        UserDefaults.standard.setDefaultValues()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(podcastViewModel)
                .onAppear {
                    setAppAppearance()
                }
                .onChange(of: isDarkMode) { _ in
                    setAppAppearance()
                }
        }
    }

    func setAppAppearance() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
    }
}
