//
//  PostCell.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!

    var onFavourite: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func favouriteButtonTapped(_ sender: Any) {
        onFavourite?()
    }
}
