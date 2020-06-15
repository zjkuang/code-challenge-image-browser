//
//  JKCSImageDetailViewModel.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-15.
//  Copyright © 2020 Kuang. All rights reserved.
//

import Foundation

class JKCSImageDetailViewModel: NSObject {
    @objc dynamic var showLoadImageActivityIndicator: Bool = false
    @objc dynamic var showLoadInfoActivityIndicator: Bool = false
    @objc dynamic var imageDataReady: Bool = false
    @objc dynamic var imageInfoReady: Bool = false
    var image: JKCSImage? = nil
    
    func loadImage() {
        guard let image = image else {
            return
        }
        showLoadImageActivityIndicator = true
        image.loadImageData(size: .medium) { [weak self] (result) in
            self?.showLoadImageActivityIndicator = false
            switch result {
            case .failure(_):
                break
            case .success(_):
                self?.imageDataReady = true
            }
        }
    }
    
    func loadInfo() {
        showLoadInfoActivityIndicator = true
        image?.loadImageInfo(completionHandler: { [weak self] (result) in
            self?.showLoadInfoActivityIndicator = false
            switch result {
            case .failure(_):
                break
            case .success(_):
                self?.imageInfoReady = true
            }
        })
    }
}
