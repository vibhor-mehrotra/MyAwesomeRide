//
//  UIImageView+ImageServices.swift
//  MyAwesomeRide
//
//  Created by Vibhor Mehrotra on 20/02/22.
//

import UIKit

extension UIImageView{
    func loadImage(url: String?){
        guard let urlStr = url, let url = URL(string: urlStr) else {
            return
        }
        DispatchQueue.global(qos: .utility).async {[weak self]() in
            guard let `self` = self else{
                return
            }
            let urlRequest = URLRequest(url: url)
            if let imageData = URLCache.shared.cachedResponse(for: urlRequest)?.data, let image = UIImage(data: imageData){
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            }
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                guard let data = data, let response = response, let image = UIImage(data: data) else{
                    return
                }
                let cachedData = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedData, for: urlRequest)
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }
}
