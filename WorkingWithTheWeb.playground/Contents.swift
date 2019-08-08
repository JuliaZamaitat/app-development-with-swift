import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self,
                                       resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map
            { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
//print(url.scheme)
//print(url.host)
//print(url.query)


let query: [String: String] = [
    "api_key": "DEMO_KEY",
    "date": "1997-07-22"
]

let url = baseURL.withQueries(query)!

let task = URLSession.shared.dataTask(with: url, completionHandler: { //defines what happens after a request was sent
    (data, response, error) in
    if let data = data {
        let string = String(data: data, encoding: .utf8)
        print(string)
    }
})

task.resume() //Sends the request


