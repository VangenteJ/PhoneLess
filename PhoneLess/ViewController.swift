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

class ViewController: UIViewController {
    
    @IBOutlet weak var lblTime_Spent: UILabel!
    @IBOutlet weak var lblSteps_Taken: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    
    var day1 = 1

//Add database reference
//Add info into database
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
//Check if user is loged in and redirect if not logged in
        if Auth.auth().currentUser != nil{
            self.addToDatabase()
            self.addFrom_Database_To_Main_Menu()
            print("yoooo")
        }else{
            logRegisterPage()
        }
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
    
    //Structure information to be stored into database.
    func addToDatabase(){
        let day = String("StepsDay: \(day1)")
        let timeS = String("TimeDay: \(day1)")
        let email = Auth.auth().currentUser
        let user = ref.child("Users")
    user.child((email?.uid)!).child(day).setValue("5540")
        user.child((email?.uid)!).child(timeS).setValue("200")
    }
    
    func addFrom_Database_To_Main_Menu(){
        let day = String("StepsDay: \(day1)")
        let timeS = String("TimeDay: \(day1)")
        let email = Auth.auth().currentUser
        let user = ref.child("Users")
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
}

