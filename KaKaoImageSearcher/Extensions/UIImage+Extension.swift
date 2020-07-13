//
//  UIImage+Extension.swift
//  KaKaoImageSearcher
//
//  Created by 서태원 on 2020/07/13.
//  Copyright © 2020 NOWEAT. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
