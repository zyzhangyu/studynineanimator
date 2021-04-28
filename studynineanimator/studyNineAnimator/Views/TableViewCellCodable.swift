//
//  TableViewCellCodable.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/28.
//

import Foundation

protocol TableViewCellCodable {
    func addSubview()
    func addConstraints()
    func addLayout()
}

extension TableViewCellCodable {
    
    func setupViewCodable() {
        addSubview()
        addConstraints()
        addLayout()
    }
}
