//
//  AnimeLink.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/21.
//

import UIKit
import Alamofire


struct AnimeLink: Alamofire.URLConvertible {
    
    ///Alamofire.URLConvertible
    func asURL() throws -> URL {
        return try! link.asURL()
    }
    
    var title: String
    var link: String
    var image: URL
    
    init(title: String, link: String, image: URL) {
        self.title = title
        self.link = link
        self.image = image
    }
    
}

extension AnimeLink: Equatable {
    static func == (lhs: AnimeLink, rhs: AnimeLink) -> Bool {
        return lhs.link == rhs.link
    }
}
