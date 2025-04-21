//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//

import SwiftUI

struct PersonCardView: View {
    let person: Person
    @StateObject private var imageLoader = AsyncImageLoader()
    
    var body: some View {
        VStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 180)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 180)
                    .overlay(
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                    )
            }
            
            Text(person.name)
                .font(.headline)
                .lineLimit(2)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 3)
        .onAppear {
            imageLoader.loadImage(from: person.image?.medium)
        }
    }
}
