//
//  ViewControllerTSpent.swift
//  PhoneLess
//
//  Created by Joel Vangente on 28/10/2018.
//  Copyright © 2018 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewControllerTSpent: UIViewController {
    
    @IBOutlet weak var lbl_easy_quote1: UILabel!
    @IBOutlet weak var lbl_easy_quote2: UILabel!
    @IBOutlet weak var lbl_easy_quote3: UILabel!
    @IBOutlet weak var lbl_easy_quote4: UILabel!
    
    @IBOutlet weak var lbl_normal_quote1: UILabel!
    @IBOutlet weak var lbl_normal_quote2: UILabel!
    @IBOutlet weak var lbl_normal_quote3: UILabel!
    @IBOutlet weak var lbl_normal_quote4: UILabel!
    
    @IBOutlet weak var lbl_hard_quote1: UILabel!
    @IBOutlet weak var lbl_hard_quote2: UILabel!
    @IBOutlet weak var lbl_hard_quote3: UILabel!
    @IBOutlet weak var lbl_hard_quote4: UILabel!
    
    @IBOutlet weak var lbl_legendary_quote1: UILabel!
    @IBOutlet weak var lbl_legendary_quote2: UILabel!
    @IBOutlet weak var lbl_legendary_quote3: UILabel!
    @IBOutlet weak var lbl_legendary_quote4: UILabel!
    
    var ref: DatabaseReference!
    var handle:DatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
    }

    func get_steps_from_db(){
        handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
            //Checks for total steps in database
            if let value = snapshot.value as? String{
                if value != ""{
                    let steps_for_k = Int(value)
                    
                    if steps_for_k! >= 5000{
                    }
                    if steps_for_k! >= 10000{
                    }
                    if steps_for_k! >= 20000{
                    }
                    if steps_for_k! >= 40000{
                    }
                    if steps_for_k! >= 70000{
                    }
                    if steps_for_k! >= 100000{
                    }
                    if steps_for_k! >= 130000{
                    }
                    if steps_for_k! >= 160000{
                    }
                    if steps_for_k! >= 200000{
                    }
                    if steps_for_k! >= 240000{
                    }
                    if steps_for_k! >= 280000{
                    }
                    if steps_for_k! >= 320000{
                    }
                    if steps_for_k! >= 370000{
                    }
                    if steps_for_k! >= 420000{
                    }
                    if steps_for_k! >= 470000{
                    }
                    if steps_for_k! >= 520000{
                    }
                }
            }
        })
    }
}
