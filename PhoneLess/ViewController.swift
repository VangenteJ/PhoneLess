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
    
    func display_Step_Level_Time_spent(){
        
        handle = user.child((email?.uid)!).child(day).child("Current Steps").observe(.value, with: { (snapshot) in
            if snapshot.value != nil {
                self.lblSteps_Taken.text = "S: \(String(describing: snapshot.value as! String))"
            }
        })
        
        handle = user.child((email?.uid)!).child("Level").observe(.value, with: { (snapshot) in
            self.lblLevel.text = "L: \(String(describing: snapshot.value as! NSNumber))"
        })
        
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
    
    func resources(){
        user.child((email?.uid)!).child(day).child("Current Steps").setValue(self.current_Steps!)
        user.child((email?.uid)!).child("Total Steps").setValue(self.total_steps)
        print ("Here top \(Int(self.current_Steps!)!)")
        
        
        handle = user.child((email?.uid)!).child(day).child("Current Steps").observe(.value, with: { (snapshot) in
            if snapshot.value != nil{
                let main_step = snapshot.value as! String
                
                self.handle = user.child((email?.uid)!).child(day).child("Temp Steps").observe(.value, with: { (snapshot) in
                    if snapshot.value != nil{
                        let temp_step = snapshot.value as? String
                        
                        let actual_steps = Int(Int(main_step)! + Int(temp_step!)!)
                        
                        self.lblSteps_Taken.text = "S: \(String(actual_steps))"
                        
                        user.child((email?.uid)!).child(day).child("Current Steps").setValue(String(actual_steps))
                    }
                })
            }else {
                self.handle = user.child((email?.uid)!).child(day).child("Temp Steps").observe(.value, with: { (snapshot) in
                    if snapshot.value != nil{
                        let temp_step = snapshot.value as? String
                        self.lblSteps_Taken.text = "S: \(String(describing: temp_step))"
                        user.child((email?.uid)!).child(day).child("Current Steps").setValue(temp_step)
                    }
                })
            }
        })
        handle = user.child((email?.uid)!).child(day).child("Total Steps").observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil {
                let main_step = snapshot.value as! String
                
                self.handle = user.child((email?.uid)!).child(day).child("Temp Total Steps").observe(.value, with: { (snapshot) in
                    if snapshot.value != nil {
                        let temp_step = snapshot.value as? String
                        
                        let total_steps = Int(Int(main_step)! + Int(temp_step!)!)
                        
                        user.child((email?.uid)!).child("Total Steps").setValue(String(total_steps))
                    }
                })
            }else {
                self.handle = user.child((email?.uid)!).child(day).child("Temp Total Steps").observe(.value, with: { (snapshot) in
                    if snapshot.value != nil {
                        let temp_step = snapshot.value as? String
                        user.child((email?.uid)!).child("Total Steps").setValue(temp_step)
                    }
                })
            }
        })
        
        
        handle = user.child((email?.uid)!).child("Level").observe(.value, with: { (snapshot) in
            self.lblLevel.text = "L: \(String(describing: snapshot.value as! NSNumber))"
            
        })
    }
}

