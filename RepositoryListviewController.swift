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
    private let organization = "ReactiveX"
    private let repositories = BehaviorSubject<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RepositoryListCell.self, forCellReuseIdentifier: "RepositoryListCell")
        tableView.rowHeight = 140
        
        title = organization + "Repository"
        
        self.refreshControl = UIRefreshControl()
        let refreshControl = self.refreshControl!
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        
        
        
        
    }
    @objc func refresh() {
        DispatchQueue.global(qos: .background).async {[weak self] in
            guard let self = self else {return}
            self.fetchRepositories(of: self.organization)
            
        }
    }
    func fetchRepositories(of organization: String) {
        Observable.from([organization])
            .map { organization -> URL in
                return URL(string: "https://api.github.com/orgs/\(organization)/repos")!
            }
            .map{url -> URLRequest in
                var requeest = URLRequest(url: url)
                requeest.httpMethod = "Get"
                return requeest
            }
            .flatMap { request -> Observable<(response: HTTPURLResponse,data:Data)> in
                return URLSession.shared.rx.response(request: request)
                
            }
            .filter {responds, _ in
                return 200..<300 ~= responds.statusCode
                
            }
            .map { _, data ->[[String: Any]] in
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                      let result = json as? [[String:Any]] else  {
                          return []
                      }
                return result
            }
            .filter { result in
                return result.count > 0
            }
            .map { objects in
                return objects.compactMap {dic -> Repository? in
                    guard let id = dic["id"] as? Int,
                          let name = dic["name"] as? String,
                          let description = dic["description"] as? String,
                          let stargazersCount = dic["stargazers_count"] as? Int,
                            let language = dic["language"] as? String else {
                                return nil
                            }
                    return Repository(id: id, name: name, description: description, stargezersCount: stargazersCount, language: language)
                }
            }
            .subscribe(onNext: {[weak self] newRepositories in
                self?.repositories.onNext(newRepositories)
              print(newRepositories)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.refreshControl?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
}
extension RepositoryListviewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
         return try repositories.value().count
        }catch {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryListCell", for: indexPath)
                as? RepositoryListCell else {return UITableViewCell()}
        var currentRepo: Repository? {
            do {
                return try repositories.value()[indexPath.row]
            }catch {
                return nil
            }
        }
        cell.repository = currentRepo
        
        return cell

    }
}
