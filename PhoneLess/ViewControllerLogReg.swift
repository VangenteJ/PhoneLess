//
//  ViewControllerLogReg.swift
//  PhoneLess
//
//  Created by Joel Vangente on 28/10/2018.
//  Copyright © 2018 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth


class ViewControllerLogReg: UIViewController {

    @IBOutlet weak var flipSignReg: UISegmentedControl!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var reEnterPasswordField: UITextField!
    @IBOutlet weak var loginRegisterBtn: UIButton!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblReenterPassword: UILabel!
    @IBOutlet weak var btnforgotpassword: UIButton!
    @IBOutlet weak var signInRegister: UILabel!
    var user:DatabaseReference!
    
    
    
    var isSigned = true
    
    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    
    //Calling sign in function
    //To show sign in option first
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        signIN()

        // Do any additional setup after loading the view.
    }
    //Change what shows when sign in or register is selected
    @IBAction func flipLoginRegister(_ sender: Any) {
        isSigned = !isSigned
        if isSigned{
            signIN()
            emailField.text = ""
            passwordField.text = ""
        }else{
            register()
            emailField.text = ""
            passwordField.text = ""
            reEnterPasswordField.text = ""
        }
    }
    //Log and register the user into the app
    @IBAction func btnLoginRegister(_ sender: Any) {
        if let email1 = emailField.text, let pass = passwordField.text{
            if isSigned{
                Auth.auth().signIn(withEmail: email1, password: pass) { (user, error) in
                    if user != nil{
                        //Redirect to menu after succesful log in/Register
                        self.performSegue(withIdentifier: "logReg", sender: self)
                    }else{
                        //Change sign in/register label color to red if wrong login/Register
                        self.signInRegister.textColor = UIColor.red
                        self.signInRegister.text = "Please make sure you are entering the right details!"
                    }
                }
            }else{
                let pas2 = reEnterPasswordField.text
                Auth.auth().createUser(withEmail: email1, password: pass) { (user, error) in
                    if user != nil && pas2 == pass{
                        
                        self.ref.child("Admin").child((email?.uid)!).child("Access").setValue("No")
                        self.ref.child("Users").child((email?.uid)!).child("Loop").setValue("1")
                        self.ref.child("Users").child((email?.uid)!).child("Total Steps").setValue("0")
                        self.performSegue(withIdentifier: "logReg", sender: self)
                    }else{
                        //Change sign in/register label color to red if wrong login/Register
                        self.signInRegister.textColor = UIColor.red
                        self.signInRegister.text = "Email either invalid or already in use or too short password! Password must be at least 6 characters long!"
                    }
                }
            }
        }
    }
    
    //Hide fields that are meant only to show when register is selected
    //Change Sign in/Register label color to black
    func signIN(){
        self.signInRegister.textColor = UIColor.black
        signInRegister.text = "Sign In"
        lblReenterPassword.isHidden = true
        reEnterPasswordField.isHidden = true
        loginRegisterBtn.setTitle("Sign In", for: .normal)
        btnforgotpassword.isHidden = false
    }
    
    @IBAction func forgot_password(_ sender: Any) {
        self.performSegue(withIdentifier: "reset_pass", sender: self)
    }
    
    //Show all sign in fields + fields that are meant to show for registering
    //Change Sign in/Register label color to black
    func register(){
        self.signInRegister.textColor = UIColor.black
        signInRegister.text = "Register"
        lblReenterPassword.isHidden = false
        reEnterPasswordField.isHidden = false
        loginRegisterBtn.setTitle("Register", for: .normal)
        btnforgotpassword.isHidden = true
    }
    
    //Dismiss virtual keyboard by touching anywhere within the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        reEnterPasswordField.resignFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if checknet.connection(){}else{
            let noNet = self.storyboard?.instantiateViewController(withIdentifier: "connection") as! ConnectionViewController
            self.present(noNet , animated: true, completion: nil)
        }
    }
}
