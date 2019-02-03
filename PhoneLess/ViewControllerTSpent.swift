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
        get_steps_from_db()
    }

    func get_steps_from_db(){
        handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
            //Checks for total steps in database
            if let value = snapshot.value as? String{
                if value != ""{
                    let steps_for_k = Int(value)
                    
                    if steps_for_k! >= 5000{
                        self.lbl_easy_quote1.textColor = UIColor.green
                        self.lbl_easy_quote1.text = "Q: It is easy to spend our time away doing nothing, just as it is easy to end up being nothing in life."
                    }
                    if steps_for_k! >= 10000{
                        self.lbl_easy_quote2.textColor = UIColor.green
                        self.lbl_easy_quote2.text = "Q: Time can be our ally if used in a way that positively impact our lives or our worst enemies if we just let it roll by."
                    }
                    if steps_for_k! >= 20000{
                        self.lbl_easy_quote3.textColor = UIColor.green
                        self.lbl_easy_quote3.text = "Q: Was it worth using your device as often as you did? Have you learnt anything new? "
                    }
                    if steps_for_k! >= 40000{
                        self.lbl_easy_quote4.textColor = UIColor.green
                        self.lbl_easy_quote4.text = "Q: You can master a skill by learning it for only 20 hours, or would you rather spend such precious time using your device?"
                    }
                    if steps_for_k! >= 70000{
                        self.lbl_normal_quote1.textColor = UIColor.blue
                        self.lbl_normal_quote1.text = "Q: Are you happy with yourself right now? If no, your device could be taking your happiness away from you."
                    }
                    if steps_for_k! >= 100000{
                        self.lbl_normal_quote2.textColor = UIColor.blue
                        self.lbl_normal_quote2.text = "Q: Time spent will never return, you will never have the time you spent doing mindless activity to do something more useful."
                    }
                    if steps_for_k! >= 130000{
                        self.lbl_normal_quote3.textColor = UIColor.blue
                        self.lbl_normal_quote3.text = "Q: We are often busy trying to live day by day but you will be surprised to find out the vast amount of time you have if you put down your device more often."
                    }
                    if steps_for_k! >= 160000{
                        self.lbl_normal_quote4.textColor = UIColor.blue
                        self.lbl_normal_quote4.text = "Q: People usually wish to be comfortable in life but most do not even try it as they would rather waste their time with activities and actions that do not bring fulfilment, nor help self development."
                    }
                    if steps_for_k! >= 200000{
                        self.lbl_hard_quote1.textColor = UIColor.orange
                        self.lbl_hard_quote1.text = "Q: By wishing, nothing happens. By waiting, nothing happens. By expecting, nothing happens. It is only by doing that something can actually happen."
                    }
                    if steps_for_k! >= 240000{
                        self.lbl_hard_quote2.textColor = UIColor.orange
                        self.lbl_hard_quote2.text = "Q: When I was 17 I wished I was a wealth individual but I just sat down and did nothing, years have passed and I felt exactly the same until when I decided to do something."
                    }
                    if steps_for_k! >= 280000{
                        self.lbl_hard_quote3.textColor = UIColor.orange
                        self.lbl_hard_quote3.text = "Q: Consistency is a very powerful tool, if you consistently do something over and over again, even for a little bit at a time, you will eventually end up with plenty of work dedicated to this something you did consistently."
                    }
                    if steps_for_k! >= 320000{
                        self.lbl_hard_quote4.textColor = UIColor.orange
                        self.lbl_hard_quote4.text = "Q: Life is fun but miserable when you do not do anything with it."
                    }
                    if steps_for_k! >= 370000{
                        self.lbl_legendary_quote1.textColor = UIColor.red
                        self.lbl_legendary_quote1.text = "Q: Within the last five months, how many hours have you spent using your device? How many skills could have you mastered if you dedicated 20 hours in mastering each skills instead?"
                    }
                    if steps_for_k! >= 420000{
                        self.lbl_legendary_quote2.textColor = UIColor.red
                        self.lbl_legendary_quote2.text = "Q: It takes a little less than 2000 hours of studying to complete a university degree or a lot less if you are quick learner."
                    }
                    if steps_for_k! >= 470000{
                        self.lbl_legendary_quote3.textColor = UIColor.red
                        self.lbl_legendary_quote3.text = "Q: What is the point of living if you cannot enjoy life? If you let the time roll, you will find yourself in a position unable to afford the things you want and out of time to enjoy the little time you will have after retirement."
                    }
                    if steps_for_k! >= 520000{
                        self.lbl_legendary_quote4.textColor = UIColor.red
                        self.lbl_legendary_quote4.text = "Q: We all know exactly what we need to do in order to get to where we want but the discomfort of doing it is what keeps us at bay."
                    }
                }
            }
        })
    }
}
