//
//  TBDASettingsView.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-03.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import SwiftUI
import AVFoundation

// View for application settings
struct TBDASettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("voiceHints") private var voiceHints = true

    let speechSynthesizer = AVSpeechSynthesizer()

    var body: some View {
        NavigationView {
            Form {
                // Appearance Section
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .accessibility(label: Text("Dark Mode"))
                        .onChange(of: isDarkMode) { value in
                            setAppAppearance(value)
                            announceChange(withMessage: value ? "Dark mode is on." : "Dark mode is off.")
                        }
                }
                
                // Voice Hints Section
                Section(header: Text("Voice Hints")) {
                    Toggle("Enable Voice Hints", isOn: $voiceHints)
                        .accessibility(label: Text("Enable Voice Hints"))
                        .onChange(of: voiceHints) { isEnabled in
                            announceChange(withMessage: isEnabled ? "Voice hint is on." : "Voice hint is off.")
                        }
                }
            }
            .navigationTitle("Settings")
        }
    }
    
    // Set the application appearance based on the Dark Mode setting
    func setAppAppearance(_ isDark: Bool) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
    
    // Announce setting changes using speech synthesis
    func announceChange(withMessage message: String) {
        if voiceHints {
            let utterance = AVSpeechUtterance(string: message)
            utterance.volume = 1.0
            speechSynthesizer.speak(utterance)
        }
    }
}

struct TBDASettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TBDASettingsView()
    }
}
