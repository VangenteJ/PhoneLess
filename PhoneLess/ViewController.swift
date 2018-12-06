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

//Declaring global variables for use in different view controllers
var steps_taken:String?
var current_level:String?
let day = String("Steps Date")
let timeS = String("Time Date")
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
    override func viewDidLoad() {
        super.viewDidLoad()
        //ViewControllerSTaken().update_Steps()
        ref = Database.database().reference()
        user = ref.child("Users")
        isUser_logged()
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
    
    //Verify if there is any current data into our database as a means to find whether the user is new
    func check_database_for_details(){
        //Checks for steps
        handle = user.child((email?.uid)!).child("Steps Date").observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil {
                let value = snapshot.value as? String
                self.lblSteps_Taken.text = "S: \(value!)"
            }else{
                user.child((email?.uid)!).child("Steps Date").setValue("0")
            }
            
        })
        //checks for total steps
        handle = user.child((email?.uid)!).child("Total Steps").observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil {
            }else{
               user.child((email?.uid)!).child("Total Steps").setValue("0")
            }
            
        })
        //checks for level
        handle = user.child((email?.uid)!).child("Level").observe(.value, with: { (snapshot) in
            if snapshot.value as? NSNumber != nil {
                let value = snapshot.value as? NSNumber
                self.lblLevel.text = "L: \(value!)"
                
            }else{
                user.child((email?.uid)!).child("Level").setValue(0)
                print (snapshot.value!)
            }
        })
        //checks for time spent
        handle = user.child((email?.uid)!).child("Time Date").observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil {
                let value = snapshot.value as? String
                self.lblTime_Spent.text = "T: \(value!)"
            }else{
                user.child((email?.uid)!).child("Time Date").setValue("0")
            }
        })
    }
    
    func isUser_logged(){
        //Check if user is loged
        if Auth.auth().currentUser != nil{
            //Add and/or retrieve data from database
            update_Steps()
            check_database_for_details()
        }else{
            //Redirect users if not logged in
            logRegisterPage()
        }
    }
    //counts the steps
    func stepCounter(){
        pedometer.startUpdates(from: Date()) { (data, error) in
            if error == nil{
                DispatchQueue.main.async {
                    self.current_Steps = data?.numberOfSteps.stringValue
                    self.total_steps = data?.numberOfSteps.stringValue
                    self.level_Steps = data?.numberOfSteps.stringValue
                    //adds steps into database
                    user.child((email?.uid)!).child("Steps Date").setValue(self.current_Steps!)
                    user.child((email?.uid)!).child("Total Steps").setValue(self.total_steps)
                    
                }
            }else{
                return
            }
        }
    }
    
    func update_Steps(){
        //Check for user activity and call step counting function
        if CMPedometer.isStepCountingAvailable(){
            stepCounter()
        }
        
    }
}

