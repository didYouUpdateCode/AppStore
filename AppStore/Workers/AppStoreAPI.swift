//
//  AppStoreAPI.swift
//  AppStore
//
//  Created by didYouUpdateCode on 2017/4/6.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import Foundation

class AppStoreAPI {
    
    static func fetchFeaturedApps(completionHandler: @escaping (FeaturedApps?, NSError?) -> Void) {
        let url = URL(string: "https://api.letsbuildthatapp.com/appstore/featured")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let error = error {
                    let nsError = NSError(domain: #function, code: #line, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                    throw nsError
                } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    let nsError = NSError(domain: #function, code: #line, userInfo: [NSLocalizedDescriptionKey: "Request failed due to \(httpResponse.statusCode)"])
                    throw nsError
                } else {
                    let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                    
                    var featuredApps = FeaturedApps()
                    
                    if let banner = json["bannerCategory"] {
                        featuredApps.bannerCategory = AppCategory()
                        featuredApps.bannerCategory?.name = banner["name"] as? String
                        featuredApps.bannerCategory?.type = banner["type"] as? String
                        featuredApps.bannerCategory?.apps = [App]()
                        
                        for bannerApp in banner["apps"] as! [[String: AnyObject]] {
                            var app = App()
                            
                            app.id = bannerApp["Id"] as? NSNumber
                            app.name = bannerApp["Name"] as? String
                            app.category = bannerApp["Category"] as? String
                            app.price = bannerApp["Price"] as? NSNumber
                            app.imageName = bannerApp["ImageName"] as? String
                            
                            featuredApps.bannerCategory?.apps?.append(app)
                        }
                    }
                    
                    
                    if let categories = json["categories"] {
                        featuredApps.appCategories = [AppCategory]()
                        
                        for category in categories as! [[String: AnyObject]] {
                            var appCategory = AppCategory()
                            
                            appCategory.name = category["name"] as? String
                            appCategory.type = category["type"] as? String
                            appCategory.apps = [App]()
                            
                            for featuredApp in category["apps"] as! [[String: AnyObject]] {
                                var app = App()
                                
                                app.id = featuredApp["Id"] as? NSNumber
                                app.name = featuredApp["Name"] as? String
                                app.category = featuredApp["Category"] as? String
                                app.price = featuredApp["Price"] as? NSNumber
                                app.imageName = featuredApp["ImageName"] as? String
                                
                                appCategory.apps?.append(app)
                            }
                            
                            featuredApps.appCategories?.append(appCategory)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(featuredApps, nil)
                    }
                }
            } catch let catchedError as NSError {
                DispatchQueue.main.async {
                    completionHandler(nil, catchedError)
                }
            }
            }.resume()
    }
}
