import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true




struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self) //returns a KeyedCodingContainer that only contains the key/value pairs associated with the cases declared in CodingKeys
        //now use decode(_:from:) provided by KeyedCodingContainer to get each of the values corresponding to the keys you want and assign them to the correct properties
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
    }
}




extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,
                                       resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}



func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) { //@escaping tells the compiler that the code in the closure will be executed after the function has returned or ahas finished executing all the code
    let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
    //print(url.scheme)
    //print(url.host)
    //print(url.query)
    
    
    let query: [String: String] = [
        "api_key": "DEMO_KEY",
        "date": "1997-07-22"
    ]
    
    let url = baseURL.withQueries(query)!
    
    let task = URLSession.shared.dataTask(with: url) { (data,
        response, error) in
        let jsonDecoder = JSONDecoder()
        if let data = data,
            let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {
            completion(photoInfo)//executes the code passed into the completion parameter in the function call
        } else {
            print("Either no data was returned, or data was not properly decoded.")
            completion(nil)
        }
    }
    
    task.resume()
    
}

fetchPhotoInfo(completion: { (fetchedInfo) in
    print(fetchedInfo)
})
