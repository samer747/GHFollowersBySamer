//
//  FavoriteVC.swift
//  GHFollowersBySamer
//
//  Created by samer on 7/27/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class FavoriteVC: GFDataLoadingScreen {
    
    
    var favorites : [Follower] = []
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
    }
    
    
    private func configureViewController(){
        view.backgroundColor    = .systemBlue
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func getFavorites() {
        Persitence.retriveFavorites {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let favorites):
                if favorites.isEmpty{
                    self.showEmptyStateView(message: "A7a mfesh Followers y3m", view: self.view)
                }else{
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Ouh", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
    
    
    private func configureTableView(){
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.dataSource    = self
        tableView.delegate      = self
        tableView.removeExcessCells()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = FollowerListVC(username: favorite.login)
        
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let favorite = favorites[indexPath.row]

        
        Persitence.updateWith(favorite: favorite, actionType: .delete) {[weak self] (error) in
            guard let self = self else {return}
            
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self.presentGFAlertOnMainThread(title: "a7a", message: error.rawValue, buttonTitle: "8or yalla")
        }
    }
}
