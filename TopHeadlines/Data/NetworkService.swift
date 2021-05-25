//
//  NetworkService.swift
//  TopHeadlines
//
//  Created by Vraj Patel on 25/05/21.
//

import Foundation
import SwiftUI

class NetworkService {
    
    static func loadData(completion: @escaping ([Article]?) -> ()) {
        
        let urlString = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=072f1453f70d45d9a88bf86d7a0b92d8"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data, error == nil {
                
                let response = try? JSONDecoder().decode(JSONModel.self, from: data)
                if let response = response {
                    DispatchQueue.main.async {
                        completion(response.articles)
                    }
                }
            } else {
                print("Error in: \(#function)")
                completion(nil)
            }
        }
        task.resume()
        
    }
    
}

final class ImageStore {
    static func downloadImageBy(url: String, completion: @escaping (UIImage)->Void) {
        
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
                }
            }
        }
        task.resume()
    }
}
