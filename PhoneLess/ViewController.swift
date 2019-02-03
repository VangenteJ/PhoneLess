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
import CoreData
import FirebaseStorage

//Declaring global variables for use in different view controllers
var steps_taken:String?
var current_level:String?
let day = String("Steps Date")
let timeS = String("Time Date")
let email = Auth.auth().currentUser
var user:DatabaseReference!



class ViewController: UIViewController {
    
    @IBOutlet weak var uiimage: UIImageView!
    
    @IBOutlet weak var lblTime_Spent: UILabel!
    @IBOutlet weak var lblSteps_Taken: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    
    @IBOutlet weak var lbl_personal_quote: UILabel!
    
    var current_Steps:String?
    var total_steps:String?
    
    
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
        let format = DateFormatter()
        // initially set the format based on datepicker date / server String
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let StepString = format.string(from: Date()) // string purpose I add here
        // convert string to date
        let S_Date = format.date(from: StepString)
        //then again set the date format whhich type of output needed
        format.dateFormat = "dd-MM-yyyy"
        // again convert date to string
        let StepDate = format.string(from: S_Date!)
        
        //Checks for steps
        handle = user.child((email?.uid)!).child(StepDate).observe(.value, with: { (snapshot) in
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
        
        //Checks for personal quotes
        handle = user.child((email?.uid)!).child("Own Quote").observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil {
                let o_quote = snapshot.value as? String
                self.lbl_personal_quote.text = o_quote
            }else{
                self.lbl_personal_quote.text = "To walk, is a privilege but to keep healthy is a choice!"
            }
        })
    }
    
    func isUser_logged(){
        //Check if user is loged
        if Auth.auth().currentUser != nil{
            //Add and/or retrieve data from database
            update_Steps()
            check_database_for_details()
            save_day_to_db()
            add_steps_to_db()
            chechImages()
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
                    
                    user.child((email?.uid)!).child("Temporary Steps").setValue(self.current_Steps)
                    
                    UserDefaults.standard.set(self.current_Steps, forKey: "Current steps")
                }
            }else{return}
        }
    }
    
    func update_Steps(){
        //Check for user activity and call step counting function
        if CMPedometer.isStepCountingAvailable(){
            stepCounter()
        }
        
    }
    
    func save_day_to_db(){
        
        let formatter = DateFormatter()
        // initially set the format based on datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert string to date
        let myDate = formatter.date(from: myString)
        //then again set the date format whhich type of output needed
        formatter.dateFormat = "dd"
        // again convert date to string
        let myStringafd = formatter.string(from: myDate!)
        
        user.child((email?.uid)!).child("Day").setValue(myStringafd)
    }
    
    func add_steps_to_db(){
        let format = DateFormatter()
        // initially set the format based on datepicker date / server String
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let StepString = format.string(from: Date()) // string purpose I add here
        // convert string to date
        let S_Date = format.date(from: StepString)
        //then again set the date format whhich type of output needed
        format.dateFormat = "dd-MM-yyyy"
        // again convert date to string
        let StepDate = format.string(from: S_Date!)
        
        handle = user.child((email?.uid)!).child("Day").observe(.value, with: { (snapshot) in
            
            if let value = snapshot.value as? String{
                if value != ""{
                    self.handle = user.child((email?.uid)!).child("Yesterday").observe(.value, with: { (snapshot) in
                        let yesterday = snapshot.value as? String
                        if yesterday != nil{
                            if value != yesterday{
                                self.handle = user.child((email?.uid)!).child("Temporary Steps").observe(.value, with: { (snapshot) in
                                    let temp_steps = snapshot.value as? String
                                    
                                    if temp_steps != nil{
                                        let actual_steps = Int(temp_steps!)! - Int(temp_steps!)!
                                        let totalSteps = Int(temp_steps!)! + Int(temp_steps!)!
                                        
                                        user.child((email?.uid)!).child(StepDate).setValue(actual_steps)
                                        user.child((email?.uid)!).child("Total Steps").setValue(totalSteps)
                                    }
                                })
                        }else{
                            self.handle = user.child((email?.uid)!).child("Temporary Steps").observe(.value, with: { (snapshot) in
                                let temp_steps = snapshot.value as? String
                                
                                if temp_steps != nil{
                                    
                                    user.child((email?.uid)!).child(StepDate).setValue(temp_steps)
                                    user.child((email?.uid)!).child("Total Steps").setValue(temp_steps)
                                }
                            })
                        }
                    }
                    })
                   user.child((email?.uid)!).child("Yesterday").setValue(value)
                }
            }
        })
    }
    
    func chechImages(){
        let imagepath = email?.uid
        print (imagepath! + "/Images/Number1")
        let image1 = Storage.storage().reference(withPath: imagepath! + "/Images/Number1")
        
        image1.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if error != nil {
                // Add logo image if no image found
                self.uiimage.image = UIImage(named: "Logo")
            } else {
                // Data for "images"
                self.uiimage.image = UIImage(data: data!)
                
            }
        }
    }
}

