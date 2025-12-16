//
//  NetworkService.swift
//  InstagramClone
//
//  Created by Deepak Kumar1 on 26/08/25.
//
import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func getData() {
        let urlString = "http://localhost:3001/getDummyUser?name=Rohith"
        
        let task = URLSession.shared.dataTask(with: URL(string: urlString)!) { data, response, error in
            guard let data else {
                print("error occured")
                return
            }
            let dataString = String(data: data, encoding: .utf8)
            print("\(dataString)")
        }
        
        task.resume()
        
    }
}
