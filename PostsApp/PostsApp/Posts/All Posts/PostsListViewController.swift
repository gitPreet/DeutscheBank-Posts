//
//  PostsListViewController.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import UIKit

class PostsListViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: PostListViewModelType!
    
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
        viewModel?.onFetch = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.onEmptyList = {
            // show Empty list message
        }

        viewModel?.onError = { (error) in
            // showError
        }

        viewModel.refreshData = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    private func fetchAllUserPosts() {
        viewModel?.fetchAllPosts()
    }
}

extension PostsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier) as! PostCell
        let itemViewModel = viewModel.item(at: indexPath.row)
        cell.updateUI(viewModel: itemViewModel)
        return cell
    }
}
