//
//  NineAnimatePath.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/21.
//

import Foundation
struct NineAnimatePath : Hashable {
    static let home = NineAnimatePath("/")
    
    static let featured = NineAnimatePath("/newseason/1")
    
    static func animeDetails(animeID: String) -> NineAnimatePath {
        let path = "/details/\(animeID)"
        return NineAnimatePath(path)
    }
    
    static func search(keyword: String?) -> NineAnimatePath {
        var path = "/search"
        
        if let keyword = keyword,
           let wrappedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        { path += wrappedKeyword }
        
        return NineAnimatePath(path)
    }
    
    static func eposide(animeID: String, eposideIndex: String) -> NineAnimatePath {
        let path = "/watching/\(animeID)/\(eposideIndex)"
        return NineAnimatePath(path)
    }
    
    let value: String
    var hashValue: Int { return value.hashValue }
    
    private init(_ value: String) { self.value = value }
}
