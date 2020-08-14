//
//  FollowerListVC.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/5/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: GFDataLoadingScreen {
    
    enum Section { //lw 3ndk kaza section zawez el case
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var pageCounter = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView: UICollectionView! //el collection view ely hy4eel el cells
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>! // da el data source ely hn3mlo update data kol ma el  data tet8er

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: pageCounter)
        configureDataSource()
    }
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)) //init collectionView
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID) // regester
    }
    
    
    func getFollowers(username:String ,page: Int) {
        guard hasMoreFollowers else { return }
        showIndecatorView()
        NetworkManager.shared.getFollowers(for: username, page: pageCounter) { [weak self] result in // el weak self de be e5tsar lma ykon 3ndk var le object w el object b2a b nil el object hyt4al bs el counter bta3 el var msh hy2el l2en el var bta3 el object kan strong  w msh hyt4al mn el memory fa hy3ml memory leak
            guard let self = self else { return }
            self.dismissIndecatorView()
            
            switch result {
            case .success(let followers):
                
                if followers.count < 100 { self.hasMoreFollowers = false} //34an myfdl4 y3m pagenate

                self.followers.append(contentsOf: followers) //adding to arrays
                if self.followers.isEmpty {// no Users case
                    let message = "No One is following this User"
                    DispatchQueue.main.async { self.showEmptyStateView(message: message, view: self.view) }
                    return
                }
                
                self.updateData(followers: followers)          // el func de htst5dm el local var w trf3o lel data source
                
                //Faild
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    //Cell for Item at bs mfha4 data w lazm t7otelha data mn el updateData()
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(followers: [Follower]) {//bn7ot el data fe el data source
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])//sections
        snapshot.appendItems(followers)//follower
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) } // Apply
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search For a username"
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
    }
    
    @objc func addButtonTapped(){
       showIndecatorView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            self.dismissIndecatorView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.login)
                Persitence.updateWith(favorite: favorite, actionType: .add) { [weak self] (error) in
                    guard let self = self else {return}
                    guard let error = error else {
                        //Success
                        self.presentGFAlertOnMainThread(title: "Success!", message: "Sucess great favorite", buttonTitle: "Horraay!")
                        return
                    }
                    //Faild
                    self.presentGFAlertOnMainThread(title: "Ouh", message: error.rawValue, buttonTitle: "OK")
                }
                
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Ouh", message: error.rawValue, buttonTitle: "OK")
            }
        }
        
        
    }
}

extension FollowerListVC: UICollectionViewDelegate
{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let heigh = scrollView.frame.size.height
        
        if offsetY > contentHeight - heigh{
            guard hasMoreFollowers else { return }
            pageCounter += 1
            getFollowers(username: username, page: pageCounter)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //                                                                      If               True                        False
        let activeArray         = isSearching ?  filteredFollowers : followers
        let follower            = activeArray[indexPath.item]
        
        let userInfoVC          = UserInfoVC()
        userInfoVC.delegate     = self
        userInfoVC.username     = follower.login
        
        let userInfoNavController = UINavigationController(rootViewController: userInfoVC)
        present(userInfoNavController, animated: true)
    }
}

extension FollowerListVC: UISearchResultsUpdating , UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text , !filter.isEmpty else {
            updateData(followers: followers)
            filteredFollowers.removeAll()
            isSearching = false
            return }
        
        self.filteredFollowers = self.followers.filter{ $0.login.lowercased().contains(filter.lowercased())}
        isSearching = true
        updateData(followers: filteredFollowers)
    }

}

extension FollowerListVC: FollowerListVCDelegate{

    func didRequestFollowers(for username: String) {
        self.username    = username
        self.title       = username
        self.pageCounter = 0
        self.followers.removeAll()
        self.filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true )
        self.getFollowers(username: username, page: pageCounter)
    }
    
    
}
