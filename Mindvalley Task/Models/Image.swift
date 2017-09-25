//
//  Image.swift
//  Mindvalley Task
//
//  Created by Hesham Ali on 9/22/17.
//  Copyright © 2017 Hesham Ali. All rights reserved.
//

import UIKit
class Image: NSObject {
    var profileImages:NSDictionary = [:]
    var userURLs:NSDictionary = [:]
    var uiImages:[UIImageViewAsync] = [UIImageViewAsync]();
    init(profileImages:NSDictionary,userURLs:NSDictionary) {
        super.init()
        self.profileImages = profileImages
        self.userURLs = userURLs
        self.convertURLToImage(imagesDictionary: self.profileImages)
        self.convertURLToImage(imagesDictionary: self.userURLs)
    }
    
    func convertURLToImage(imagesDictionary:NSDictionary){
        
        for image in imagesDictionary {
            let url:NSURL = NSURL.init(string: image.value as! String)!
            uiImages.append(UIImageViewAsync.init(frame: CGRect.zero))
            self.uiImages.last?.downloadImage(url: url as URL, defaultImageName: "Image \(self.uiImages.count)")
            
            
            
        }
        
    }

}
