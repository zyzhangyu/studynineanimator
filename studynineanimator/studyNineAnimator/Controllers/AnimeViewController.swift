//
//  AnimeViewController.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/21.
//

import UIKit
import WebKit
import AVKit
import SafariServices

class AnimeViewController: UITableViewController {

    var avPlayerController: AVPlayerViewController!
    
    var link: AnimeLink? = nil
    
    var anime: Anime? = nil {
        didSet {
            DispatchQueue.main.async {
                self.informationCell?.animeDescription = self.anime?.description
                
                if let anime = self.anime {
                    self.server = anime.servers.first!.key
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    var server: Anime.ServerIdentifier? = nil
    
    var informationCell: AnimeDescriptionTableViewCell? = nil
    
    var selectedEpisodeCell: EpisodeTableViewCell? = nil
    
    var episodeRequestTask: NineAnimatorAsyncTask? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        guard let link = self.link else {
            print("因为没有传过来link而终止了!")
            return
        }
        
        title = link.title
        
        NineAnimator.default.anime(with: link) { (anime, error) in
            
            guard let anime = anime else {
                print("AnimeViewController 错误 --- \(error!)")
                return
            }
            print("刷新", anime)
            self.anime = anime
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return anime == nil ? 0 : 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 0){
            return 1
        }
        if (section == 1){
            if let count: Int  = anime?.episodes[self.server!]?.count {
                return count
            }else {
                return 0
            }
        }
        return 0
   
     }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.section == 0){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "anime.description") as? AnimeDescriptionTableViewCell else {
                fatalError("cell with wrong type is dequeued")
            }
            
            cell.link = link
            cell.animeDescription = anime?.description
            cell.animeViewController = self
            informationCell = cell
            return cell
        }
        if (indexPath.section == 1){
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "anime.episode") as? EpisodeTableViewCell else {
                fatalError("unable to dequeue reuseable cell")
            }
            let episodes = anime!.episodes[server!]!
            let item = episodes[indexPath.row]
            cell.episodeLink = item
            return cell
        }
     
        fatalError()
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.section == 1){
            guard let cell = tableView.cellForRow(at: indexPath) as? EpisodeTableViewCell else {
                print("Warning: Cell selection event received when the cell selected is not an EpisodeTableViewCell")
                return
            }
            
            if cell != selectedEpisodeCell {
                selectedEpisodeCell?.progressIndicator.hideActivityIndicator()
                episodeRequestTask?.cancel()
                cell.progressIndicator.showActivityIndicator()
                selectedEpisodeCell = cell
                
                guard let items: Anime.EpisodeLinksCollection = anime?.episodes[self.server!]
                else {
                    print("响应点击事件失败 --table cell tempLink")
                    return
                }
                let tempLink:Anime.EpisodeLink = items[indexPath.row]
                NineAnimator.default.episode(with: tempLink, anime: anime!) { (episode, error) in
                    
                    print("episode--",episode)
                    
                    DispatchQueue.main.async {
                        let playbackController = SFSafariViewController(url: episode!.target)
                        self.present(playbackController, animated: true)
                    }
                    return
                }
            }
        }
        
    }
}
