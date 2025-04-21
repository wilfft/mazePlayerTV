//
//  PersonShowRowView.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//

import SwiftUI

struct PersonShowRowView: View {
    let show: PersonShow
    
    var body: some View {
        HStack {
            AsyncImage(url: show.image?.medium)
                .frame(width: 60, height: 80)
                .cornerRadius(6)
            
            Text(show.name)
                .font(.headline)
                .padding(.leading, 8)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}
