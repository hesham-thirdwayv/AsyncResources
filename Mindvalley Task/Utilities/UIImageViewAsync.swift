//
//  UIImageViewAsync.swift
//  Mindvalley Task
//
//  Created by Hesham Ali on 9/22/17.
//  Copyright © 2017 Hesham Ali. All rights reserved.
//

import Foundation
import UIKit

class UIImageViewAsync :UIImageView
{
    override init(frame:CGRect)
    {
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getDataFromUrl(url:URL, completion: @escaping ((_ data: NSData?) -> Void)) {
        let request = NSMutableURLRequest(url: url as URL)
        let task:URLSessionTask
        let config = URLSessionConfiguration.default
        config.httpCookieAcceptPolicy = .always
        config.httpShouldSetCookies = true
        
        
        let session = URLSession(configuration: config)
        task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let err = error as? NSError {
                if err.domain == NSURLErrorDomain && err.code == NSURLErrorTimedOut {
                    completion(nil)
                }
            }else{
                completion(NSData(data: data!))
            }
        }
        task.resume()
    }
    
    func downloadImage(url:URL,defaultImageName:String){
        getDataFromUrl(url: url) { data in
            DispatchQueue.main.async {
                print("loading image from url :\(url)")
                self.contentMode = UIViewContentMode.scaleToFill
                if data != nil && data?.length != 0{
                    
                    self.image = UIImage(data: data! as Data)
                    if self.image == nil {
                        self.image=UIImage(named: defaultImageName)
                    }
                    
                }
                else
                {
                    self.image = UIImage(named: defaultImageName)
                }
            }
        }
    }

}

