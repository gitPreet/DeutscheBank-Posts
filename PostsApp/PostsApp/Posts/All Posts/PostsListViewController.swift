//
//  PostsListViewController.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import UIKit

class PostsListViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    var viewModel: PostsViewModel?

    private var posts: [PostListViewModel] = [] {
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
            self?.posts = posts
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
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier) as! PostCell
        let post = posts[indexPath.row]
        cell.titleLabel.text = post.titleText
        cell.descriptionLabel.text = post.bodyText
        return cell
    }
}
