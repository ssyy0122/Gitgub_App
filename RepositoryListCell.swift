//
//  RepositoryListCell.swift
//  GitHubRepository
//
//  Created by 진시윤 on 2021/12/14.
//

import UIKit
import SnapKit

class RepositoryListCell: UITableViewCell {
    
    // MARK: - Properties
    
    var repository: Repository?
    private let namelabel = UILabel()
    private let decriptionlabel = UILabel()
    private let starimageview = UIImageView()
    private let starlabel = UILabel()
    private let languagelabel = UILabel()
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addView()
        setLayout()
        configureVC()
    }
    
    // MARK: - UI
    
    private func addView(){
        [
            namelabel,decriptionlabel,
            starimageview,starlabel, languagelabel
        ].forEach{
            contentView.addSubview($0)
        }
    }
    private func setLayout(){
        namelabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(18)
        }
        decriptionlabel.snp.makeConstraints {
            $0.top.equalTo(namelabel.snp.bottom).offset(3)
            $0.leading.trailing.equalTo(namelabel)
        }
        starimageview.snp.makeConstraints {
            $0.top.equalTo(decriptionlabel.snp.bottom).offset(8)
            $0.leading.equalTo(decriptionlabel)
            $0.width.height.equalTo(20)
            $0.bottom.equalToSuperview().inset(18)
        }
        starlabel.snp.makeConstraints {
            $0.centerY.equalTo(starimageview)
            $0.leading.equalTo(starimageview.snp.trailing).offset(5)
        }
        languagelabel.snp.makeConstraints {
            $0.centerY.equalTo(starlabel)
            $0.leading.equalTo(starlabel.snp.trailing).offset(12)
        }
    }
    private func configureVC(){
        guard let repository = repository else {
            return
        }

        namelabel.text = repository.name
        namelabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        decriptionlabel.text = repository.description
        decriptionlabel.font = .systemFont(ofSize: 15)
        decriptionlabel.numberOfLines = 2
        
        starimageview.image =  UIImage(systemName : "star")
        
        starlabel.text = "\(repository.stargezersCount)"
        starlabel.font = .systemFont(ofSize: 16)
        starlabel.textColor = .gray
        
        languagelabel.text = repository.language
        languagelabel.font = .systemFont(ofSize: 16)
        languagelabel.textColor = .gray
    }
    
}
