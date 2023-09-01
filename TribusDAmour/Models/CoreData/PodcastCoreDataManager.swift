//
//  PodcastCoreDataManager.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023/08/16.
//  Copyright © 2023 SEL Consulting. All rights reserved.
//

import Foundation
import CoreData

class PodcastCoreDataManager {
    
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        print("PodcastCoreDataManager initialized.")
    }
    
    func exists(podcastData: PodcastData) -> Bool {
        print("Checking if podcast exists.")
        
        let request: NSFetchRequest<Podcast> = Podcast.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", podcastData.id)
        
        do {
            let results = try context.fetch(request)
            print("Fetched \(results.count) podcast(s).")
            return results.count > 0
        } catch {
            print("Error checking if podcast exists: \(error)")
            return false
        }
    }
    
    func add(podcastData: PodcastData) {
        print("Adding podcast.")
        
        guard !exists(podcastData: podcastData) else {
            print("Podcast already exists in CoreData.")
            return
        }
        
        _ = PodcastData.toPodcast(context: context, from: podcastData)
        
        do {
            try context.save()
            print("Successfully saved podcast.")
        } catch {
            print("Error saving podcast to CoreData: \(error)")
        }
    }
    
    func remove(podcastData: PodcastData) {
        print("Removing podcast.")
        
        let request: NSFetchRequest<Podcast> = Podcast.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", podcastData.id)
        
        do {
            let results = try context.fetch(request)
            print("Fetched \(results.count) podcast(s) for removal.")
            
            for podcast in results {
                context.delete(podcast)
            }
            
            try context.save()
            print("Successfully removed podcast.")
        } catch {
            print("Error removing podcast from CoreData: \(error)")
        }
    }

    func fetchAllPodcasts() -> [PodcastData] {
        print("Fetching all podcasts.")
        
        let request: NSFetchRequest<Podcast> = Podcast.fetchRequest()
        
        do {
            let results = try context.fetch(request)
            print("Fetched \(results.count) podcasts.")
            return results.map { $0.toPodcastData() }
        } catch {
            print("Error fetching all podcasts: \(error)")
            return []
        }
    }
}
