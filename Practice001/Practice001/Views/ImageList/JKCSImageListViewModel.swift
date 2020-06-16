//
//  JKCSImageListViewModel.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-15.
//  Copyright © 2020 Kuang. All rights reserved.
//

import Foundation
import JKCSImageServiceSwift

class JKCSImageListViewModel: NSObject {
    @objc dynamic var showActivityIndicator: Bool = false
    @objc dynamic var reloadData: Bool = false
    private var imageDataSourceType: JKCSImageDataSourceType = .Flickr
    private var imageService: JKCSImageService = JKCSFlickr()
    private var term: String = ""
    
    func switchImageDataSource(to type: JKCSImageDataSourceType) {
        imageDataSourceType = type
        switch type {
        case .Flickr:
            imageService = JKCSFlickr()
        // case <other>:
            // ...
        }
    }
    
    func searchResult() -> JKCSImageSearchResult {
        return imageService.searchResult
    }
    
    func search(_ text: String?) {
        guard let text = text else {
            return
        }
        term = text.trimmingCharacters(in: .whitespaces).components(separatedBy: .whitespaces).compactMap({ (component) in
            if component.count == 0 {
                return nil
            }
            return component
        }).joined(separator: " ")
        loadNextSearchResultPage()
    }
    
    func loadMore() {
        loadNextSearchResultPage()
    }
    
    private func loadNextSearchResultPage() {
        guard term.count > 0 else {
            return
        }
        self.showActivityIndicator = true
        imageService.search(for: term, pageSize: 20, page: -1) { [weak self] (result) in
            self?.showActivityIndicator = false
            switch result {
            case .failure(_):
                break
            case .success(let searchResult):
                for item in searchResult.items {
                    item.loadImageData(size: .thumbnail) { [weak self] (result) in
                        switch result {
                        case .failure(_):
                            break
                        case .success(_):
                            self?.reloadData = true
                        }
                    }
                }
            }
            self?.reloadData = true
        }
    }
}
