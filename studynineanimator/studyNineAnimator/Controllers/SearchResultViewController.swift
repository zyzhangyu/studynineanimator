//
//  SearchResultViewController.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/26.
//

import UIKit

class SearchResultViewController: UITableViewController {
    
    var searchText: String? = "sub"
//    {
//        didSet {
//            title = searchText
//        }
//    }
    
    private var searchPage: SearchPage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 160
        tableView.tableFooterView = UIView()
        tableView.register(SearchNoResultsTableViewCell.classForCoder(), forCellReuseIdentifier: "search.notfound")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchPage.delegate = nil
        searchPage = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchPage = NineAnimator.default.search(searchText!)
        searchPage.delegate = self
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height { searchPage.more() }
    }
}

extension SearchResultViewController: SearchPageDelegate{
    
    func pageIncoming(_: Int, in:SearchPage){
        DispatchQueue.main.async { [weak self] in      
            guard let self = self else {return}  
            self.tableView.reloadData()
        }
    }
    
    func noResult(in: SearchPage){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.tableView.rowHeight = 300
            self.tableView.reloadSections([0], with: .automatic)
        }
    }
}

extension SearchResultViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard searchPage != nil else { return 0 }
        var temp:Int = (searchPage.moreAvailable || searchPage.totalPages == 0 ? 1 : 0)
        return searchPage.availablePages + temp
                        
     }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == searchPage.availablePages || searchPage.availablePages == 0 {
            tableView.separatorStyle = .none
            return 1
        }
        tableView.separatorStyle = .singleLine
        return searchPage.animes(on: section).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //No results found
//        if !searchPage.moreAvailable && searchPage.availablePages == 0 {
        
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "search.notfound", for: indexPath) as? SearchNoResultsTableViewCell else {
                fatalError()
            }
        cell.textLabel?.text = "aaaa"
            return cell
//        }
        
//        if searchPage.availablePages == indexPath.section {
//            return tableView.dequeueReusableCell(withIdentifier: "search.loading", for: indexPath)
//        } else {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "search.result", for: indexPath) as? AnimeSearchResultTableViewCell else { fatalError("cell type dequeued is not AnimeSearchResultTableViewCell") }
//            cell.animeLink = searchPage.animes(on: indexPath.section)[indexPath.item]
//            return cell
//        }
    }
}

