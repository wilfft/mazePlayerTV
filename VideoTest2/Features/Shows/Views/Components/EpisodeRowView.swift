//
//  Untitled.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

import SwiftUI

struct EpisodeRowView: View {
    let episode: Episode
    
    var body: some View {
        HStack {
            Text("\(episode.number).")
                .fontWeight(.semibold)
                .frame(width: 30, alignment: .leading)
            
            Text(episode.name)
                .lineLimit(1)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
        .contentShape(Rectangle())
    }
}
