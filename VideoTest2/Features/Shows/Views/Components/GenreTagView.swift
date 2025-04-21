//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 18/04/25.
//

import SwiftUI

struct GenreTagView: View {
    let genre: String
    
    var body: some View {
        Text(genre)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.blue.opacity(0.2))
            .foregroundColor(.blue)
            .cornerRadius(8)
    }
}
