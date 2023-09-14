//
//  PostCell.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    struct ViewData {
        let titleText: String
        let bodyText: String
        let isFavourited: Bool
    }
    
    var onFavourite: (() -> Void)?

    var viewData: ViewData? {
        didSet {
            render()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewData = ViewData(titleText: "", bodyText: "", isFavourited: false)
    }

    private func render() {
        guard let viewData = viewData else { return }

        titleLabel.text = viewData.titleText
        descriptionLabel.text = viewData.bodyText
        if viewData.isFavourited {
            let image = UIImage(systemName: "star.fill")
            favouriteButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(systemName: "star")
            favouriteButton.setImage(image, for: .normal)
        }
    }

    @IBAction func favouriteButtonTapped(_ sender: Any) {
        onFavourite?()
    }
}
