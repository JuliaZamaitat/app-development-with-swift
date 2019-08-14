//
//  MenuController.swift
//  Restaurant
//
//  Created by Julia Zamaitat on 13.08.19.
//  Copyright © 2019 Julia Zamaitat. All rights reserved.
//

import Foundation
import UIKit

class MenuController {
    static let shared = MenuController()
    
    let baseURL = URL(string: "http://localhost:8090/")!
    var order = Order() {
        didSet{
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }
    
    static let orderUpdatedNotification = Notification.Name("MenuController.orderUpdated")
    
    
    func fetchCategories(completion: @escaping ([String]?) -> Void){
        let categoryURL = baseURL.appendingPathComponent("categories")
        let task = URLSession.shared.dataTask(with: categoryURL) {
            (data, response, error) in
            if let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any], //returns a foundation object from given JSON data
                let categories = jsonDictionary["categories"] as? [String] {
                completion(categories)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func fetchMenuItems(forCategory categoryName: String, completion: @escaping ([MenuItem]?) -> Void){
        let initialMenuURL = baseURL.appendingPathComponent("menu")
        var components = URLComponents(url: initialMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuURL = components.url!
        let task = URLSession.shared.dataTask(with: menuURL){
            (data, response, error) in
                let jsonDecoder = JSONDecoder()
                if let data = data,
                    let menuItems = try? jsonDecoder.decode(MenuItems.self, from: data){//passes the Data object into the method into the desired type MenuItems.self
                    completion(menuItems.items)
                } else {
                    completion(nil)
            }
        }
        task.resume()
    }
    
    func submitOrder(forMenuIDs menuIds: [Int], completion: @escaping (Int?) -> Void){ //2nd parameter in completion closure taked in the order prep time
        let orderURL = baseURL.appendingPathComponent("order")
        //change the request's default type from a GET to a POST
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        //tell the server what kind of data you'll be sending - JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //store the array of menu IDs in JSON under the key menuIDs because it is a POST
        let data: [String: [Int]] = ["menuIds": menuIds] //this type can be converted to or from JSON by an instance of JSONEncoder
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        //store the data within the body of the request
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let preparationTime = try? jsonDecoder.decode(PreparationTime.self, from: data){ //passes the Data object into the method into the desired type PreparationTime.self
                completion(preparationTime.prepTime)
            }else {
                completion(nil)
            }
        }
        task.resume()
        
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) ->
        Void) {
        let task = URLSession.shared.dataTask(with: url) { (data,
            response, error) in
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
