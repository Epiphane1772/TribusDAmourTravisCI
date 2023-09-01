//
//  PodcastViewModel.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 2023-08-10.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import SwiftUI

class PodcastViewModel: ObservableObject {
    @Published var selectedPodcast: PodcastData?
}
