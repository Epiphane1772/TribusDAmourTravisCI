import SwiftUI
import AVKit

// Manager to handle AVPlayer instances
class PlayerManager: ObservableObject {
    static let shared = PlayerManager()
    var player: AVPlayer?
    private init() {}
}

// UIViewControllerRepresentable for AVPlayerViewController
struct AVPlayerViewControllerWrapper: UIViewControllerRepresentable {
    let url: URL
    var image: UIImage?

    // Create a coordinator to manage AVPlayerViewController actions
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, AVPlayerViewControllerDelegate {
        var parent: AVPlayerViewControllerWrapper
        var timeObserverToken: Any?

        init(_ parent: AVPlayerViewControllerWrapper) {
            self.parent = parent
        }

        // Clean up resources when coordinator is deallocated
        deinit {
            if let token = timeObserverToken {
                PlayerManager.shared.player?.removeTimeObserver(token)
            }
            NotificationCenter.default.removeObserver(self)
        }

        // Handle playback finish event
        @objc func playerDidFinishPlaying(notification: NSNotification) {
            guard let player = PlayerManager.shared.player else { return }
            saveCurrentTime(from: player)
        }

        // Save the current playback time
        func saveCurrentTime(from player: AVPlayer) {
            if let currentTime = player.currentItem?.currentTime() {
                PlayerStatePersistence.shared.put(time: currentTime.seconds, for: parent.url)
            }
        }
    }

    // Create and configure AVPlayerViewController
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.delegate = context.coordinator
        let savedTime = PlayerStatePersistence.shared.get(for: self.url)
        let playerItem = AVPlayerItem(url: self.url)
        
        // Initialize or replace AVPlayer
        if PlayerManager.shared.player == nil {
            PlayerManager.shared.player = AVPlayer(playerItem: playerItem)
        } else {
            PlayerManager.shared.player?.replaceCurrentItem(with: playerItem)
        }

        // Add observer for player item finish playback
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(context.coordinator.playerDidFinishPlaying(notification:)),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: playerItem
        )

        // Setup periodic time observer
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        context.coordinator.timeObserverToken = PlayerManager.shared.player?.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { time in
            context.coordinator.saveCurrentTime(from: PlayerManager.shared.player!)
        }
        
        // Configure AVPlayerViewController with player and artwork
        controller.player = PlayerManager.shared.player
        if savedTime > 0 {
            PlayerManager.shared.player?.seek(
                to: CMTime(seconds: savedTime, preferredTimescale: CMTimeScale(NSEC_PER_SEC)),
                completionHandler: { _ in
                    PlayerManager.shared.player?.play()
                }
            )
        } else {
            PlayerManager.shared.player?.play()
        }
        setupArtwork(in: controller)
        return controller
    }

    // Setup artwork in AVPlayerViewController
    private func setupArtwork(in controller: AVPlayerViewController) {
        if let artworkImage = image {
            print("[DEBUG] Artwork image is available.")
            let imageView = UIImageView(image: artworkImage)
            let aspectFitRect = AVMakeRect(aspectRatio: artworkImage.size, insideRect: controller.view.bounds)
            imageView.frame = aspectFitRect
            imageView.contentMode = .scaleAspectFit
            controller.contentOverlayView?.addSubview(imageView)
            controller.contentOverlayView?.backgroundColor = .red
            print("[DEBUG] Artwork should now be displayed.")
        } else {
            print("[DEBUG] Artwork image is nil.")
        }
    }

    // Update AVPlayerViewController when UI changes
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if let player = uiViewController.player, player.timeControlStatus == .paused {
            context.coordinator.saveCurrentTime(from: player)
        }
    }

    // Clean up AVPlayer resources
    func dismantleUIViewController(_ uiViewController: AVPlayerViewController, coordinator: Coordinator) {
        if let player = uiViewController.player {
            coordinator.saveCurrentTime(from: player)
        }
    }
}
