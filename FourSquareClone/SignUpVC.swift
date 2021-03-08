//
//  ViewController.swift
//  FourSquareClone
//
//  Created by StarChanger on 06/09/2020.
//  Copyright © 2020 StarChanger. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    @IBAction func signInClicked(_ sender: Any) {
        
        if (userName.text != "" && userPassword.text != "") {
            PFUser.logInWithUsername(inBackground: userName.text!, password: userPassword.text!) { (user, error) in
                if (error != nil) {
                    self.showAlert(titleText: "Error", messageText: error?.localizedDescription ?? "Unknown error signing you in")
                } else {
                    //self.showAlert(titleText: "Sign-in successful", messageText: "Sign-in of user " + self.userName.text! + " successful")
                    self.performSegue(withIdentifier: "idToPlacesVC", sender: nil)
                }
            }
            
        } else {
            showAlert(titleText: "Username/Password problem", messageText: "Username/password can't be blank")
        }
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
       
        if (userName.text != "" && userPassword.text != "") {
            let parseUser = PFUser()
            parseUser.username = userName.text
            parseUser.password = userPassword.text
            
            parseUser.signUpInBackground { (itWasSuccessful, error) in
                if (error != nil) {
                    self.showAlert(titleText: "Error", messageText: "Signup failure")
                } else {                    
                    self.showAlert(titleText: "Success", messageText: "Signup successful" + itWasSuccessful.description)
                    self.showAlert(titleText: "Sign-in successful", messageText: "Sign-in of user " + self.userName.text! + " successful")
                    self.performSegue(withIdentifier: "idToPlacesVC", sender: nil)
                }
            }
            
        } else {
            showAlert(titleText: "Username/Password problem", messageText: "Username/password can't be blank")
        }
        
    }
        
    func showAlert(titleText: String, messageText: String) {
        
        let alertController = UIAlertController(title: titleText, message: messageText, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let parseObject =  PFObject(className: "Fruits")
//        parseObject["name"] = "Apple"
//        parseObject["calories"] = 100
//
//        parseObject["name"] = "Banana"
//        parseObject["calories"] = 150
//
//        parseObject.saveInBackground { (success, error) in
//            if (error != nil ) {
//                print(error?.localizedDescription)
//            } else {
//                print("Uploading suceeded!")
//            }
//        }
//
//        let query = PFQuery(className: "Fruits")
//        query.whereKey("calories", greaterThanOrEqualTo: 101)
//        query.findObjectsInBackground { (objects, error) in
//            if (error != nil) {
//                print(error?.localizedDescription)
//            } else {
//                print(objects)
//            }
//        }            
        
    }


}

