//
//  PostCell.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import UIKit

protocol ItemViewModel {
    var titleText: String { get }
    var bodyText: String { get }
    var isFavourited: Bool { get }
    var onFavourite: (() -> Void)? { get }
}

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!

    var onFavourite: (() -> Void)?

    private var itemViewModel: ItemViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriptionLabel.text = ""
        favouriteButton.makeNormalFavouriteButton()
    }

    func updateUI(viewModel: ItemViewModel) {
        self.itemViewModel = viewModel

        titleLabel.text = viewModel.titleText
        descriptionLabel.text = viewModel.bodyText

        if viewModel.isFavourited {
            favouriteButton.makeHighlightedFavouriteButton()
        } else {
            favouriteButton.makeNormalFavouriteButton()
        }
    }

    @IBAction func favouriteButtonTapped(_ sender: Any) {
        itemViewModel.onFavourite?()
    }
}

private extension UIButton {

    func makeHighlightedFavouriteButton() {
        let image = UIImage(systemName: "star.fill")
        self.setImage(image, for: .normal)
        self.isUserInteractionEnabled = false
    }

    func makeNormalFavouriteButton() {
        let image = UIImage(systemName: "star")
        self.setImage(image, for: .normal)
        self.isUserInteractionEnabled = true
    }
}
