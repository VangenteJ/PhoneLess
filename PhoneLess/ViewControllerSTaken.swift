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

    @IBOutlet weak var lblDisplay_Steps_On_Days_week_month_years: UILabel!
    @IBOutlet weak var lblCurrentSteps: UILabel!
    @IBOutlet weak var stepsTo_next_Level: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblTotalSteps: UILabel!
    
    @IBOutlet weak var txtDate_to_search: UITextField!
    
    var level_Step:String?
    var ref: DatabaseReference!
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        user = ref.child("Users")
        addFrom_Database()
        steps_control()

    }
    
    
    @IBAction func search_for_steps_by_date(_ sender: Any) {
        self.lblDisplay_Steps_On_Days_week_month_years.textColor = UIColor.black
        if txtDate_to_search.text != ""{
            let user_input = txtDate_to_search.text
            handle = user.child((email?.uid)!).child(user_input!).observe(.value, with: { (snapshot) in
                //Checks for steps in database
                let value = snapshot.value as? String
                if value != nil{
                    self.lblDisplay_Steps_On_Days_week_month_years.isHidden = false
                    self.lblDisplay_Steps_On_Days_week_month_years.text = "\(value!) Steps"
                    self.txtDate_to_search.text = ""
                }else {
                    self.lblDisplay_Steps_On_Days_week_month_years.isHidden = false
                    self.lblDisplay_Steps_On_Days_week_month_years.textColor = UIColor.red
                    self.lblDisplay_Steps_On_Days_week_month_years.text = "Please make sure you are adding a correct date by the format dd-mm-yyyy, make sure it is a date when you used the app."
                    self.txtDate_to_search.text = ""
                }
            })
        }
        
        
    }
    
    //Add data from database into Steps Taken page
    func addFrom_Database(){
        
        let formatter = DateFormatter()
        // initially set the format based on datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert string to date
        let myDate = formatter.date(from: myString)
        //then again set the date format whhich type of output needed
        formatter.dateFormat = "dd-MM-yyyy"
        // again convert date to string
        let myStringafd = formatter.string(from: myDate!)
        
        handle = user.child((email?.uid)!).child(myStringafd).observe(.value, with: { (snapshot) in
            //Checks for steps in database
            let value = snapshot.value as? String
            if value != nil{
                self.lblCurrentSteps.text = "\(value!) Steps"
            }else{
                self.lblCurrentSteps.text = "0"
            }
            
        })
        
        handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
            //Checks for total steps in database
            if let value = snapshot.value as? String{
            if value != ""{
                self.lblTotalSteps.text = "Total steps: \(value)"
            }
            }
        })
        handle = user.child((email?.uid)!).child("Level").observe(.value, with: { (snapshot) in
            //checks for level in database
            if snapshot.value != nil {
                if let level_Checker = snapshot.value as? NSNumber{
                self.lblLevel.text = "Your actual level is: \(String(describing: level_Checker))"
                }
            }else {
                //Assign level 0 if no level found within database
                user.child((email?.uid)!).child("Level").setValue(0)
            }
        })
        //Assign level to a global variable
        current_level = self.lblLevel.text!
    }
    
    //Control steps leveling calculations
    func steps_control(){
        var steps_for_level:String?
        //Gets step data from database
        handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
            steps_for_level = snapshot.value as? String
            //Gets level data from database
            self.handle = user.child((email?.uid)!).child("Level").observe(.value, with: { (snapshot) in
                if let user_level = snapshot.value as? NSNumber{
                //Switch case to add different actions through different levels
                switch user_level {
                case 0:
                    //Call calcLevel and different_levels and pass in parameters for calculation
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    //Call level_up function and give parameters
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                    
                case 1:
                    
                    self.stepsTo_next_Level.text = String(describing:(self.calcLevel(a: self.different_levels(level_Now: Int(truncating: user_level)), b: Int(steps_for_level!)!)))
                    
                    
                    self.level_up(level_value: Int(self.stepsTo_next_Level.text!)!, case_value: Int(truncating: user_level))
                    
                case 2:
                    
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
                    //Prints error if switch case fails to operate properly
                    print ("Error")
                }
                }
            })
        })
    }
    
    //Calculates the difference of two given paremeters
    func calcLevel(a :Int, b :Int) -> Int{
        let sum = a - b
        return sum
    }
    
    //Receives two paremeters to carry out level up process
    func level_up(level_value:Int, case_value:Int){
        if level_value <= 0{
            print ("Loop 2")
            user.child((email?.uid)!).child("Level").setValue(case_value + 1)
        }
    }
    
    //Receives single parameter and times it by 10
    func different_levels(level_Now:Int) -> Int{
        let level_increase = 10
        let updated_level = level_Now * level_increase
        return updated_level
    }
}
