//
//  ImagesService.swift
//  Mindvalley Task
//
//  Created by Hesham Ali on 9/22/17.
//  Copyright © 2017 Hesham Ali. All rights reserved.
//

import UIKit

class ImagesService: MindValleyService {
    
    private static var imagesService:ImagesService?
    static func instance()-> ImagesService {
        if imagesService == nil {
            imagesService = ImagesService()
        }
        return imagesService!
    }
    
    func loadImages(completionHandler: @escaping (_ success: Bool, _ images: [Image]) -> Void){
        
        var images = [Image]()
        let urlPath = NSLocalizedString("IMAGES_ENDPOINT", comment: "comment")
        let url: NSURL = NSURL(string: urlPath)!
        let request = NSMutableURLRequest(url: url as URL)
        
        executeRequest(request: request, onSuccess: { (data) -> Void in
            var errorJSonSerialization: NSError?
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
                print("ImageService.getImageInfo - JSON Result: \((jsonResult as AnyObject).description)")
                
                let JSONUser = (jsonResult as AnyObject).value(forKey: "user")! as! NSArray
                let JSONUserURLs = (jsonResult as AnyObject).value(forKey: "urls")! as! NSArray
                var counter = 0
                for user in JSONUser{
                    let userDictionary = user as! NSDictionary
                    let profileImages = userDictionary.value(forKey: "profile_image") as! NSDictionary
                    let userURLs = JSONUserURLs[counter] as! NSDictionary
                    counter += 1
                    
                    let image = Image(profileImages: profileImages, userURLs: userURLs)
                    images.append(image)
                }
                completionHandler(true, images)
                
                
            } catch let error1 as NSError {
                errorJSonSerialization = error1
                if let error = errorJSonSerialization {
                    print("VideoService.getVideoInfo - Error during JSON Parsing: \(error.debugDescription)")
                    completionHandler(false, images)
                }
            } catch {
                fatalError()
            }
        }, onError: { (error) -> Void in
            print("error: \(error.localizedDescription): \(error.userInfo)")
            completionHandler(false, images)
            
            
        })
        
    }
    
    func executeRequest(request: NSMutableURLRequest, onSuccess: @escaping (_ data:NSData) -> Void, onError: @escaping (_ error:NSError) -> Void, executeDownload: Bool = false){
        let sr: ServiceRequest = ServiceRequest(request: request, onSuccess: onSuccess, onError: onError)
        executeServiceRequest(serviceRequest: sr, executeDownload: executeDownload)
    }

    
}
