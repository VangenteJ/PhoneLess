//
//  ViewController.swift
//  PhoneLess
//
//  Created by Joel Vangente on 27/10/2018.
//  Copyright © 2018 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import CoreMotion

var day1 = 1
var steps_taken:String?
var current_level:String?
let day = String("StepsDay: \(day1)")
let timeS = String("TimeDay: \(day1)")
let email = Auth.auth().currentUser
var user:DatabaseReference!



class ViewController: UIViewController {
    
    @IBOutlet weak var lblTime_Spent: UILabel!
    @IBOutlet weak var lblSteps_Taken: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    
    var current_Steps:String?
    var total_steps:String?
    var level_Steps:String?
    
    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    

    let activity_Manager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
//Add database reference
//Add info into database
    override func viewDidLoad() {
        super.viewDidLoad()
        //ViewControllerSTaken().update_Steps()
        ref = Database.database().reference()
        user = ref.child("Users")
        isUser_logged()
        update_Steps()
        display_Step_Level_Time_spent()
        
    }
    
    //Log the user out of the app.
    @IBAction func signOut(_ sender: Any) {
        if Auth.auth().currentUser != nil{
            try? Auth.auth().signOut()
            logRegisterPage()
        }
    }
    
    //Open sign in/Register page
    func logRegisterPage(){
        let backLReg = self.storyboard?.instantiateViewController(withIdentifier: "viewLReg") as! ViewControllerLogReg
        self.present(backLReg, animated: true, completion: nil)
    }
    
    func addFrom_Database_To_Main_Menu(){
        var value = ""
        var timeSP = ""
        handle = user.child((email?.uid)!).child(day).observe(.value, with: { (snapshot) in
            print(snapshot)
            value = snapshot.value as! String
            if value != ""{
                self.lblSteps_Taken.text = "\(value) Steps"
            }
            print(value)
            
        })
        
        handle = user.child((email?.uid)!).child(timeS).observe(.value, with: { (snapshot) in
            timeSP = snapshot.value as! String
            if timeSP != ""{
                self.lblTime_Spent.text = "\(timeSP) Minutes"
            }
        })
    }
    
    func display_Step_Level_Time_spent(){
        if steps_taken != nil{
            self.lblSteps_Taken.text = steps_taken
        }
        if current_level != nil{
            self.lblLevel.text = current_level
        }
        if time_spent != nil{
            self.lblTime_Spent.text = time_spent
        }
    }
    
    func isUser_logged(){
        //Check if user is loged in and redirect if not logged in
        if Auth.auth().currentUser != nil{
            
        }else{
            logRegisterPage()
        }
    }
    func stepCounter(){
        pedometer.startUpdates(from: Date()) { (data, error) in
            if error == nil{
                DispatchQueue.main.async {
                    self.current_Steps = data?.numberOfSteps.stringValue
                    self.total_steps = data?.numberOfSteps.stringValue
                    self.level_Steps = data?.numberOfSteps.stringValue
                    user.child((email?.uid)!).child(day).child("Current Steps").setValue(self.current_Steps!)
                    user.child((email?.uid)!).child("Total Steps").setValue(self.total_steps)
                    print ("Here top \(Int(self.current_Steps!)!)")
                    
                }
            }else{
                return
            }
        }
    }
    
    func update_Steps(){
        if CMPedometer.isStepCountingAvailable(){
            stepCounter()
        }
        
    }
}

