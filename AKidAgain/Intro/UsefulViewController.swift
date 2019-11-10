//
//  UsefulViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 5/30/19.
//  Copyright © 2019 Chewy1324. All rights reserved.
//

import UIKit
class UsefulViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func button(_ sender: Any) {
        ClickSound()
        let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "GetStarted") as! GetStartedViewController
        self.navigationController?.pushViewController(homeVc, animated: false)
    }

}
