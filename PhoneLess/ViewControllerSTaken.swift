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

class ViewControllerSTaken: UIViewController {

    @IBOutlet weak var segment_Display_Day_Week_Month_Years: UISegmentedControl!
    @IBOutlet weak var lblDisplay_Steps_On_Days_week_month_years: UILabel!
    @IBOutlet weak var lblCurrentSteps: UILabel!
    @IBOutlet weak var stepsTo_next_Level: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    var day1 = 1
    var ref: DatabaseReference!
    
    let activity_Manager = CMMotionActivityManager()
    let pedometer = CMPedometer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

    }
    
    func stepCounter(){
        pedometer.startUpdates(from: Date()) { (data, error) in
            if error == nil{
                DispatchQueue.main.async {
                    self.lblCurrentSteps.text = data?.numberOfSteps.stringValue
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
    
    func addToDatabase(){
        let day = String("StepsDay: \(day1)")
        let timeS = String("TimeDay: \(day1)")
        let email = Auth.auth().currentUser
        let user = ref.child("Users")
        user.child((email?.uid)!).child(day).setValue(lblCurrentSteps.text)
        user.child((email?.uid)!).child(timeS).setValue("10 Minuuuuutas")
        
    }

}
