//
//  AnimeSearchResultTableViewCell.swift
//  studyNineAnimator
//
//  Created by developer on 2021/4/25.
//

import UIKit
import Kingfisher

class AnimeSearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    
    var animeLink: AnimeLink? = nil {
        didSet{
            guard let link = animeLink else { return }
            coverImageView.kf.setImage(with: link.image)
            animeTitleLabel.text = link.title
        }
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
