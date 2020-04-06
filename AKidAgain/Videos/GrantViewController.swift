//
//  GrantViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 5/30/19.
//  Copyright © 2019 Chewy1324. All rights reserved.
//

import UIKit

class GrantViewController: UIViewController {

    @IBOutlet weak var History: UIWebView!
    @IBOutlet weak var titleText: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://www.youtube.com/embed/0VLBtRTi5tg")
        History.loadRequest(URLRequest(url: url!))
    }

    @IBAction func button(_ sender: Any) {
        History.reload()
    }
    
}
