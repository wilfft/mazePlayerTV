//
//  EpisodeDetailView.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

import SwiftUI

struct EpisodeDetailView: View {
    @ObservedObject var viewModel: EpisodeDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = viewModel.episode.image?.original {
                    AsyncImage(url: imageUrl)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("\(viewModel.showName)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.episode.name)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Season \(viewModel.episode.season), Episode \(viewModel.episode.number)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if !viewModel.episode.cleanSummary.isEmpty {
                    Divider()
                    
                    Text("Summary")
                        .font(.headline)
                    
                    Text(viewModel.episode.cleanSummary)
                        .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Episode Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
