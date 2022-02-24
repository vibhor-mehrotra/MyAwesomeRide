//
//  UIImageView+ImageServices.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 20/02/22.
//

import UIKit

/// Image download and caching services
extension UIImageView{
    func loadImage(url: String?, placeholderImage: UIImage?) {
        Task {
            setImage(placeholderImage)
            guard let urlStr = url, let url = URL(string: urlStr) else {
                return
            }
            let urlRequest = URLRequest(url: url)
            if let cachedImage = fetchImageFromCacheIfAvailable(urlRequest: urlRequest){
                setImage(cachedImage)
                return
            }
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else{
                    return
                }
                let cachedData = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedData, for: urlRequest)
                setImage(image)
            } catch{
                /// No need to handle here as we have already set placeholder Image
            }
        }
    }
    
    @MainActor private func setImage(_ image: UIImage?){
        self.image = image
    }
    
    private func fetchImageFromCacheIfAvailable(urlRequest: URLRequest) -> UIImage?{
        guard let imageData = URLCache.shared.cachedResponse(for: urlRequest)?.data, let image = UIImage(data: imageData) else{
            return nil
        }
        return image
    }
}
