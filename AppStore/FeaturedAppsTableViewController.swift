//
//  FeaturedAppsTableViewController.swift
//  AppleStore
//
//  Created by didYouUpdateCode on 2017/3/28.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import UIKit

class FeaturedAppsTableViewController: UITableViewController {
    
    var appCategories: [AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        AppStoreAPI.fetchFeaturedApps(completionHandler: { (appCategories, error) in
            self.appCategories = appCategories
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appCategories?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        let appCategory = appCategories?[indexPath.row]
        
        cell.name = appCategory?.name
        cell.apps = appCategory?.apps
        cell.type = appCategory?.type
        
        return cell
    }
}
