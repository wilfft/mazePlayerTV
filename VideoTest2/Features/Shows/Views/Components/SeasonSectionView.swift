//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

import SwiftUI

struct SeasonSectionView: View {
    let season: Season
    let onEpisodeTap: (Episode) -> Void
    @State private var isExpanded = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text("Season \(season.number)")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
            }
            .buttonStyle(.plain)
            
            if isExpanded {
                ForEach(season.episodes) { episode in
                    EpisodeRowView(episode: episode)
                        .onTapGesture {
                            onEpisodeTap(episode)
                        }
                }
            }
        }
    }
}
