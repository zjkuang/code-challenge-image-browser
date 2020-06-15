//
//  JKCSImageDetailViewController.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-15.
//  Copyright © 2020 Kuang. All rights reserved.
//

import UIKit

class JKCSImageDetailViewController: JKCSViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var loadImageActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var loadInfoActivityIndicatorView: UIActivityIndicatorView!
    
    private var viewModel = JKCSImageDetailViewModel()
    private var showLoadImageActivityIndicatorObservation: NSKeyValueObservation? // KVO
    private var showLoadInfoActivityIndicatorObservation: NSKeyValueObservation? // KVO
    private var imageDataReadyObservation: NSKeyValueObservation? // KVO
    private var imageInfoReadyObservation: NSKeyValueObservation? // KVO
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setKVO()
        
        imageView.image = UIImage(systemName: "photo")
        titleLabel.text = viewModel.image?.title
        
        viewModel.loadImage()
        viewModel.loadInfo()
    }
    
    func setImage(_ image: JKCSImage) {
        viewModel.image = image
    }
    
    private func setKVO() {
        showLoadImageActivityIndicatorObservation = viewModel.observe(\JKCSImageDetailViewModel.showLoadImageActivityIndicator, options: [.old, .new], changeHandler: { [weak self] (viewModel, change) in
            if change.newValue ?? false {
                self?.startActivity(self?.loadImageActivityIndicatorView)
            }
            else {
                self?.endActivity(self?.loadImageActivityIndicatorView)
            }
        })
        showLoadInfoActivityIndicatorObservation = viewModel.observe(\JKCSImageDetailViewModel.showLoadInfoActivityIndicator, options: [.old, .new], changeHandler: { [weak self] (viewModel, change) in
            if change.newValue ?? false {
                self?.startActivity(self?.loadInfoActivityIndicatorView)
            }
            else {
                self?.endActivity(self?.loadInfoActivityIndicatorView)
            }
        })
        imageDataReadyObservation = viewModel.observe(\JKCSImageDetailViewModel.imageDataReady, options: [.old, .new], changeHandler: { [weak self] (viewModel, change) in
            if change.newValue ?? false {
                if let imageData = self?.viewModel.image?.mediumImageData?.data {
                    self?.imageView.image = UIImage(data: imageData)
                }
            }
        })
        imageInfoReadyObservation = viewModel.observe(\JKCSImageDetailViewModel.imageInfoReady, options: [.old, .new], changeHandler: { [weak self] (viewModel, change) in
            if change.newValue ?? false {
                if let imageInfo = self?.viewModel.image?.info {
                    self?.authorLabel.text = imageInfo.author
                    self?.dateLabel.text = imageInfo.date
                    self?.locationLabel.text = imageInfo.location
                }
            }
        })
    }
    
    private func startActivity(_ activityIndicatorView: UIActivityIndicatorView? = nil) {
        guard let activityIndicatorView = activityIndicatorView else {
            return
        }
        baseView.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func endActivity(_ activityIndicatorView: UIActivityIndicatorView? = nil) {
        guard let activityIndicatorView = activityIndicatorView else {
            return
        }
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        baseView.sendSubviewToBack(activityIndicatorView)
    }

}
