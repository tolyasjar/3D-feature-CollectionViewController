//
//  PhotosCollectionViewController.swift
//  CollectionViewProject
//
//  Created by Toleen Jaradat on 3/6/17.
//  Copyright © 2017 Toleen Jaradat. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController, UIViewControllerPreviewingDelegate {

    var photos = [Photo]()
    override func viewDidLoad() {
        super.viewDidLoad()

        addPhotos()

    }
    
    func addPhotos() {
        let photoArray = ["1","2","3","4","5","6"]
        let locationArray = ["Houston","Austin","San Antonio","Dallas","Texas","New York"]

        for i in photoArray {
            
          let photo = Photo()
            photo.image = UIImage(named: "\(i).png")
            photo.caption = i
            photo.location = locationArray[Int(i)! - 1]
            
            photos.append(photo)
            
            if (traitCollection.forceTouchCapability == .available) {
                registerForPreviewing(with: self, sourceView: self.collectionView!)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    // MARK: - Navigation

       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            let indexpath =  (self.collectionView?.indexPathsForSelectedItems?[0])!
            // indexPath(for: sender as! UICollectionViewCell)
                let selectedPhoto = photos[indexpath.row]
                secondVC.photo = selectedPhoto
                secondVC.photos = photos
                secondVC.index = indexpath.row
            }
        }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
    
        let x = photos[indexPath.row]
               cell.photoImgView.image = x.image
        cell.caption.text = x.location
        return cell
    }
    
    // MARK: UIViewControllerPreviewingDelegate

     func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView?.indexPathForItem(at: location) else {
            return nil
        }
        guard let cell = collectionView?.cellForItem(at: indexPath) else {
            return nil
            }
        guard let viewVC  = storyboard?.instantiateViewController(withIdentifier: "2ndVC") as? SecondViewController  else {
            return nil
        }
        let selectedPhoto = photos[indexPath.row]
        viewVC.photos = photos
        viewVC.index = indexPath.row

        viewVC.photo = selectedPhoto
        viewVC.preferredContentSize = CGSize(width:0.0, height: 300)
        previewingContext.sourceRect = cell.frame
        
        return viewVC
    }
    
        func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
            
            show(viewControllerToCommit, sender: self)
            
        }

}
