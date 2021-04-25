//
//  Episode.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/25.
//

import Foundation
import Alamofire
import AVKit

struct Episode {
    
    let link:Anime.EpisodeLink
    
    let target: URL
    
    var name: String {return link.name}
    
    var parentLink : AnimeLink {return link.parent}
    
//    var nativePlaybackSupported: Bool {
//
//    }
 
    private var _parent: Anime?
    private var _session: Alamofire.Session
    
    init(_ link:Anime.EpisodeLink, on target: URL, with session: Alamofire.Session, parent:Anime? = nil){
        self.link = link
        self.target = target
        self._parent = parent
        self._session = session
    }
    
    ///retire vi. 退休；撤退；退却 | vt. 退休；离开...
//    func retrive(onCompletion handler: @escaping NineAnimatorCallback<AVPlayerItem>) -> NineAnimatorAsyncTask? {
//
//    }
    
//    func parent(onCompletion handler: @escaping NineAnimatorCallback<Anime>){
//        if let parent = _parent { handler(parent, nil) }
//        else { NineAnimator.default.anime(with: link.parent, onCompletion: handler) }
//    }
    
}

extension NineAnimator {
    func episode(with link: EpisodeLink, anime: Anime,  completionHandler: @escaping NineAnimatorCallback<Episode>) {
        
        print("网络请求传进来的link",link)
        let animeID = link.parent.link;
        let eposideIndex = link.name;
        request(.eposide(animeID: animeID, eposideIndex: eposideIndex)) { [self] (content, error) in
            
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            do {
                
                if let dataFromString = content!.data(using: .utf8, allowLossyConversion: false) {
                    
                    let json = try JSON.init(data: dataFromString)
                    
                    let entry = json["links"].arrayValue

                    var urlString: String?;
                    entry.map { (json)  in
                        if (json["name"].stringValue.contains("HDP")){
                            urlString = json["link"].stringValue
                        }
                    }
                    
                    let url = URL.init(string: urlString!)
                    let episode: Episode = Episode.init(link, on: url!, with: session, parent: anime )
                    
                    print("嘿嘿嘿")
                    completionHandler(episode, nil)
                    
                }else {
                    fatalError("拿eposide 拿不到")
                }
                
            } catch let e {
                completionHandler(nil, e)
            }
        }
        
    }
}


 
