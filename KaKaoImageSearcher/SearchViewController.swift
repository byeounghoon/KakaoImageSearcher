//
//  SearchViewController.swift
//  KaKaoImageSearcher
//
//  Created by TaeWon Seo on 2020/07/05.
//  Copyright © 2020 NOWEAT. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setSearchController() {
        self.navigationItem.titleView = searchController.searchBar
        searchController.searchResultsUpdater = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
