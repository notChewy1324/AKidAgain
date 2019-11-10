//
//  GetStartedViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 5/29/19.
//  Copyright © 2019 Chewy1324. All rights reserved.
//

import UIKit
class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "NoMoreIntro")
        UserDefaults.standard.set(false, forKey: "Intro_App")
    }
    
    @IBAction func button(_ sender: Any) {
        ClickSound()
        let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        self.navigationController?.pushViewController(homeVc, animated: false)
    }

}
