//
//  FeaturedAnimePage.swift
//  studynineanimator
//
//  Created by developer on 2021/4/9.
//

import Foundation


struct FeaturedAnimePage {
    static let featuredAnimesRegex = try! NSRegularExpression(pattern: "<div class=\"item swiper-slide\" style=\"background-image: url\\(([^)]+)\\)[^h]+href=\"([^\"]+)\">([^<]+)", options: .caseInsensitive)
    
    static let latestUpdateAnimesRegex = try! NSRegularExpression(pattern: "(https:\\/\\/www1.9anime.to\\/watch[^\"]+)\"[^>]+>\\s+\\<img src=\"(https[^\"]+)\" alt=\"([^\"]+)[^>]+>", options: .caseInsensitive)
    
    let featured: [AnimeLink]
    
    let latest: [AnimeLink]
    
    init?(_ pageSource: String) throws{
        print("FeaturedAnimePage init : ", pageSource)
        
        let featuredAnimesMatches = FeaturedAnimePage.featuredAnimesRegex.matches(in: pageSource, options: [], range: pageSource.matchingRange)
        self.featured = try featuredAnimesMatches.map {
            guard let imageLink = URL(string: pageSource[$0.range(at: 1)]) else { throw NineAnimatorError.responseError("parser error") }
            guard let animeLink = URL(string: pageSource[$0.range(at: 2)]) else { throw NineAnimatorError.responseError("parser error") }
            let title = pageSource[$0.range(at: 3)]
            return AnimeLink(title: title, link: animeLink, image: imageLink)
        }
        
        let latestAnimesMatches = FeaturedAnimePage.latestUpdateAnimesRegex.matches(in: pageSource, options: [], range: pageSource.matchingRange)
        self.latest = try latestAnimesMatches.map{
            guard let imageLink = URL(string: pageSource[$0.range(at: 2)]) else { throw NineAnimatorError.responseError("parser error") }
            guard let animeLink = URL(string: pageSource[$0.range(at: 1)]) else { throw NineAnimatorError.responseError("parser error") }
            let title = pageSource[$0.range(at: 3)]
            return AnimeLink(title: title, link: animeLink, image: imageLink)
        }
    }
}

 


extension NineAnimator {
    func loadHomePage(completionHandler: @escaping NineAnimatorCallback<FeaturedAnimePage>){
        
        
        request(.home) {
            (content, error) in
            if let error = error {
                self.removeCache(at: .home)
                print("首页请求错误",error)
                completionHandler(nil, error)
                return
            }
            
            do{
                let page = try FeaturedAnimePage(content!)
                completionHandler(page, nil)
            } catch let e {
                self.removeCache(at: .home)
                
                print("首页请求错误-2",e)

                completionHandler(nil, e)
            }
        }
    }
}
