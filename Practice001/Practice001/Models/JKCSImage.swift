//
//  ImagePack.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-13.
//  Copyright © 2020 Kuang. All rights reserved.
//

import Foundation
import JKCSSwift

enum JKCSImageSize {
    case thumbnail, small, medium, large, extraLarge, original
}

class JKCSImage: Equatable {
    let id: String
    var title: String = ""
    var info: JKCSImageInfo {
        didSet {
            info.save(key: id)
        }
    }
    var thumbnailImageData: JKCSImageData? = nil
    var smallImageData: JKCSImageData? = nil
    var mediumImageData: JKCSImageData? = nil
    var largeImageData: JKCSImageData? = nil
    var extraLargeImageData: JKCSImageData? = nil
    var originalImageData: JKCSImageData? = nil
    
    init(id: String) {
        self.id = id
        self.info = JKCSImageInfo(id: id)
    }
    
    static func == (lhs: JKCSImage, rhs: JKCSImage) -> Bool {
        return (lhs.id == rhs.id)
    }
    
    func retrieveImageDataFromCache(size: JKCSImageSize) -> JKCSCacheLookupResult {
        switch size {
        case .thumbnail:
            guard let targetImageData = thumbnailImageData else { return .abnormal }
            let result: Result<JKCSImageData?, JKCSError> = JKCSImageData.retrieve(key: targetImageData.id)
            switch result {
            case .failure(_):
                return .abnormal
            case .success(let imageData):
                if let imageData = imageData {
                    thumbnailImageData = imageData
                    return .hit
                }
                return .miss
            }
        case .small:
            guard let targetImageData = smallImageData else { return .abnormal }
            let result: Result<JKCSImageData?, JKCSError> = JKCSImageData.retrieve(key: targetImageData.id)
            switch result {
            case .failure(_):
                return .abnormal
            case .success(let imageData):
                if let imageData = imageData {
                    smallImageData = imageData
                    return .hit
                }
                return .miss
            }
        case .medium:
            guard let targetImageData = mediumImageData else { return .abnormal }
            let result: Result<JKCSImageData?, JKCSError> = JKCSImageData.retrieve(key: targetImageData.id)
            switch result {
            case .failure(_):
                return .abnormal
            case .success(let imageData):
                if let imageData = imageData {
                    mediumImageData = imageData
                    return .hit
                }
                return .miss
            }
        case .large:
            guard let targetImageData = largeImageData else { return .abnormal }
            let result: Result<JKCSImageData?, JKCSError> = JKCSImageData.retrieve(key: targetImageData.id)
            switch result {
            case .failure(_):
                return .abnormal
            case .success(let imageData):
                if let imageData = imageData {
                    largeImageData = imageData
                    return .hit
                }
                return .miss
            }
        case .extraLarge:
            guard let targetImageData = extraLargeImageData else { return .abnormal }
            let result: Result<JKCSImageData?, JKCSError> = JKCSImageData.retrieve(key: targetImageData.id)
            switch result {
            case .failure(_):
                return .abnormal
            case .success(let imageData):
                if let imageData = imageData {
                    extraLargeImageData = imageData
                    return .hit
                }
                return .miss
            }
        case .original:
            guard let targetImageData = originalImageData else { return .abnormal }
            let result: Result<JKCSImageData?, JKCSError> = JKCSImageData.retrieve(key: targetImageData.id)
            switch result {
            case .failure(_):
                return .abnormal
            case .success(let imageData):
                if let imageData = imageData {
                    originalImageData = imageData
                    return .hit
                }
                return .miss
            }
        }
    }
    
    func retrieveImageInfoFromCache() -> JKCSCacheLookupResult {
        let result: Result<JKCSImageInfo?, JKCSError> = JKCSImageInfo.retrieve(key: id)
        switch result {
        case .failure(_):
            return .abnormal
        case .success(let imageInfo):
            if let imageInfo = imageInfo {
                info = imageInfo
                return .hit
            }
            return .miss
        }
    }
    
    func loadImageData(size: JKCSImageSize, completionHandler: @escaping (Result<ExpressibleByNilLiteral?, JKCSError>) -> ()) {
        // To be overridden by subclass
    }
    
    func loadImageInfo(completionHandler: @escaping (Result<ExpressibleByNilLiteral?, JKCSError>) -> ()) {
        // To be overriddent by subclass
    }
}

class JKCSImageData: JKCSCachable {
    let id: String
    var data: Data? {
        didSet {
            if let _ = data {
                save(key: id)
            }
        }
    }
    
    init(id: String, data: Data? = nil) {
        self.id = id
        self.data = data
    }
}

class JKCSImageInfo: JKCSCachable {
    let id: String
    var title: String
    var author: String
    var date: String
    var location: String
    var description: String
    
    init(id: String, title: String = "", author: String = "", date: String = "", location: String = "", description: String = "") {
        self.id = id
        self.title = title
        self.author = author
        self.date = date
        self.location = location
        self.description = description
    }
}
