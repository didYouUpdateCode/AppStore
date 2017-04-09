//
//  MainViewController.swift
//  AppStore
//
//  Created by Hank Chiang on 2017/4/7.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var featuredApps: FeaturedApps? {
        didSet {
            bannerView.reloadData()
            tableView.reloadData()
        }
    }
    var previousOffset = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Featured items"
        
        setupBannerView()
        setupTableView()
        fetchData()
    }
    
    private func setupBannerView() {
        bannerView.register(UINib(nibName: "BannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        bannerView.dataSource = self
        bannerView.delegate = self
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: bannerView.frame.height, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchData() {
        AppStoreAPI.fetchFeaturedApps(completionHandler: { (featuredApps, error) in
            self.featuredApps = featuredApps
        })
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 160
        }
        
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featuredApps?.appCategories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        let appCategory = featuredApps?.appCategories?[indexPath.row]
        
        cell.name = appCategory?.name
        cell.apps = appCategory?.apps
        cell.type = appCategory?.type
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let absoluteTop: CGFloat = -tableView.contentInset.top
            let absoluteBottom: CGFloat = tableView.contentSize.height - tableView.frame.size.height
            
            if (scrollView.contentOffset.y < absoluteTop) || (scrollView.contentOffset.y > absoluteBottom) {
                return
            }
            
            let offset = scrollView.contentOffset.y - previousOffset.y
            let isScrollingDown = offset > 0
            let isScrollingUp = offset < 0
            
            if isScrollingDown {
                let newConstant = topConstraint.constant - abs(offset)
                if newConstant < -tableView.contentInset.top {
                    topConstraint.constant = -tableView.contentInset.top
                } else {
                    topConstraint.constant = newConstant
                }
            } else if isScrollingUp {
                let newConstant = topConstraint.constant + abs(offset)
                if newConstant > 0 {
                    topConstraint.constant = 0
                } else if tableView.contentOffset.y <= 0 {
                    topConstraint.constant = newConstant
                }
            }
            
            previousOffset = scrollView.contentOffset
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredApps?.bannerCategory?.apps?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
        let app = featuredApps?.bannerCategory?.apps?[indexPath.row]
        
        cell.imageName = app?.imageName
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return bannerView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
