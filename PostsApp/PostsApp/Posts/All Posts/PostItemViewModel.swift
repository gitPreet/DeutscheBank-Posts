//
//  PostItemViewModel.swift
//  PostsApp
//
//  Created by Preetham Baliga on 13/09/23.
//

import Foundation

struct PostItemViewModel {
    let titleText: String
    let bodyText: String
    var isFavourited: Bool = false
    let onFavourite: (() -> ())
}
