//
//  ViewControllerChallenges.swift
//  PhoneLess
//
//  Created by Joel Vangente on 28/10/2018.
//  Copyright © 2018 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewControllerChallenges: UIViewController {

    @IBOutlet weak var lblTotalSteps: UILabel!
    
    @IBOutlet weak var lbl_easy5k: UILabel!
    @IBOutlet weak var lbl_easy10k: UILabel!
    @IBOutlet weak var lbl_easy20k: UILabel!
    @IBOutlet weak var lbl_easy40k: UILabel!
    
    @IBOutlet weak var lbl_Normal70k: UILabel!
    @IBOutlet weak var lbl_Normal100k: UILabel!
    @IBOutlet weak var lbl_Normal130k: UILabel!
    @IBOutlet weak var lbl_Normal160k: UILabel!
    
    @IBOutlet weak var lbl_Hard200k: UILabel!
    @IBOutlet weak var lbl_Hard240k: UILabel!
    @IBOutlet weak var lbl_Hard280k: UILabel!
    @IBOutlet weak var lbl_Hard320k: UILabel!
    
    @IBOutlet weak var lbl_Legend370k: UILabel!
    @IBOutlet weak var lbl_Legend420k: UILabel!
    @IBOutlet weak var lbl_Legend470k: UILabel!
    @IBOutlet weak var lbl_Legend520k: UILabel!
    
    var ref: DatabaseReference!
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        get_steps_from_db()
    }
    
    func get_steps_from_db(){
        handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
            //Checks for total steps in database
            if let value = snapshot.value as? String{
                if value != ""{
                    self.lblTotalSteps.text = "Total steps: \(value)"
                    
                    let steps_for_k = Int(value)
                    
                    if steps_for_k! >= 5000{
                        self.lbl_easy5k.textColor = UIColor.green
                    }
                    if steps_for_k! >= 10000{
                        self.lbl_easy10k.textColor = UIColor.green
                    }
                    if steps_for_k! >= 20000{
                        self.lbl_easy20k.textColor = UIColor.green
                    }
                    if steps_for_k! >= 40000{
                        self.lbl_easy40k.textColor = UIColor.green
                    }
                    if steps_for_k! >= 70000{
                        self.lbl_Normal70k.textColor = UIColor.blue
                    }
                    if steps_for_k! >= 100000{
                        self.lbl_Normal100k.textColor = UIColor.blue
                    }
                    if steps_for_k! >= 130000{
                        self.lbl_Normal130k.textColor = UIColor.blue
                    }
                    if steps_for_k! >= 160000{
                        self.lbl_Normal160k.textColor = UIColor.blue
                    }
                    if steps_for_k! >= 200000{
                        self.lbl_Hard200k.textColor = UIColor.orange
                    }
                    if steps_for_k! >= 240000{
                        self.lbl_Hard240k.textColor = UIColor.orange
                    }
                    if steps_for_k! >= 280000{
                        self.lbl_Hard280k.textColor = UIColor.orange
                    }
                    if steps_for_k! >= 320000{
                        self.lbl_Hard320k.textColor = UIColor.orange
                    }
                    if steps_for_k! >= 370000{
                        self.lbl_Legend370k.textColor = UIColor.red
                    }
                    if steps_for_k! >= 420000{
                        self.lbl_Legend420k.textColor = UIColor.red
                    }
                    if steps_for_k! >= 470000{
                        self.lbl_Legend470k.textColor = UIColor.red
                    }
                    if steps_for_k! >= 520000{
                        self.lbl_Legend520k.textColor = UIColor.red
                    }
                }
            }
        })
    }
}
