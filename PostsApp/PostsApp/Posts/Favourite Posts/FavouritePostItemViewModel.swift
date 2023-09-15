//
//  FavouritePostItemViewModel.swift
//  PostsApp
//
//  Created by Preetham Baliga on 14/09/23.
//

import Foundation

struct FavouritePostItemViewModel: ItemViewModel {
    let titleText: String
    let bodyText: String
    var isFavourited: Bool = true
    var onFavourite: (() -> Void)? = nil
}
