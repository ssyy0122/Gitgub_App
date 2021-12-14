//
//  RepositoryListviewController.swift
//  GitHubRepository
//
//  Created by 진시윤 on 2021/12/14.
//

import UIKit
import RxCocoa
import RxSwift

class RepositoryListviewController: UITableViewController {
    private let organization = "Apple"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = organization + "Repository"
        
        self.refreshControl = UIRefreshControl()
        let refreshControl = self.refreshControl!
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.register(RepositoryListCell.self, forCellReuseIdentifier: "RepositoryListCell")
        tableView.rowHeight = 140
    }
    @objc func refresh() {
         
    }
}

