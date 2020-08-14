//
//  PersitenceManger.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/12/20.
//  Copyright © 2020 samer. All rights reserved.
//

import Foundation

enum PersitenceActionType {
    case delete
    case add
}

enum Persitence {
    static private let defaults = UserDefaults.standard
    
    enum Keys  {
        static let favorites = "favorites"
    }
    
    
    static func updateWith(favorite: Follower, actionType: PersitenceActionType, completed: @escaping (GFError?) -> Void){
        retriveFavorites { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else { //make sure that isnt exist
                        completed(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                    
                case .delete:
                    favorites.removeAll { $0.login == favorite.login }
                }
                completed(save(favorites: favorites))
                 
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func retriveFavorites(completed: @escaping (Result<[Follower],GFError>) -> Void){
        
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        }catch{
            completed(.failure(.unableToFollow))
        }
    }
    
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        }catch{
            return .unableToFollow
        }
    }
}
