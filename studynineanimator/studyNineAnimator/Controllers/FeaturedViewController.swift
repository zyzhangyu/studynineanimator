//
//  FeaturedViewController.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/21.
//

import UIKit
import Kingfisher

class FeaturedViewController: UITableViewController {
    
    var featuredAnimePage: FeaturedAnimePage? = nil {
        didSet {
            UIView.transition(with: tableView,
                              duration: 0.35,
                              options: .transitionCrossDissolve,
                              animations: {self.tableView.reloadData()})
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NineAnimator.default.loadHomePage { (featuredAnimePage, error) in
            DispatchQueue.main.async {
                self.featuredAnimePage = featuredAnimePage
            }
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let featuredItem:AnimeLink? = featuredAnimePage?.featured[indexPath.row]

        
        let animeCell = tableView.dequeueReusableCell(withIdentifier: "anime.featured", for: indexPath) as! FeaturedAnimeTableViewCell
        
        if let title = featuredItem?.title{
            animeCell.animeNameLabel?.text = title
        }
        if let img = featuredItem?.image {
            animeCell.animeImageView?.kf.setImage(with: img)
        }
        if let subTitle = featuredItem?.link {
            animeCell.descriptionLabel?.text = subTitle
        }
        
        return animeCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let item = featuredAnimePage?.featured[indexPath.row]
        
//        NineAnimator.default.anime(with: item!) { (anime, error) in
//
//            print("查看结果或者错误")
//            print(anime)
//            print("~~~~")
//            print(error)
//        }
        
//        let animeVC = AnimeViewController.init()
//
//        self.navigationController?.pushViewController(animeVC, animated: true)
        
        
        
//        let storyBoard:UIStoryboard! = UIStoryboard(name: "AnimePlayer", bundle: nil)
//
////        let animeVC:AnimeViewController! = storyboard!.instantiateViewController(withIdentifier: "AnimeViewController") as! AnimeViewController
//
//
//        let nav = self.navigationController
//
//
//        let vc:AnimeViewController = storyboard!.instantiateInitialViewController() as! AnimeViewController
//
//        nav?.pushViewController(vc, animated: true)
//    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let playerViewController = segue.destination as? AnimeViewController {
            guard let selected = tableView.indexPathForSelectedRow else {
                return
            }
         
            
            guard let animeLink = featuredAnimePage?.featured[selected.item] else {
                print("因为没有获取到link,所以无法传递")
                return
            }
            playerViewController.link = animeLink
        }
    }
}
