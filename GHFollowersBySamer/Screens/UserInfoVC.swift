//
//  UserInfoVC.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/8/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for User: User)
}

class UserInfoVC: GFDataLoadingScreen {
    
    let headerView = UIView()
    let viewOne = UIView()
    let viewTwo = UIView()
    let dateLable = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username : String!
    weak var delegate: FollowerListVCDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureNavController()
        
        layoutUI()
        
        fetchUser()
        
    }
    private func configureNavController(){
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        headerView.clipsToBounds = true
    }
    
    private func layoutUI(){
        
        let padding: CGFloat = 20
        let itemHeight : CGFloat = 140
       // This how to hancle repeatable staff
        itemViews = [headerView,viewOne,viewTwo, dateLable]
        
        for item in itemViews {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 200),
            
            viewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            viewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            viewTwo.topAnchor.constraint(equalTo: viewOne.bottomAnchor, constant: padding),
            viewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLable.topAnchor.constraint(equalTo: viewTwo.bottomAnchor, constant: padding),
            dateLable.heightAnchor.constraint(equalToConstant: 18)
        ])
        
    }
    
    func add(childVC: UIViewController, containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    fileprivate func fetchUser() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "What da fck", message: error.localizedDescription, buttonTitle: "OK")
                
            case .success(let user):
                DispatchQueue.main.async { self.configureUiElements(user: user) }
            }
        }
    }
    
    func configureUiElements(user: User) {
        
        let repoItemVC          = GFRepoItemVC(user: user)
        repoItemVC.delegate     = self
        let followerItemVC      = GFFollowItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), containerView: self.headerView)
        self.add(childVC: repoItemVC, containerView: self.viewOne)
        self.add(childVC: followerItemVC, containerView: self.viewTwo)
        self.dateLable.text = "GitHub since \(user.createdAt.convertToDisplayFormate())"
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    

}
extension UserInfoVC: UserInfoVCDelegate{
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else { return }
        
        presentSafri(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "Ouh", message: "The user has NO Followers", buttonTitle: "OK")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismiss(animated: true)
    }
        
    
}
