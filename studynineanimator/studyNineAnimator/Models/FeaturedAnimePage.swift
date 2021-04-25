//
//  FeaturedAnimePage.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/21.
//

import Foundation

struct FeaturedAnimePage {
    
    let featured: [AnimeLink]
    let latest: [AnimeLink]

    init(_ pageSource: String) throws {
        
        if let dataFromString = pageSource.data(using: .utf8, allowLossyConversion: false)  {
              
              let json = try! JSON(data: dataFromString)
              
              let arrayResults = json["results"].arrayValue.map { (item) -> AnimeLink in
                  
//                print("打印每一个item", item)
                  
                  let str:String = item["image"].stringValue
                  let imageLink = URL.init(string: str);
                  let title = item["title"].stringValue
                  let idValue = item["id"].stringValue
                  return AnimeLink.init(title: title, link: idValue, image: imageLink!)
              }
              
              self.featured = arrayResults
              self.latest = [];
        }else{
            self.featured = []
            self.latest = []
        }
  
    }
}


extension NineAnimator {
    func loadHomePage(completionHandler: @escaping NineAnimatorCallback<FeaturedAnimePage>){
        request(.featured) {
            (content, error) in
            if let error = error {
                self.removeCache(at: .home)
                completionHandler(nil, error)
                return
            }
            
            do{
                let page = try FeaturedAnimePage(content!)
                completionHandler(page, nil)
            } catch let e {
                self.removeCache(at: .home)
                completionHandler(nil, e)
            }
        }
    }
}
