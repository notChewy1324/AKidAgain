//
//  ResetPasswordViewController.swift
//  A Kid Again
//
//  Created by Chewy1324 on 5/11/19.
//  Copyright © 2019 Chewy1324. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCrashlytics
class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailbox: UITextField!
    @IBOutlet weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func button(_ sender: Any) {
        ClickSound()
        if let email = self.emailbox.text {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error != nil {
                    //error -- did not send email
                    self.display.text = "Error sending email to '\(email)'. Make sure it is a valid email address."

                } else {
                    //sent email
                    self.display.text = "The reset password email was succesfuly sent to '\(email)'. Make sure to check your inbox."
                }
            }
        }
    }
    
    @IBAction func Sound(_ sender: Any) {
        ClickSound()
    }
}
