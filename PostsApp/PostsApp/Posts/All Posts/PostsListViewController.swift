//
//  PostsListViewController.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import UIKit

class PostsListViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView.estimatedRowHeight = 87.0
        tableView.rowHeight = UITableView.automaticDimension
        let nib = UINib(nibName: "PostCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: PostCell.reuseIdentifier)
    }
}

extension PostsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier) as! PostCell
        cell.titleLabel.text = "title"
        cell.descriptionLabel.text = "description"
        return cell
    }
}
