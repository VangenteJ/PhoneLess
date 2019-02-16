//
//  ConnectionViewController.swift
//  PhoneLess
//
//  Created by Joel Vangente on 14/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit

class ConnectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func try_connect(_ sender: Any) {
        if checknet.connection(){
            let back_to_main = self.storyboard?.instantiateViewController(withIdentifier: "viewLReg") as! ViewControllerLogReg
            self.present(back_to_main, animated: true, completion: nil)
        }
            
        else{
            
            let noNet = self.storyboard?.instantiateViewController(withIdentifier: "connection") as! ConnectionViewController
            self.present(noNet , animated: true, completion: nil)
            
        }
    }
    

}
