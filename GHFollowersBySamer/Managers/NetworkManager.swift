//
//  NetworkManager.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/7/20.
//  Copyright © 2020 samer. All rights reserved.
//


import UIKit

class NetworkManager {
    static let shared   = NetworkManager() //singleton
    private let baseURL         = "https://api.github.com/users/" //url base yb2a mwgod fe kol el urls
    let cache = NSCache<NSString, UIImage>() //el cache msh hnst5dmo hna
    
    private init() {}
    
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) { //enum result type
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)" //bnst5dm el base
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername)) //enum result type case failure
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
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
        }.resume()
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) { //enum result type
        let endpoint = baseURL + "\(username)" //bnst5dm el base
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername)) //enum result type case failure
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
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
                let user = try decoder.decode(User.self, from: data) //enum result type case success
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))//enum result type case failure
            }
        }.resume()
    }
    
    func downloadImage(from Url : String, completed : @escaping (UIImage?) -> Void ){
        
        let cacheKey = NSString(string: Url)
        
        if let image = cache.object(forKey: cacheKey){ //hna5od object mn el cache  lw feha image yb2a
            completed(image)                         //hn5ly el image hya el image ely fe object el cache
            return                                     //hnrg3 msh hnkml
        }
        
        guard let url = URL(string: Url) else {
        completed(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) {[weak self] (data, res, err) in
            if err != nil { return }
            guard let data = data , let self = self , let image = UIImage(data: data)  else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey) //hna adam wslna hna yb2a mfe4 cach fa hnset b2a el cache
            
            DispatchQueue.main.async { completed(image) }
        }.resume()
    }
}


