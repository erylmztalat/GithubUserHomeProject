//
//  ImageLoader.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import UIKit

class ImageLoader {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = ImageCache.shared.getImage(for: url) {
            completion(cachedImage)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }

            guard
                let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let data = data, let image = UIImage(data: data)
            else {
                print("Error with the response, unexpected status code, or data was corrupted.")
                completion(nil)
                return
            }

            ImageCache.shared.setImage(image, for: url)

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}

