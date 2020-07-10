//
//  SearchViewController.swift
//  KaKaoImageSearcher
//
//  Created by TaeWon Seo on 2020/07/05.
//  Copyright © 2020 NOWEAT. All rights reserved.
//

import UIKit

let restAPIKey: String = "KakaoAK 939583921c9ced3da5147a6ac9f4cf4a"

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var response: ImageResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSearchController()
    }
    
    func setSearchController() {
        self.navigationItem.titleView = searchController.searchBar
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    // MARK: - Search Methods
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        requestSearch(query: text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text else { return }
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
            // url 리퀘스트에 에러가 발생했을 경우 함수 리턴.
            if error != nil {
                print(error ?? "")
                return
            }
            // response가 nil이거나 응답 코드가 200(성공)이 아닌 경우 애러와 함께 함수 리턴.
            guard let response: HTTPURLResponse = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Error: invalid HTTP response code")
                return
            }
            // data가 없을 경우 함수 리턴.
            guard let data = data else {
                print("Error: missing data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                self.response = try decoder.decode(ImageResponse.self, from: data)
                
                //print(self.response)
                // UI 변화는 메인스레드와 비동기로 실행되어야 한다.
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error : \(error.localizedDescription)")
            }
        }.resume()
    }
    
}

//MARK: - CollectionView
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 검색 결과로 얻은 이미지의 수가 nil이면 0 반환
        if let count = response?.documents.count {
            return count
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // ThumbnailImageView 초기화 후 반환
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThumbnailImageView", for: indexPath)
        cell.contentView.backgroundColor = .systemBlue
        return cell
    }
    
    
}
