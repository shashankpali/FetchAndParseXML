//
//  Networking.swift
//  FetchAndParseXML
//
//  Created by Shashank Pali on 02/02/22.
//

import Foundation
import CoreData

struct Networking {
    
    static func get(forURLString: String, policy: NSURLRequest.CachePolicy, callback: @escaping (Bool, Data?, String?) -> Void) {

        var request = URLRequest(url: URL(string: forURLString)!,timeoutInterval: 30)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = policy
        
        URLSession(configuration: config).dataTask(with: request) { data, response, error in
            guard let res = data else {
                callback(false, nil, error?.localizedDescription)
                return
            }
            callback(true, res, nil)
        }.resume()
        
    }
}
