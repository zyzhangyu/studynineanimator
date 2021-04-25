//
//  Anime.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/21.
//

import Foundation
import Alamofire

struct Anime {
    
    ///服务标识
    typealias ServerIdentifier = String
    ///单集标识
    typealias EpisodeIdentifier = String
    ///动漫标识
    typealias AnimeIdentifier = String
    ///单集信息
    typealias EpisodeLink = (identifier: EpisodeIdentifier, name: String, server: ServerIdentifier, parent: AnimeLink)
    ///剧集合集
    typealias EpisodeLinksCollection = [EpisodeLink]
    
    ///从首页过来的链接
    let link:AnimeLink
    let session: Alamofire.Session
    ///服务器合集
    let servers: [ServerIdentifier: String]
    ///剧集合集
    let episodes: [ServerIdentifier: EpisodeLinksCollection]
    ///动漫描述
    let description: String
    ///当前服务器
    var currentServer: ServerIdentifier
    
    init(_ link: AnimeLink,
         description: String,
         with session: Alamofire.Session,
         on servers: [ServerIdentifier: String],
         episodes: [ServerIdentifier: EpisodeLinksCollection]) {
        
        self.link = link
        self.session = session
        self.servers = servers
        self.episodes = episodes
        self.currentServer = servers.first!.key
        self.description = description
    }
}

extension NineAnimator {
    
    ///服务标识
    typealias ServerIdentifier = String
    ///单集标识
    typealias EpisodeIdentifier = String
    ///动漫标识
    typealias AnimeIdentifier = String
    ///单集信息
    typealias EpisodeLink = (identifier: EpisodeIdentifier, name: String, server: ServerIdentifier, parent: AnimeLink)
    ///剧集合集
    typealias EpisodeLinksCollection = [EpisodeLink]
    
    func anime(with link: AnimeLink,
               completionHandler: @escaping NineAnimatorCallback<Anime>) {
    
        request(.animeDetails(animeID: link.link)) {
            (content, error) in
            if let error = error {
                self.removeCache(at: .home)
                completionHandler(nil, error)
                return
            }
            
            
            print("查看详情:")
            print(content)
            
            
            do{
                if let dataFromString = content!.data(using: .utf8, allowLossyConversion: false) {
                    
                    let json = try JSON.init(data: dataFromString)
                    
                    let entry = json["results"][0]
                    
                    let des = entry["summary"].stringValue
                    
                    let servers = ["arrayanimeapi": "arrayanimeapi"]
                    
                    let totalEpisode: Int = entry["totalepisode"].intValue ?? 0
                    
                    var episodeCollection : EpisodeLinksCollection  = []
                    
                    for inedx in 1...totalEpisode {
                        episodeCollection.append( EpisodeLink(
                            identifier: "\(link.link)-\(inedx)",
                            name: "\(inedx)",
                            server: "arrayanimeapi",
                            parent: link
                        ))
                    }
                    let anime = Anime.init(link, description: des, with: self.session, on: servers, episodes: ["arrayanimeapi":episodeCollection])

                    completionHandler(anime, nil)
                    return
                }
                completionHandler(nil, nil)

            } catch let e {
                completionHandler(nil, e)
            }
        }
        
    }
}
