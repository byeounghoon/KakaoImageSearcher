//
//  SearchViewController.swift
//  KaKaoImageSearcher
//
//  Created by TaeWon Seo on 2020/07/05.
//  Copyright © 2020 NOWEAT. All rights reserved.
//

import UIKit

let restAPIKey: String = "KakaoAK 939583921c9ced3da5147a6ac9f4cf4a"

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
        let urlString = "https://dapi.kakao.com/v2/search/image?query=" + query
        // 검색어에 한글이 들어가면 URL 인스턴스를 초기화할 때 nil이 반환되는 것을 방지하기 위해 인코딩.
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: encodedString) else { return }
        print("URL : \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(restAPIKey, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            
            let response: HTTPURLResponse = response as! HTTPURLResponse
            print(response.statusCode)
        }.resume()
    }
    
}
