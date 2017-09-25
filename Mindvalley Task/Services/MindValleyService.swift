//
//  MindValleyService.swift
//  Mindvalley Task
//
//  Created by Hesham Ali on 9/22/17.
//  Copyright © 2017 Hesham Ali. All rights reserved.
//

import UIKit

class MindValleyService: NSObject {
    
    class ServiceRequest: NSObject {
        let request: NSMutableURLRequest
        let onSuccess: (_ data:NSData) -> Void
        let onError: (_ error:NSError) -> Void
        
        init(request: NSMutableURLRequest, onSuccess: @escaping (_ data:NSData) -> Void, onError: @escaping (_ error:NSError) -> Void){
            self.request = request;
            self.onSuccess = onSuccess
            self.onError = onError
        }
    }
    
    func executeServiceRequest(serviceRequest: ServiceRequest, executeDownload: Bool = false){
        
        let task:URLSessionTask
        let session = URLSession.shared
        task = session.dataTask(with: serviceRequest.request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let err = error as? NSError {
                print("error: \(err.localizedDescription):")
                if(err.domain == NSURLErrorDomain){
                    print("------------------Fatal error [Code: \(err.code), Desc: \(err.description)")
                }
                
                serviceRequest.onError(err)
            } else {
                if let res = response as? HTTPURLResponse{
                    let statusCode = res.statusCode
                    if(statusCode < 400){
                        
                        serviceRequest.onSuccess(data! as NSData)
                    }
                }  else {
                    serviceRequest.onError(NSError(domain: "", code: 0, userInfo: nil))
                }
            }
        })
        task.resume()
    }

}
