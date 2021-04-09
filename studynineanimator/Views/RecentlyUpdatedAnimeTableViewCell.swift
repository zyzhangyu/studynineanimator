//
//  RecentlyUpdatedAnimeTableViewCell.swift
//  studynineanimator
//
//  Created by developer on 2021/4/9.
//

import UIKit


class RecentlyUpdatedAnimeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var blurredCoverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    var title: String? {
        set { titleLabel.text = newValue ?? "" }
        get { return nil }
    }
    
    var status: String? {
        set { statusLabel.text = newValue ?? "" }
        get { return nil }
    }
    
    var coverImage: URL? {
        set {
            coverImageView.kf.setImage(with: newValue)
            blurredCoverImageView.kf.setImage(with: newValue)
        }
        get { return nil }
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
