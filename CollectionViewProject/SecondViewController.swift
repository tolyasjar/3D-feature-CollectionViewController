//
//  ViewController.swift
//  CollectionViewProject
//
//  Created by Toleen Jaradat on 3/6/17.
//  Copyright © 2017 Toleen Jaradat. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var fullImgView: UIImageView!
    
    var index = Int()
    var photos = [Photo]()
    var photo = Photo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fullImgView.image = photo.image
        self.title = photo.location
    }

    @IBAction func forward(_ sender: Any) {
        changeImage(direction: "forward")
    }
    
    @IBAction func backWard(_ sender: Any) {
        changeImage(direction: "backward")
    }
    
    func changeImage (direction:String) {
        
        if (direction == "forward") {
            if (index == photos.count - 1) {
                index = 0
            } else {
                self.index += 1
                }
        } else  {  if (index == 0) {
                    index = photos.count - 1
                } else {
                self.index -= 1
                }
        }
        
        self.photo = photos[index]
        self.fullImgView.image = photo.image
        self.title = photo.location

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

