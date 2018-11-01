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
    
    var ref:DatabaseReference!
    
    var day1 = 1

//Add database reference
//Add info into database
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //self.addToDatabase()
//Check if user is loged in and redirect if not logged in
        if Auth.auth().currentUser != nil{}else{
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
        user.child((email?.uid)!).child(day).setValue("Cooloooooooo")
        user.child((email?.uid)!).child(timeS).setValue("10 Minuuuuutas")
        
    }
}

