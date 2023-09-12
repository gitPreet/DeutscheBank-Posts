//
//  FavouritePostsViewController.swift
//  PostsApp
//
//  Created by Preetham Baliga on 12/09/23.
//

import UIKit

class FavouritePostsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favourite Posts"
    }
}
