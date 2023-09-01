//import SwiftUI
//import CoreData
//
//struct PodcastDetailViewContent: View {
//    let podcast: PodcastData
//    @Environment(\.managedObjectContext) var moc
//    @State private var isFavorite: Bool = false
//    @State private var isLoadingAudio: Bool = false
//    @State private var buttonRotation: Double = 0
//    @State private var playbackProgress: Double = 0.5
//    @ObservedObject var audioManager: AudioPlayerManager
//
//    // ... [Rest of the code remains unchanged]
//
//    func checkIfFavorite() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Podcast")
//        fetchRequest.predicate = NSPredicate(format: "id == %lld", self.podcast.id)
//
//        do {
//            let fetchedResults = try self.moc.fetch(fetchRequest) as? [NSManagedObject]
//            self.isFavorite = !(fetchedResults?.isEmpty ?? true)
//        } catch {import SwiftUI
//            import CoreData
//
//            struct PodcastDetailViewContent: View {
//                let podcast: PodcastData
//                @Environment(\.managedObjectContext) var moc
//                @State private var isFavorite: Bool = false
//                @State private var isLoadingAudio: Bool = false
//                @State private var buttonRotation: Double = 0
//                @State private var playbackProgress: Double = 0.5
//                @ObservedObject var audioManager: AudioPlayerManager
//
//                var body: some View {
//                    VStack {
//                        Text(podcast.title ?? "Unknown Title")
//                            .font(.headline)
//                        Text(podcast.author ?? "Unknown Author")
//                            .font(.subheadline)
//                        Text(podcast.description ?? "No Description")
//                            .padding()
//                        
//                        Button(isFavorite ? "Remove from Favorites" : "Add to Favorites") {
//                            toggleFavorites()
//                        }
//                        .padding(.vertical)
//
//                        // TODO: Add your audio controls, playback progress, and other UI elements here.
//                    }
//                    .onAppear(perform: checkIfFavorite)
//                }
//
//                func checkIfFavorite() {
//                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Podcast")
//                    fetchRequest.predicate = NSPredicate(format: "id == %lld", self.podcast.id)
//
//                    do {
//                        let fetchedResults = try self.moc.fetch(fetchRequest) as? [NSManagedObject]
//                        self.isFavorite = !(fetchedResults?.isEmpty ?? true)
//                    } catch {
//                        print("Failed to fetch podcast: \(error)")
//                    }
//                }
//
//                func toggleFavorites() {
//                    if self.isFavorite {
//                        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Podcast")
//                        fetchRequest.predicate = NSPredicate(format: "id == %lld", self.podcast.id)
//
//                        do {
//                            if let fetchedResults = try self.moc.fetch(fetchRequest) as? [NSManagedObject], let podcastToDelete = fetchedResults.first {
//                                self.moc.delete(podcastToDelete)
//                                try self.moc.save()
//                                self.isFavorite = false
//                            }
//                        } catch {
//                            print("Failed to delete podcast: \(error)")
//                        }
//                    } else {
//                        let newPodcast = Podcast(context: self.moc)
//                        newPodcast.id = Int32(self.podcast.id)
//                        newPodcast.title = self.podcast.title
//                        newPodcast.author = self.podcast.author
//                        newPodcast.audioUrl = self.podcast.audioUrl
//                        newPodcast.setValue(self.podcast.description, forKey: "description")
//                        
//                        do {
//                            try self.moc.save()
//                            self.isFavorite = true
//                        } catch {
//                            print("Failed to save podcast: \(error)")
//                        }
//                    }
//                }
//            }
//
//            print("Failed to fetch podcast: \(error)")
//        }
//    }
//
//    func toggleFavorites() {
//        if self.isFavorite {
//            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Podcast")
//            fetchRequest.predicate = NSPredicate(format: "id == %lld", self.podcast.id)
//
//            do {
//                if let fetchedResults = try self.moc.fetch(fetchRequest) as? [NSManagedObject], let podcastToDelete = fetchedResults.first {
//                    self.moc.delete(podcastToDelete)
//                    try self.moc.save()
//                    self.isFavorite = false
//                }
//            } catch {
//                print("Failed to delete podcast: \(error)")
//            }
//        } else {
//            let newPodcast = Podcast(context: self.moc)
//            newPodcast.id = Int32(self.podcast.id)
//            newPodcast.title = self.podcast.title
//            newPodcast.author = self.podcast.author
//            newPodcast.audioUrl = self.podcast.audioUrl
//            newPodcast.setValue(self.podcast.description, forKey: "description")
//            
//            do {
//                try self.moc.save()
//                self.isFavorite = true
//            } catch {
//                print("Failed to save podcast: \(error)")
//            }
//        }
//    }
//}
