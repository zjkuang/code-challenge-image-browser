//
//  JKCSImageDetailViewController.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-15.
//  Copyright © 2020 Kuang. All rights reserved.
//

import UIKit
import JKCSImageServiceSwift

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
                self?.updateImage()
            }
        })
        imageInfoReadyObservation = viewModel.observe(\JKCSImageDetailViewModel.imageInfoReady, options: [.old, .new], changeHandler: { [weak self] (viewModel, change) in
            if change.newValue ?? false {
                self?.updateImageInfo()
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
    
    private func updateImage() {
        guard let data = viewModel.image?.mediumImageData?.data else {
            return
        }
        imageView.image = UIImage(data: data)
    }
    
    private func updateImageInfo() {
        guard let imageInfo = viewModel.image?.info else {
            return
        }
        authorLabel.text = imageInfo.author
        dateLabel.text = imageInfo.date
        locationLabel.text = imageInfo.location
    }

}
