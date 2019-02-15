//
//  ResetPasswordViewController.swift
//  PhoneLess
//
//  Created by Joel Vangente on 14/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var lblreset_pass: UILabel!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblreset_pass.textColor = UIColor.black

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reset_password(_ sender: Any) {
        if let email = txtemail.text {
            if email != ""{
                Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                }
                lblreset_pass.textColor = UIColor.green
                lblreset_pass.text = "You will receive an email if your detail is correct."
                txtemail.isHidden = true
                btnReset.isHidden = true
                btnCancel.setTitle("Back", for: .normal)
            }else{
                lblreset_pass.text = "Please enter email."
                lblreset_pass.textColor = UIColor.red
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        let goTo_Main = self.storyboard?.instantiateViewController(withIdentifier: "viewLReg") as! ViewControllerLogReg
        self.present(goTo_Main, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if checknet.connection(){}else{
            let noNet = self.storyboard?.instantiateViewController(withIdentifier: "connection") as! ConnectionViewController
            self.present(noNet , animated: true, completion: nil)
        }
    }
    
}
