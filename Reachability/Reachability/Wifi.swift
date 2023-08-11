//
//  Wifi.swift
//  Reachability
//
//  Created by NSR on 2023-08-11.
//  Copyright © 2023 Dabus.tv. All rights reserved.
//

import Foundation
import Foundation
import UIKit



class Wifi: UIViewController{
    override func viewDidLoad() {
        Wifi ()
    }
    func Wifi (){
         let background = UIImage (named: "wifi")
 
               var imageView : UIImageView!
               imageView = UIImageView(frame: view.bounds)
            imageView.contentMode =  UIView.ContentMode.scaleAspectFill
               imageView.clipsToBounds = true
               imageView.image = background
               imageView.center = view.center
               view.addSubview(imageView)
               self.view.sendSubviewToBack(imageView)
    }
}
