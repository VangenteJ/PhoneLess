//
//  ViewControllerSTaken.swift
//  PhoneLess
//
//  Created by Joel Vangente on 28/10/2018.
//  Copyright © 2018 Joel Vangente. All rights reserved.
//

import UIKit
import CoreMotion
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
    
    let activity_Manager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        user = ref.child("Users")
        update_Steps()
        addToDatabase()
        check_steps()
        current_level = self.lblLevel.text!
        fetch_Step_From_Database()

    }
    
    func stepCounter(){
        pedometer.startUpdates(from: Date()) { (data, error) in
            if error == nil{
                DispatchQueue.main.async {
                    self.lblCurrentSteps.text = data?.numberOfSteps.stringValue
                    self.lblTotalSteps.text = data?.numberOfSteps.stringValue
                    self.level_Step = data?.numberOfSteps.stringValue
                    user.child((email?.uid)!).child(day).child("Current Steps").setValue(self.lblCurrentSteps.text)
                    user.child((email?.uid)!).child("Total Steps").setValue(self.lblTotalSteps.text)
                    print ("Here top \(self.lblCurrentSteps.text!)")
                }
            }else{
                return
            }
        }
    }
    
    func check_steps(){
        if self.lblCurrentSteps.text != ""{
            steps_taken = self.lblCurrentSteps.text!
        }
    }
    
    func update_Steps(){
        if CMPedometer.isStepCountingAvailable(){
            stepCounter()
        }
        
    }
    
    func addToDatabase(){
        
    }
    
    func level_Control(){
        if self.level_Step != nil {
            switch Int(self.lblLevel.text!) {
            case 1:
                let level = 3000
                level_Up(next_level_Steps: level)
            case 2:
                let level = 9000
                level_Up(next_level_Steps: level)
            case 3:
                let level = 15000
                level_Up(next_level_Steps: level)
            case 4:
                let level = 21000
                level_Up(next_level_Steps: level)
            case 5:
                let level = 27000
                level_Up(next_level_Steps: level)
            case 6:
                let level = 33000
                level_Up(next_level_Steps: level)
            case 7:
                let level = 39000
                level_Up(next_level_Steps: level)
            case 8:
                let level = 45000
                level_Up(next_level_Steps: level)
            case 9:
                let level = 51000
                level_Up(next_level_Steps: level)
            case 10:
                let level = 63000
                level_Up(next_level_Steps: level)
            case 11:
                let level = 75000
                level_Up(next_level_Steps: level)
            case 12:
                let level = 87000
                level_Up(next_level_Steps: level)
            case 13:
                let level = 99000
                level_Up(next_level_Steps: level)
            case 14:
                let level = 111000
                level_Up(next_level_Steps: level)
            case 15:
                let level = 123000
                level_Up(next_level_Steps: level)
            case 16:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 17:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 18:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 19:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 20:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 21:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 22:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 23:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 24:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 25:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 26:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 27:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 28:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 29:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 30:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 31:
                let level = 135000
                level_Up(next_level_Steps: level)
            case 32:
                let level = 135000
                level_Up(next_level_Steps: level)
            default:
                print ("a")
            }
        }
    }
    
    func calcLevel(a :Int, b :Int) -> Int{
        let sum = a - b
        return sum
    }
    
    func level_Up(next_level_Steps:Int){
        if self.level_Step != nil {
            while Int(self.level_Step!)! < next_level_Steps{
                self.stepsTo_next_Level.text = String(calcLevel(a: next_level_Steps, b: Int(self.level_Step!)!))
            }
            let level = Int(self.lblLevel.text!)! + 1
            self.lblLevel.text = String(level)
        }
    }
    
    func fetch_Step_From_Database(){
        if self.lblTotalSteps.text != "" {
            var temp_Steps:Int?
            handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
                temp_Steps = Int(snapshot.value as! String)!
                
            })
            if temp_Steps! > Int(self.lblTotalSteps.text!)!{
                self.lblTotalSteps.text = String(temp_Steps! + 1)
            }
        }
    }

}
