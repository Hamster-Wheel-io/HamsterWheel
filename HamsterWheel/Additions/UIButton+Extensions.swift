//
//  ButtonExtension.swift
//  HamsterWheel
//
//  Created by Bob De Kort on 3/27/18.
//  Copyright © 2018 Bob De Kort. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    override open var intrinsicContentSize: CGSize {
        let intrinsicContentSize = super.intrinsicContentSize
        let adjustedWidth = intrinsicContentSize.width
        let adjustedHeight = intrinsicContentSize.height
        return CGSize(width: adjustedWidth, height: adjustedHeight)
    }
}

extension UIButton {
    func withImageDowloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async {
                self.setImage(image, for: .normal)
                self.imageView?.contentMode = mode
            }
            }.resume()
    }
    
    func withImageDownloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        withImageDowloadedFrom(url: url, contentMode: mode)
    }
}
