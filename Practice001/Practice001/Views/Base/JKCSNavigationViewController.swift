//
//  JKCSNavigationViewController.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-13.
//  Copyright © 2020 Kuang. All rights reserved.
//

import UIKit
import JKCSSwift

class JKCSNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func overrideTraitCollection(forChild childViewController: UIViewController) -> UITraitCollection? {
        if UIDevice.current.isPad() {
            if UIDevice.current.isLandscape() {
                return UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .regular), UITraitCollection.init(verticalSizeClass: .compact)])
            }
            else {
                return UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .compact), UITraitCollection.init(verticalSizeClass: .regular)])
            }
        }
        return UITraitCollection(traitsFrom: [UITraitCollection(horizontalSizeClass: .unspecified), UITraitCollection.init(verticalSizeClass: .unspecified)])
    }

}
