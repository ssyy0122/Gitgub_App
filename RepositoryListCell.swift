//
//  RepositoryListCell.swift
//  GitHubRepository
//
//  Created by 진시윤 on 2021/12/14.
//

import UIKit
import SnapKit

class RepositoryListCell: UITableViewCell {
    var repository: String?
    
    let namelabel = UILabel()
    let decriptionlabel = UILabel()
    let starimageview = UIImageView()
    let starlabel = UILabel()
    let languagelabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [
            namelabel,decriptionlabel,
            starimageview,starlabel
        ].forEach{
            contentView.addSubview($0)
        }
    }
    
}
