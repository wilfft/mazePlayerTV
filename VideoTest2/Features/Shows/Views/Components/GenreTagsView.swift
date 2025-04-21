//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//

import SwiftUI

struct GenreTagsView: View {
    let genres: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(genres, id: \.self) { genre in
                    GenreTagView(genre: genre)
                }
            }
        }
    }
}
