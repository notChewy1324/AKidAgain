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
        let path = Bundle.main.path(forResource: "IntroVanishSounds.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)

        do {
            audioPLayer = try AVAudioPlayer(contentsOf: url)
            audioPLayer?.play()
        } catch {
            // couldn't load file :(
        }
        let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Design") as! DesignViewController
        self.navigationController?.pushViewController(homeVc, animated: true)
    }

}
