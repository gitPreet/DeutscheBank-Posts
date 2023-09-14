//
//  FavouritePostsViewController.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import UIKit

class FavouritePostsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: FavouritePostListViewModel?

    private var favPostItemViewModel: [FavouritePostItemViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavouritePosts()
    }

    private func setupTableView() {
        tableView.estimatedRowHeight = 87.0
        tableView.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "PostCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: PostCell.reuseIdentifier)
    }

    private func bindViewModel() {
        viewModel?.onFetch = { [weak self] (posts) in
            self?.favPostItemViewModel = posts
        }

        viewModel?.onError = { (error) in
            // showError
        }
    }

    private func loadFavouritePosts() {
        viewModel?.loadFavouritePosts()
    }
}

extension FavouritePostsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favPostItemViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier) as! PostCell
        let itemViewModel = favPostItemViewModel[indexPath.row]
        cell.titleLabel.text = itemViewModel.titleText
        cell.descriptionLabel.text = itemViewModel.bodyText
        cell.favouriteButton.isHidden = true
        return cell
    }

}
