//
//  ShowCardView.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

// MARK: - Show Card View
import SwiftUI

struct ShowCardView: View {
    let show: Show
    @StateObject private var imageLoader = AsyncImageLoader()
    
    var body: some View {
        VStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        ProgressView()
                    )
            }
            
            Text(show.name)
                .font(.headline)
                .lineLimit(2)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 3)
        .onAppear {
            imageLoader.loadImage(from: show.image?.medium)
        }
    }
}
