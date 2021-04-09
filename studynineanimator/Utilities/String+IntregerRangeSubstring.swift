//
//  String+IntregerRangeSubstring.swift
//  studynineanimator
//
//  Created by developer on 2021/4/9.
//

import Foundation

extension String {
    
    /*
     * 字符串截取
     * CountableClosedRange 可数闭区间
     */
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    /*
     * 字符串截取
     * CountableRange 可数的开区间
     */
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    /*
     * 字符串截取
     * Range 不可数的开居间
     */
    subscript (bounds: NSRange) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    /*
     * 区间匹配
     * encodedOffset 对字符串索引代码位的偏移量
     */
    var matchingRange: NSRange {
        return NSRange.init(location: startIndex.encodedOffset, length: endIndex.encodedOffset)
    }
}
