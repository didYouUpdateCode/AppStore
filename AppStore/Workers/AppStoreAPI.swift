//
//  AppStoreAPI.swift
//  AppStore
//
//  Created by didYouUpdateCode on 2017/4/6.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import Foundation

class AppStoreAPI {
    
    static func fetchFeaturedApps(completionHandler: @escaping ([AppCategory]?, NSError?) -> Void) {
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
                    
                    var appCategories = [AppCategory]()
                    
                    if let categories = json["categories"] {
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
                            
                            appCategories.append(appCategory)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        completionHandler(appCategories, nil)
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
