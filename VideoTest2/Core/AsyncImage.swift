//
//  AsyncImage.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//

import SwiftUI

struct AsyncImage: View {
    let url: String?
    @StateObject private var imageLoader = AsyncImageLoader()
    
    var body: some View {
        content
            .onAppear {
                if let url = url {
                    imageLoader.loadImage(from: url)
                }
            }
    }
    
    @ViewBuilder
    private var content: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .overlay(ProgressView())
        }
    }
}
