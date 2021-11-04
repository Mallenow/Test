//
//  DataController.swift
//  Test
//
//  Created by Daniel on 04.11.21.
//

import Foundation
import UIKit

class DataController : NSObject {
    
    var posts = Observable<CallResponse<[Post], Error>>()
    
    func getJSONData() {
        if let url =  URL(string: "https://jsonplaceholder.typicode.com/posts") {
            let session = URLSession(configuration: .default).dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    self?.posts.property = .failed(error)
                } else {
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let responseItems = try decoder.decode([Post].self, from: data)
                            self?.posts.property = .success(responseItems)
                        } catch(let decoderError) {
                            self?.posts.property = .failed(decoderError)
                        }
                    }
                }
            }
            session.resume()
        }
    }
}

enum CallResponse<T, Error> {
    case success(T)
    case failed(Error)
}



