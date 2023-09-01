//
//  TBDARequest.swift
//  TribusDAmour
//
//  Created by Stephane Lefebvre on 5/11/23.
//  Copyright © 2023 Stephane Lefebvre. All rights reserved.
//

import Foundation

enum PodcastRequest: RequestProtocol {
    case list
    case singlePodcast(id: String)
    case search(text: String)

    var host: String {
        return "api.selconsulting.io"
    }

    var path: String {
        switch self {
        case .list:
            return "/podcast"
        case let .singlePodcast(id):
            return "/podcast/\(id)"
        case let .search(text):
            return "/podcast/search/\(text.removingPercentEncoding!)"
        }
    }

    var method: String {
        return "GET"
    }

    var urlParams: [String: String]? {
        return nil
    }
}
