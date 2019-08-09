import UIKit

import PlaygroundSupport
import Foundation

PlaygroundPage.current.needsIndefiniteExecution = true

struct StoreItem: Codable {
    var trackName: String
    var collectionName: String
    var isStreamable: Bool
    var kind: String
    
    
    enum CodingKeys: String, CodingKey {
        case trackName
        case collectionName
        case isStreamable
        case kind
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.trackName = try valueContainer.decode(String.self, forKey: CodingKeys.trackName)
         self.collectionName = try valueContainer.decode(String.self, forKey: CodingKeys.collectionName)
         self.isStreamable = try valueContainer.decode(Bool.self, forKey: CodingKeys.isStreamable)
         self.kind = try valueContainer.decode(String.self, forKey: CodingKeys.kind)
    }
    
}

struct StoreItems: Codable {
    let results: [StoreItem]
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

let query = [
    "term": "james blake",
    "media": "music",
    "limit": "20"
]


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



fetchItems(matching: query, completion: {
    (fetchedInfo) in
    print(fetchedInfo)
})


