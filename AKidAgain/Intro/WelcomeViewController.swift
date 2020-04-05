//
//  WelcomeViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 5/29/19.
//  Copyright © 2019 Chewy1324. All rights reserved.
//

import UIKit
import AVFoundation
class WelcomeViewController: UIViewController {

    var audioPLayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func button(_ sender: Any) {
        ClickSound()
        let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Design") as! DesignViewController
        self.navigationController?.pushViewController(homeVc, animated: false)
    }

}
