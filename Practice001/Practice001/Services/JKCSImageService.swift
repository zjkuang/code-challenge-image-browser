//
//  JKCSImageService.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-13.
//  Copyright © 2020 Kuang. All rights reserved.
//

import Foundation
import JKCSSwift

enum JKCSImageDataSourceType {
    case Flickr
    // case Imgur, Unsplash, Shutterstock, GettyImages
}

class JKCSImageSearchResult {
    let term: String
    var total: Int = -1
    var page: Int = -1
    var pages: Int = -1
    var perpage: Int = 20
    var items: [JKCSImage] = []
    
    init(term: String = "") {
        self.term = term
    }
}

protocol JKCSImageService {
    var searchResult: JKCSImageSearchResult {get set}
    func search(for term: String, pageSize: Int, page: Int, completionHandler: @escaping (Result<JKCSImageSearchResult, JKCSError>) -> ())
}
