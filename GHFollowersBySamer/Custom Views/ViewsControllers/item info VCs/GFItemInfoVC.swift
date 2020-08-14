//
//  GFItemInfoVC.swift
//  GHFollowersBySamer
//
//  Created by samer on 8/9/20.
//  Copyright © 2020 samer. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoViewTwo = GFItemInfoView()
    let itemInfoViewOne = GFItemInfoView()
    let actionButton = GFButton(type: .system)
    
    var user: User!
    weak var delegate: UserInfoVCDelegate!
    
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layoutUI()
        configureStack()
        configureActionButton()
    }
    
    
    private func configureStack(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func configure(){
        
        view.layer.cornerRadius = 18
        view.backgroundColor = . secondarySystemBackground
        
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .init(width: 0, height: 6)
    }
    
    func configureActionButton(){
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    @objc func actionButtonTapped() {}
    
    
    
    private func layoutUI()
    {
        view.addSubViews(stackView,actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
