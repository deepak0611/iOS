//
//  APIManager.swift
//  pp-first-demo-project
//
//  Created by Deepak Kumar1 on 24/01/23.
//

import Foundation

struct Constants {
    static let API_KEY = "31e0f5fd505c92b6d3252f6d4d8fbc66"
    static let baseUrl = "https://api.themoviedb.org"
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping (String) -> Void) {
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
