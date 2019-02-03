//
//  ViewControllerSettings.swift
//  PhoneLess
//
//  Created by Joel Vangente on 28/10/2018.
//  Copyright © 2018 Joel Vangente. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class ViewControllerSettings: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var lbl_new_quote: UITextField!
    
    var ref:DatabaseReference!
    var handle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
    }
    
    @IBAction func btn_add_image(_ sender: Any) {
        addImage()
    }
    @IBAction func btn_set_new_quote(_ sender: Any) {
        if lbl_new_quote.text != ""{
            user.child((email?.uid)!).child("Own Quote").setValue(lbl_new_quote.text)
            lbl_new_quote.text = ""
        }else{
            lbl_new_quote.placeholder = "Please add a quote here!"
        }
    }
    
    func addImage(){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        picker.dismiss(animated: true, completion: nil)
        var data = Data()
        data = image.jpegData(compressionQuality: 0.5)!
        
        let imageRef = Storage.storage().reference().child((email?.uid)!).child("Images/Number1")
        
        _ = imageRef.putData(data, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                return
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
