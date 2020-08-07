//
//  NetworkManager.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/7/20.
//  Copyright © 2020 samer. All rights reserved.
//


import Foundation

class NetworkManager {
    static let shared   = NetworkManager() //singleton
    let baseURL         = "https://api.github.com/users/" //url base yb2a mwgod fe kol el urls
    
    private init() {}
    
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) { //enum result type
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)" //bnst5dm el base
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername)) //enum result type case failure
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))//enum result type case failure
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))//enum result type case failure
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))//enum result type case failure
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data) //enum result type case success
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))//enum result type case failure
            }
        }
        
        task.resume() // Fire The Method
    }
}


