//
//  ViewControllerSTaken.swift
//  PhoneLess
//
//  Created by Joel Vangente on 28/10/2018.
//  Copyright © 2018 Joel Vangente. All rights reserved.
//

import UIKit

import Firebase
import FirebaseDatabase
import FirebaseAuth

class ViewControllerSTaken: UIViewController {

    @IBOutlet weak var segment_Display_Day_Week_Month_Years: UISegmentedControl!
    @IBOutlet weak var lblDisplay_Steps_On_Days_week_month_years: UILabel!
    @IBOutlet weak var lblCurrentSteps: UILabel!
    @IBOutlet weak var stepsTo_next_Level: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblTotalSteps: UILabel!
    var level_Step:String?
    var ref: DatabaseReference!
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        user = ref.child("Users")
        addFrom_Database_To_Main_Menu()
        steps_control()

    }
    
    func addFrom_Database_To_Main_Menu(){
        var value = ""
        var timeSP = ""
        handle = user.child((email?.uid)!).child(day).child("Current Steps").observe(.value, with: { (snapshot) in
            print(snapshot.value!)
            value = snapshot.value as! String
            if value != ""{
                self.lblCurrentSteps.text = "\(value) Steps"
                self.lblDisplay_Steps_On_Days_week_month_years.text = "\(value) Steps"
            }
            
        })
        
        handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
            timeSP = snapshot.value as! String
            if timeSP != ""{
                self.lblTotalSteps.text = "Total steps: \(timeSP)"
            }
        })
        handle = user.child((email?.uid)!).child("Level").observe(.value, with: { (snapshot) in
            print ("ECANHENGUE \(String(describing: snapshot.value))")
            if snapshot.value != nil {
                let level_Checker = snapshot.value as! NSNumber
                self.lblLevel.text = "Your actual level is: \(String(describing: level_Checker))"
                print (self.lblLevel.text!)
            }else {
                user.child((email?.uid)!).child("Level").setValue(1)
            }
        })
        current_level = self.lblLevel.text!
    }
    
    func steps_control(){
        var steps_for_level:String?
        //var user_level:String?
        handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
            steps_for_level = snapshot.value as? String
            
            self.handle = user.child((email?.uid)!).child("Level").observe(.value, with: { (snapshot) in
                let user_level = snapshot.value as! NSNumber
                
                switch user_level {
                case 1:
                    print ("Start of case 1")
                    
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
//                    let level_value = Int(self.stepsTo_next_Level.text!)!
//                    if level_value <= 0{
//                        print ("Loop 1")
//                        user.child((email?.uid)!).child("Level").setValue(Int(truncating: user_level) + 1)
//
//                    }
                case 2:
                    print ("Start of case 2")
                    
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 3:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 4:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 5:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 6:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 7:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 8:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 9:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 10:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 11:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 12:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 13:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 14:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 15:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 16:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 17:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 18:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 19:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 20:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 21:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 22:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 23:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 24:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 25:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 26:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 27:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 28:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 29:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 30:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 31:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                case 32:
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                default:
                    print ("a")
                }
                
            })
        })
    }
    
    func update_Control(){
        
    }
    
    func calcLevel(a :Int, b :Int) -> Int{
        let sum = a - b
        return sum
    }
    
    func level_up(level_value:Int, case_value:Int){
        if level_value <= 0{
            print ("Loop 2")
            user.child((email?.uid)!).child("Level").setValue(case_value + 1)
        }
    }
    
    func different_levels(level_Now:Int) -> Int{
        let level_increase = 2500
        let updated_level = level_Now * level_increase
        return updated_level
    }

}
