//
//  AnimeLink.swift
//  studynineanimator
//
//  Created by developer on 2021/4/9.
//


import UIKit
import Alamofire

struct AnimeLink: Alamofire.URLConvertible {
    var title: String
    var link: String
    var image: URL
    
    init(title: String, link: String, image: URL) {
        self.title = title
        self.link = link
        self.image = image
    }
    
    func asURL() -> URL { return URL.init(string: NineAnimator.default.endpoint + "/details/\(link)")!}
    

}

extension AnimeLink: Equatable {
    static func == (lhs: AnimeLink, rhs: AnimeLink) -> Bool {
        return lhs.link == rhs.link
    }
}
