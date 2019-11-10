//
//  StateSelectionsViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 9/6/18.
//  Copyright © 2018 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
class StateSelectionsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "Ohio") == true{
            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "OhioChapters") as! OhioChaptersViewController
            self.navigationController?.pushViewController(homeVc, animated: false)
        }
        if UserDefaults.standard.bool(forKey: "Indiana") == true{
            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "IndianaChapter") as! IndianaChaptersViewController
            self.navigationController?.pushViewController(homeVc, animated: false)
        }
        if UserDefaults.standard.bool(forKey: "PhillyChapter") == true{
            let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Philly") as! PhiladelphiaChapterViewController
            self.navigationController?.pushViewController(homeVc, animated: false)

        }

    }

    @IBAction func OHIO(_ sender: Any) {
        ClickSound()
        UserDefaults.standard.set(true, forKey: "Ohio")
        let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "OhioChapters") as! OhioChaptersViewController
        self.navigationController?.pushViewController(homeVc, animated: false)
    }
    
    @IBAction func INDIANA(_ sender: Any) {
        ClickSound()
        UserDefaults.standard.set(true, forKey: "Indiana")
        let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "IndianaChapter") as! IndianaChaptersViewController
        self.navigationController?.pushViewController(homeVc, animated: false)
    }
    @IBAction func Philly(_ sender: Any) {
        ClickSound()
        UserDefaults.standard.set(true, forKey: "PhillyChapter")
        let homeVc = self.storyboard?.instantiateViewController(withIdentifier: "Philly") as! PhiladelphiaChapterViewController
        self.navigationController?.pushViewController(homeVc, animated: false)
    }
}
