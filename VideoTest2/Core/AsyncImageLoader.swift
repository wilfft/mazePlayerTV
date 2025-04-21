//
//  File.swift
//  VideoTest2
//
//  Created by William Moraes on 19/04/25.
//

import SwiftUI
import Combine

class AsyncImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    
    func loadImage(from urlString: String?) {
        cancellable?.cancel()
        
        guard let urlString = urlString else {
            image = nil
            return
        }
        
        cancellable = ImageCacheService.shared.loadImage(from: urlString)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                self?.image = image
            }
    }
}
