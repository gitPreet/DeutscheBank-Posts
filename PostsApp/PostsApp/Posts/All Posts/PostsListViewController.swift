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
    }
}

extension PostsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.reuseIdentifier) as! PostCell
        cell.titleLabel.text = "asdasda asdlkasdlaksd asdlkasdlasdasd"
        cell.descriptionLabel.text = "asdasdasdnalsd alskdalskdlasd laskdlasdalsdalsdasdss"
        return cell
    }
}
