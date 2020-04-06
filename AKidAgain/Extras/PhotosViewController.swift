//
//  PhotosViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 6/30/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

    @IBOutlet weak var titleText: UINavigationItem!
    @IBOutlet weak var Photos: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://akidagain.smugmug.com/")
        Photos.loadRequest(URLRequest(url: url!))
    }
    
    @IBAction func doSomething(_ sender: AnyObject) {
        Photos.reload()
    }
    
}
