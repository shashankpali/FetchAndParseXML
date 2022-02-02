//
//  Networking.swift
//  FetchAndParseXML
//
//  Created by Shashank Pali on 02/02/22.
//

import Foundation

struct Networking {
    
    static func get(forURLString: String, callback: @escaping (Bool, Data?, String?) -> Void) {

        var request = URLRequest(url: URL(string: forURLString)!,timeoutInterval: 30)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let res = data else {
                callback(false, nil, error?.localizedDescription)
                return
            }
            callback(true, res, nil)
        }.resume()
        
    }
}
