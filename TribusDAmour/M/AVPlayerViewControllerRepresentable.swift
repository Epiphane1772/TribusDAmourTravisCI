//
//  AVPlayerViewControllerRepresentable.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 8/11/23.
//

import AVKit
import SwiftUI

struct AVPlayerViewControllerRepresentable: UIViewControllerRepresentable {
    @Binding var player: AVPlayer?
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        uiViewController.player = player
    }
}
