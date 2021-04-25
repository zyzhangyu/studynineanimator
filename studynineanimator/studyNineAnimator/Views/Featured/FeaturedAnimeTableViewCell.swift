//
//  FeaturedAnimeTableViewCell.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/21.
//

import UIKit

class FeaturedAnimeTableViewCell:UITableViewCell {
     
    @IBOutlet weak var animeNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var animeImageView: UIImageView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    

//    override func layoutSubviews() {
//        super.layoutSubviews()
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

