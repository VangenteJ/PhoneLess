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
            }
            print(value)
            
        })
        
        handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
            timeSP = snapshot.value as! String
            if timeSP != ""{
                self.lblTotalSteps.text = "Total steps: \(timeSP)"
            }
        })
        handle = user.child((email?.uid)!).child("Level").observe(.value, with: { (snapshot) in
            if snapshot.value != nil {
                self.lblLevel.text = snapshot.value as? String
            }else {
                user.child((email?.uid)!).child("Level").setValue("1")
            }
        })
        current_level = self.lblLevel.text!
    }
    
    func steps_control(){
        var steps_for_level:String?
        var user_level:String?
        handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
            steps_for_level = snapshot.value as? String
            print ("jghfgdfsg\(steps_for_level!)")
            self.handle = user.child((email?.uid)!).child("Level").observe(.value, with: { (snapshot) in
                user_level = snapshot.value as? String
                print ("hawsssdg \(user_level!)")
                switch Int(user_level!)! {
                case 1:
                    let level = 100
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: level, b: Int(steps_for_level!)!)))
                    self.level_up(check_level: Int(self.stepsTo_next_Level.text!)!)
                    print (self.stepsTo_next_Level!)
                    print ("Herea\(Int(self.stepsTo_next_Level.text!)!)")
                    print ("What the dooss")
//                case 2:
//                    let level = 9000
//                    self.level_Up(next_level_Steps: level)
//                case 3:
//                    let level = 15000
//                    self.level_Up(next_level_Steps: level)
//                case 4:
//                    let level = 21000
//                    self.level_Up(next_level_Steps: level)
//                case 5:
//                    let level = 27000
//                    self.level_Up(next_level_Steps: level)
//                case 6:
//                    let level = 33000
//                    self.level_Up(next_level_Steps: level)
//                case 7:
//                    let level = 39000
//                    self.level_Up(next_level_Steps: level)
//                case 8:
//                    let level = 45000
//                    self.level_Up(next_level_Steps: level)
//                case 9:
//                    let level = 51000
//                    self.level_Up(next_level_Steps: level)
//                case 10:
//                    let level = 63000
//                    self.level_Up(next_level_Steps: level)
//                case 11:
//                    let level = 75000
//                    self.level_Up(next_level_Steps: level)
//                case 12:
//                    let level = 87000
//                    self.level_Up(next_level_Steps: level)
//                case 13:
//                    let level = 99000
//                    self.level_Up(next_level_Steps: level)
//                case 14:
//                    let level = 111000
//                    self.level_Up(next_level_Steps: level)
//                case 15:
//                    let level = 123000
//                    self.level_Up(next_level_Steps: level)
//                case 16:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 17:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 18:
//                    let level = 135000
//                   self.level_Up(next_level_Steps: level)
//                case 19:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 20:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 21:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 22:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 23:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 24:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 25:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 26:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 27:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 28:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 29:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 30:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 31:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
//                case 32:
//                    let level = 135000
//                    self.level_Up(next_level_Steps: level)
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
    
    func level_up(check_level:Int){
        if check_level == 0{
            let level = check_level + 1
            //user.child((email?.uid)!).child("Level").setValue(level)
        }
    }

}
