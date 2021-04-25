//
//  String+IntegerRangeSubstring.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/21.
//

import Foundation


extension String {
    
    /// Countable  可数的,可计算的
    /// ClosedRange 闭区间
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    /// Countable  可数的,可计算的
    /// Range 左开右闭区间
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    subscript (bounds: NSRange) -> String {
        let range = Range(bounds, in: self)!
        return String(self[range])
    }
    
    var matchingRange: NSRange {
        return NSRange(location: 0, length: utf16.count)
    }
}
