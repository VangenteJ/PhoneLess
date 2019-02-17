//
//  AdminViewController.swift
//  PhoneLess
//
//  Created by Joel Vangente on 15/02/2019.
//  Copyright © 2019 Joel Vangente. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AdminViewController: UIViewController {

    @IBOutlet weak var segChallenge_category: UISegmentedControl!
    @IBOutlet weak var segQuote_category: UISegmentedControl!
    @IBOutlet weak var segChallenges: UISegmentedControl!
    @IBOutlet weak var segQuotes: UISegmentedControl!
    
    @IBOutlet weak var txtChallenge: UITextField!
    @IBOutlet weak var txtQuote: UITextField!
    
    @IBOutlet weak var btnChallenge_change: UIButton!
    @IBOutlet weak var btnQuote_change: UIButton!
    
    @IBOutlet weak var lblNewChallenge: UILabel!
    @IBOutlet weak var lblNewQuote: UILabel!
    
    @IBOutlet weak var lblMaintenance: UILabel!
    @IBOutlet weak var btnMaintenance: UIButton!
    
    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        maintenanceStatusMessage()
    }
    
    @IBAction func change_challenge(_ sender: Any) {
        handlingChallenges()
    }
    
    @IBAction func change_quote(_ sender: Any) {
        handlingQuotes()
    }
    
    @IBAction func maintenanceOnOff(_ sender: Any) {
        if lblMaintenance.text == "Maintenance mode activated!"{
            ref.child("Maintenance").child("Status").setValue("OFF")
        }else{
            ref.child("Maintenance").child("Status").setValue("ON")
        }
    }
    
    func maintenanceStatusMessage(){
        handle = ref.child("Maintenance").child("Status").observe(.value, with: { (snapshot) in
            if snapshot.value as? String != nil{
                let status = snapshot.value as! String
                if status == "ON"{
                    self.lblMaintenance.text = "Maintenance mode activated!"
                }else{
                    self.lblMaintenance.text = "Maintenance mode deactivated!"
                }
            }
        })
    }
    
    
    func handlingChallenges(){
        if txtChallenge.text != ""{
            if segChallenge_category.selectedSegmentIndex==0{
                if segChallenges.selectedSegmentIndex==0{
                    ref.child("Challenge").child("Easy").child("C1").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==1{
                    ref.child("Challenge").child("Easy").child("C2").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==2{
                    ref.child("Challenge").child("Easy").child("C3").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==3{
                    ref.child("Challenge").child("Easy").child("C4").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }
                
            }else if segChallenge_category.selectedSegmentIndex==1{
                if segChallenges.selectedSegmentIndex==0{
                    ref.child("Challenge").child("Normal").child("C1").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==1{
                    ref.child("Challenge").child("Normal").child("C2").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==2{
                    ref.child("Challenge").child("Normal").child("C3").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==3{
                    ref.child("Challenge").child("Normal").child("C4").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }
                
            }else if segChallenge_category.selectedSegmentIndex==2{
                if segChallenges.selectedSegmentIndex==0{
                    ref.child("Challenge").child("Hard").child("C1").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==1{
                    ref.child("Challenge").child("Hard").child("C2").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==2{
                    ref.child("Challenge").child("Hard").child("C3").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==3{
                    ref.child("Challenge").child("Hard").child("C4").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }
                
            }else if segChallenge_category.selectedSegmentIndex==3{
                if segChallenges.selectedSegmentIndex==0{
                    ref.child("Challenge").child("Legend").child("C1").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==1{
                    ref.child("Challenge").child("Legend").child("C2").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==2{
                    ref.child("Challenge").child("Legend").child("C3").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }else if segChallenges.selectedSegmentIndex==3{
                    ref.child("Challenge").child("Legend").child("C4").setValue(txtChallenge.text)
                    lblNewChallenge.text = txtChallenge.text
                    txtChallenge.text = ""
                    
                }
            }
        }else{
            txtChallenge.placeholder = "Please insert details here"
        }
        
    }
    
    func handlingQuotes(){
        if txtQuote.text != ""{
            if segQuote_category.selectedSegmentIndex==0{
                if segQuotes.selectedSegmentIndex==0{
                    ref.child("Quote").child("Easy").child("Q1").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==1{
                    ref.child("Quote").child("Easy").child("Q2").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==2{
                    ref.child("Quote").child("Easy").child("Q3").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==3{
                    ref.child("Quote").child("Easy").child("Q4").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }
                
            }else if segQuote_category.selectedSegmentIndex==1{
                if segQuotes.selectedSegmentIndex==0{
                    ref.child("Quote").child("Normal").child("Q1").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==1{
                    ref.child("Quote").child("Normal").child("Q2").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==2{
                    ref.child("Quote").child("Normal").child("Q3").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==3{
                    ref.child("Quote").child("Normal").child("Q4").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }
                
            }else if segQuote_category.selectedSegmentIndex==2{
                if segQuotes.selectedSegmentIndex==0{
                    ref.child("Quote").child("Hard").child("Q1").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==1{
                    ref.child("Quote").child("Hard").child("Q2").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==2{
                    ref.child("Quote").child("Hard").child("Q3").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==3{
                    ref.child("Quote").child("Hard").child("Q4").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }
                
            }else if segQuote_category.selectedSegmentIndex==3{
                if segQuotes.selectedSegmentIndex==0{
                    ref.child("Quote").child("Legend").child("Q1").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==1{
                    ref.child("Quote").child("Legend").child("Q2").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==2{
                    ref.child("Quote").child("Legend").child("Q3").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }else if segQuotes.selectedSegmentIndex==3{
                    ref.child("Quote").child("Legend").child("Q4").setValue(txtQuote.text)
                    lblNewQuote.text = txtQuote.text
                    txtQuote.text = ""
                    
                }
                
            }
        }else{
            txtQuote.placeholder = "Please insert details here"
        }
    }
    
    

}
