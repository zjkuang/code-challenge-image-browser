//
//  _ViewModel.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-16.
//  Copyright © 2020 Kuang. All rights reserved.
//

import Foundation
import JKCSSwift
import JKCSImageServiceSwift

class _ViewModel: NSObject {
    @objc dynamic var observableFlag1: Bool = false
    
    let imgur = JKCSImgur()
    func test() {
        imgur.search(for: "people") { (result) in
            switch result {
            case .failure(let error):
                print("*** error: \(error.message)")
            case .success(let result):
                break
            }
        }
    }
}
