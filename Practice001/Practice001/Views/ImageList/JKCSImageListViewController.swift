//
//  JKCSImageListViewController.swift
//  Practice001
//
//  Created by Zhengqian Kuang on 2020-06-15.
//  Copyright © 2020 Kuang. All rights reserved.
//

import UIKit

class JKCSImageListViewController: JKCSViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = JKCSImageListViewModel()
    private var showActivityIndicatorObservation: NSKeyValueObservation? // KVO
    private var reloadDataIndicatorObservation: NSKeyValueObservation? // KVO
    private var imageDataSourceSwitchedObservation: NSKeyValueObservation? // KVO
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setKVO()
        tableView.register(UINib(nibName: JKCSImageListTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: JKCSImageListTableViewCell.reuseId)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Switch", style: .plain, target: self, action: #selector(switchTapped))
        updateViewTitle()
    }
    
    private func setKVO() {
        showActivityIndicatorObservation = viewModel.observe(\JKCSImageListViewModel.showActivityIndicator, options: [.old, .new], changeHandler: { [weak self] (viewModel, change) in
            if change.newValue ?? false {
                self?.startActivity()
            }
            else {
                self?.endActivity()
            }
        })
        reloadDataIndicatorObservation = viewModel.observe(\JKCSImageListViewModel.reloadData, options: [.old, .new], changeHandler: { [weak self] (viewModel, change) in
            if change.newValue ?? false {
                self?.tableView.reloadData()
            }
        })
        imageDataSourceSwitchedObservation = viewModel.observe(\JKCSImageListViewModel.imageDataSourceSwitched, options: [.old, .new], changeHandler: { [weak self] (viewModel, change) in
            if change.newValue ?? false {
                self?.updateViewTitle()
            }
        })
    }
    
    private func startActivity() {
        view.isUserInteractionEnabled = false
        baseView.bringSubviewToFront(activityIndicatorView)
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func endActivity() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        baseView.sendSubviewToBack(activityIndicatorView)
        view.isUserInteractionEnabled = true
    }
    
    private func updateViewTitle() {
        let title = viewModel.currentImageDataSource().rawValue
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        label.textAlignment = .center
        label.text = title
        setNavigationBarTitleView(titleView: label)
    }
    
    @objc private func switchTapped() {
        viewModel.switchImageDataSource()
    }

}

// MARK: - UISearchBarDelegate

extension JKCSImageListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.search(searchBar.text)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension JKCSImageListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResult().items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.searchResult().items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: JKCSImageListTableViewCell.reuseId) as! JKCSImageListTableViewCell
        cell.imageTitleLabel.text = item.title
        if let thumbnailImageData = item.thumbnailImageData?.data {
            cell.thumbnailImageView.image = UIImage(data: thumbnailImageData)
        }
        else {
            cell.thumbnailImageView.image = UIImage(systemName: "photo")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let imageDetailViewController = JKCSImageDetailViewController()
        imageDetailViewController.setImage(viewModel.searchResult().items[indexPath.row])
        navigationController?.pushViewController(imageDetailViewController, animated: true)
    }
}

// MARK: - UISrollViewDelegate

extension JKCSImageListViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y > 0) && (scrollView.contentOffset.y + scrollView.frame.height >= scrollView.contentSize.height) {
            viewModel.loadMore()
        }
    }
}
