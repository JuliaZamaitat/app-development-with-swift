//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Julia Zamaitat on 09.08.19.
//  Copyright © 2019 Caleb Hicks. All rights reserved.
//

import Foundation
import UIKit

struct StoreItemController {
    func fetchItems(matching query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {
        
        let baseURL = URL(string: "https://itunes.apple.com/search")!
        
        
        guard let url = baseURL.withQueries(query) else {
            completion(nil)
            print("Unable to build URL with supplied queries")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let result = try? jsonDecoder.decode(StoreItems.self, from: data) {
                completion(result.results)
            } else {
                print("Either no data was returned, or data was not properly decoded.")
                completion(nil)
                return
            }
        }
        
        task.resume()
    }
    
    func fetchItemArtwork(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, respone, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
}
