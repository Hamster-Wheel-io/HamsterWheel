//
//  APIController.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 4/12/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation

class APIController {
    func getImages(completion: @escaping ([String]?) -> ()) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "hamsterwheel.herokuapp.com"
        urlComponents.path = "/images"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let jsonData = data {
                var json: [[String: Any]] = [[:]]
                do {
                    json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [[String : Any]]
                } catch {
                    completion(nil)
                    return
                }
                var array: [String] = []
                for i in json {
                    if let img = i["img"] as? String{
                        array.append(img)
                    }
                }
                completion(array)
            } else {
                print("No Data received from server")
                completion(nil)
            }
        }
        task.resume()
    }
}
