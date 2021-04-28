//
//  SimpleAnimeTableViewCell.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/25.
//

import UIKit


class SimpleAnimeTableViewCell: UITableViewCell {
    var animeLink: AnimeLink? = nil {
        didSet{ self.textLabel?.text = animeLink?.title }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
