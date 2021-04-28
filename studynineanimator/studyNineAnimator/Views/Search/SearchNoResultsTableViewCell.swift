//
//  SearchNoResultsTableViewCell.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/28.
//

import UIKit

class SearchNoResultsTableViewCell: UITableViewCell {
    
    static let identifier = "search.notfound"
    
    private lazy var searchSubtitleLabel:UILabel = {
        
        let label = UILabel.init()
        label.text = "啥也没有"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViewCodable()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchNoResultsTableViewCell: TableViewCellCodable {
    func addSubview() {
        self.addSubview(searchSubtitleLabel)
    }
    
    func addConstraints() {
        searchSubtitleLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(10)
            maker.centerX.equalToSuperview()
        }
        
        
    }
    
    func addLayout() {
        
    }
    
    
}
