//
//  UIImages+Extension.swift
//  RickAndMortyAPP
//
//  Created by Adriancys Jesus Villegas Toro on 2/1/23.
//

import UIKit

extension UIImageView {
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
