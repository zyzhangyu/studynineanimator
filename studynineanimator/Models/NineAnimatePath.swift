//
//  NineAnimatePath.swift
//  studynineanimator
//
//  Created by developer on 2021/4/9.
//

import Foundation



struct NineAnimatePath : Hashable {
    static let home = NineAnimatePath("/")
    
    static func search(keyword: String?) -> NineAnimatePath {
        var path = "/search"
        
        
        /*
         *  我们请求一个url时,最好要对其编码,转换成url识别的字符,以对应url里可能存在的中文,特殊符号等
         */
        if let keyword = keyword,
           let wrappedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        { path += wrappedKeyword }
        
        return NineAnimatePath(path)
    }
    
    let value: String
    var hashValue: Int { return value.hashValue }
    
    private init(_ value: String) { self.value = value }
}

