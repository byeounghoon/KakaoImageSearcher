//
//  ImageDetailViewController.swift
//  KaKaoImageSearcher
//
//  Created by 서태원 on 2020/07/13.
//  Copyright © 2020 NOWEAT. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet private weak var selectedImageView: UIImageView!
    
    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.toolbar.isHidden = false
        
        loadImage()
    }
    
    func loadImage() {
        guard let imageUrl = URL(string: document!.image_url) else { return }
        
        selectedImageView.load(url: imageUrl)
    }
    
    @IBAction func tapDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSaveButton(_ sender: Any) {
    }
}
