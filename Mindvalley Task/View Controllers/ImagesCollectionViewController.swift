//
//  ImagesCollectionViewController.swift
//  Mindvalley Task
//
//  Created by Hesham Ali on 9/25/17.
//  Copyright © 2017 Hesham Ali. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCollectionViewCell"

class ImagesCollectionViewController: UICollectionViewController {
    var images:[Image] = []
    var uiImages:[URL] = [URL]()
    override func viewDidLoad() {
        super.viewDidLoad()
        ImagesService.instance().loadImages(completionHandler: { (success,images) -> Void in
            OperationQueue.main.addOperation({() -> Void in
                
                if(success){
                    self.images = images
                    self.collectionView?.reloadData()
                }
                else{
                    
                    let showAlert = UIAlertController(title: NSLocalizedString("APP_TITLE", comment: "comment"), message:NSLocalizedString("COULD_NOT_LOAD_VIDEOS", comment: "comment"), preferredStyle: UIAlertControllerStyle.alert)
                    
                    showAlert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "comment"), style: .default, handler: { (action: UIAlertAction) in
                        
                    }))
                    self.present(showAlert, animated: true, completion: nil)
                    
                }
                
            })
            
        })

        
    }
    
    
    @IBAction func changeIcon(_ sender: Any) {
        DispatchQueue.main.async() { () -> Void in
            let indexPath:NSIndexPath = NSIndexPath(row: 0, section: 0)
            let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ImageCollectionViewCell
            
            cell.imageCell.image = UIImage(named: "Icon changed")
            cell.setNeedsDisplay()
            cell.imageCell.setNeedsDisplay()
            self.collectionView?.setNeedsDisplay()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return images.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images[section].uiImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
        
        cell.imageCell.image = self.images[indexPath.section].uiImages[indexPath.row].image
        
        
    
        return cell
    }

}
