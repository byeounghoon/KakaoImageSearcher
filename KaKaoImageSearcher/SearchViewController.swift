//
//  SearchViewController.swift
//  KaKaoImageSearcher
//
//  Created by TaeWon Seo on 2020/07/05.
//  Copyright © 2020 NOWEAT. All rights reserved.
//

import UIKit

let restAPIKey: String = "939583921c9ced3da5147a6ac9f4cf4a"

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchController()
    }
    
    func setSearchController() {
        self.navigationItem.titleView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    // MARK: - Search Methods
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        requestSearch(query: text)
    }
    
    func requestSearch(query: String) {
        guard let url = URL(string: "https://dapi.kakao.com/v2/search/image/data?query=\(query)/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(restAPIKey, forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            let response: HTTPURLResponse = response as! HTTPURLResponse
            print(response)
        }
    }
    
}
