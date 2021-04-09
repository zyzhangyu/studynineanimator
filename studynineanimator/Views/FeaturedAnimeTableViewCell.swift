//
//  FeaturedAnimeTableViewCell.swift
//  studynineanimator
//
//  Created by developer on 2021/4/8.
//


import UIKit

class FeaturedAnimeTableViewCell: UITableViewCell {


    @IBOutlet weak var animeImageView: UIImageView!
    
    @IBOutlet weak var animeTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
