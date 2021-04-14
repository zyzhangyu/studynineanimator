//
//  FeaturedAnimePage.swift
//  studynineanimator
//
//  Created by developer on 2021/4/9.
//

import Foundation


struct FeaturedAnimePage {
    
    static let latestUpdateAnimesRegex = try! NSRegularExpression(pattern: "(https:\\/\\/www1.9anime.to\\/watch[^\"]+)\"[^>]+>\\s+\\<img src=\"(https[^\"]+)\" alt=\"([^\"]+)[^>]+>", options: .caseInsensitive)
    
    let featured: [AnimeLink]
    
    let latest: [AnimeLink]
    
    init?(_ pageSource: String) throws{
        print("FeaturedAnimePage init : ", pageSource)
        
        
        
        if let dataFromString = pageSource.data(using: .utf8, allowLossyConversion: false)  {
            
            let json = try! JSON(data: dataFromString)
            
            
            let arrayResults = json["results"].arrayValue.map { (item) -> AnimeLink in
                
                print("打印每一个item", item)
                
//                {
//                  "title" : "Nomad: Megalo Box 2",
//                  "id" : "nomad-megalo-box-2",
//                  "image" : "https:\/\/gogocdn.net\/cover\/nomad-megalo-box-2.png"
//                }
                
                let str:String = item["image"].stringValue
                let imageLink = URL.init(string: str);
                let title = item["title"].stringValue
                let idValue = item["id"].stringValue
                return AnimeLink.init(title: title, link: idValue, image: imageLink!)
            }
            
            self.featured = arrayResults
            self.latest = [];
        }else {
            self.featured = []
            self.latest = [];
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
                print("这里也回来了,哪里报错了呢" )

                let page = try FeaturedAnimePage(content!)
                print(page)
                completionHandler(page, nil)
            } catch let e {
                self.removeCache(at: .home)
                
                print("首页请求错误-2",e)

                completionHandler(nil, e)
            }
        }
    }
}
