//
//  PostsListViewController.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import UIKit

class PostsListViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: PostListViewModel?

    private var postItemViewModel: [PostItemViewModel] = [] {
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
        fetchAllUserPosts()
    }

    private func setupTableView() {
        tableView.estimatedRowHeight = 87.0
        tableView.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: PostCell.nibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: PostCell.reuseIdentifier)
    }

    private func bindViewModel() {
        viewModel?.onFetch = { [weak self] (posts) in
            self?.postItemViewModel = posts
        }

        viewModel?.onError = { (error) in
            // showError
        }
    }

    private func fetchAllUserPosts() {
        viewModel?.fetchAllPosts()
    }
}

extension PostsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postItemViewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier) as! PostCell
        let itemViewModel = postItemViewModel[indexPath.row]
        let cellViewData = PostCell.ViewData(titleText: itemViewModel.titleText,
                                             bodyText: itemViewModel.bodyText,
                                             isFavourited: false)
        cell.viewData = cellViewData
        cell.onFavourite = {
            itemViewModel.onFavourite()
        }
        return cell
    }
}
