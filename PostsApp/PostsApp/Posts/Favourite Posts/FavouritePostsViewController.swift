//
//  FavouritePostsViewController.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import UIKit

class FavouritePostsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: FavouritePostListViewModelType!

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
        viewModel?.onFetch = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
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
        return viewModel.favItemCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier) as! PostCell
        let favItemViewModel = viewModel.favPost(at: indexPath.row)
        cell.updateUI(viewModel: favItemViewModel)
        return cell
    }

}
