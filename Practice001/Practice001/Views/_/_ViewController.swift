//
//  _ViewController.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-16.
//  Copyright © 2020 Kuang. All rights reserved.
//

import UIKit

class _ViewController: UIViewController {
    
    @IBOutlet weak var baseView: UIView!
    
    private var viewModel = _ViewModel()
    private var flag1Observation: NSKeyValueObservation? // KVO
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setKVO()
        viewModel.test()
    }
    
    private func setKVO() {
        flag1Observation = viewModel.observe(\_ViewModel.observableFlag1, options: [.old, .new], changeHandler: { (viewModel, change) in
            print("*** flag1Observation: \((change.oldValue ?? false) ? "true" : "false") -> \((change.newValue ?? false) ? "true" : "false")")
            if change.newValue != change.oldValue {
                
            }
        })
    }

}
