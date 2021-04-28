//
//  SearchViewController.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/25.
//

import UIKit

class SearchViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {
    
    var searchController: UISearchController!
    
    var popuplarAnimeLinks: [AnimeLink]? {
        
        didSet {
            DispatchQueue.main.async { [weak self] in
                
                self?.tableView.reloadSections([0], with: .fade)
            }
        }
    }
    
    /// title link image  和首页的一样
    var filteredAnimeLinks = [AnimeLink]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // 确保我们在点击搜索结果时得到导航栏。
        definesPresentationContext = true
        
        searchController = UISearchController.init(searchResultsController: SearchResultViewController.init())
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchDisplayController
        searchController.searchBar.autocapitalizationType = .words
        searchController.searchBar.delegate = self

        if #available(iOS 11.0 , *){
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        }
        
        tableView.tableFooterView = UIView()
        
        NineAnimator.default.loadHomePage {[weak self] page, error in
            guard let page = page else {
                print("SearchViewController错误: \(error)")
                return
            }
            self?.popuplarAnimeLinks = page.featured + page.latest
        }
    }
}


// MARK: Prepare for segues
extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
//        if let resultsViewController = segue.description as? SearchResu
        
        if let animeViewController = segue.destination as? AnimeViewController,
        let cell = sender as? SimpleAnimeTableViewCell {
            animeViewController.link = cell.animeLink
        }
    }
}

// MARK: Search events handler
extension SearchViewController {
    func updateSearchResults(for searchController: UISearchController) {
        
        searchController.showsSearchResultsController = true

//        guard let all = popuplarAnimeLinks else {
//            return
//        }
//
//        if let text = searchController.searchBar.text {
//            filteredAnimeLinks = all.filter {
//                $0.title.contains(text) || $0.link.contains(text)
//            }
//        } else {
//            filteredAnimeLinks = all
//        }
//
//        tableView.reloadSections([0], with: .fade)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: {[weak self] in
            self?.performSegue(withIdentifier: "search.result.show", sender: searchBar.text)
        })
    }
}

// MARK: - Table viwe data source
extension SearchViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAnimeLinks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "anime.container.simple", for: indexPath) as? SimpleAnimeTableViewCell else {
            fatalError("Cell dequeued is not a SimpleAnimeTableViewCell")
        }
        cell.animeLink = filteredAnimeLinks[indexPath.row]
        return cell
    }
    
}
