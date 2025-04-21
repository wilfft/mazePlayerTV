//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//

// MARK: - Episode Detail View & ViewModel
import SwiftUI

class EpisodeDetailViewModel: ObservableObject {
    let episode: Episode
    let showName: String
    
    init(episode: Episode, showName: String) {
        self.episode = episode
        self.showName = showName
    }
}
